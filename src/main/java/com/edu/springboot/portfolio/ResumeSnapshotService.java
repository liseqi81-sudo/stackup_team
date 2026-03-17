package com.edu.springboot.portfolio;

import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Service;

import com.edu.springboot.jdbc.PortfolioSnapshotDTO;
import com.edu.springboot.jdbc.ResumeDTO;
import com.edu.springboot.jdbc.ResumeSkillDTO;
import com.edu.springboot.jdbc.UserDTO;
import com.edu.springboot.mapper.PortfolioMapper;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class ResumeSnapshotService {

    private final PortfolioMapper portfolioMapper;
    private final ObjectMapper objectMapper = new ObjectMapper();

    public ResumeSnapshotService(PortfolioMapper portfolioMapper) {
        this.portfolioMapper = portfolioMapper;
    }

    /**
     * user 기준으로 t6_resume 포트폴리오를 찾고,
     * 없으면 portfolio_new 생성 후,
     * 최신 DB 상태를 반영한 snapshot_json을 portfolio_snapshot에 새 버전으로 저장.
     */
    public long saveResumeSnapshot(UserDTO user) throws Exception {
        String userId = user.getUser_id();

        Long portfolioId = portfolioMapper.selectPortfolioIdByUserAndTemplate(userId, "t6_resume");

        if (portfolioId == null) {
            String slug = userId + "-resume";
            String title = "Resume Portfolio";

            portfolioMapper.insertPortfolioNew(
                    userId,
                    title,
                    "t6_resume",
                    slug,
                    "DRAFT"
            );

            portfolioId = portfolioMapper.selectPortfolioIdByUserAndTemplate(userId, "t6_resume");
        }

        ResumeDTO resume = buildResumeDTO(user);

        String snapshotJson = objectMapper.writeValueAsString(resume);

        // snapshot 새 버전 저장
        portfolioMapper.insertPortfolioSnapshot(portfolioId, snapshotJson);

        // 방금 저장된 최신 snapshot 반환
        PortfolioSnapshotDTO latest = portfolioMapper.selectLatestSnapshot(portfolioId);
        if (latest == null) {
            throw new IllegalStateException("snapshot 저장 후 최신 snapshot 조회에 실패했습니다.");
        }

        return latest.getSnapshotId();
    }

    /**
     * ResumeDTO 조립 규칙
     * 1) name/email/phone 은 UserDTO 우선
     * 2) headline/summary 등 자유입력 값은 이전 snapshot에서 이어받기
     * 3) skills/skillItems 는 user_skill + skill 조인 결과를 매번 새로 반영
     */
    public ResumeDTO buildResumeDTO(UserDTO user) throws Exception {
        String userId = user.getUser_id();

        ResumeDTO resume = new ResumeDTO();

        // 1. 기본 사용자 정보
        resume.setName(safe(user.getUser_name()));
        resume.setEmail(safe(user.getUser_email()));
        resume.setPhone(safe(user.getUser_phone()));
        resume.setLocation("Seoul, Korea");

        // 2. 기존 snapshot 있으면 headline/summary/기존 입력값 이어받기
        PortfolioSnapshotDTO latestSnapshot = portfolioMapper.selectLatestSnapshotByUserId(userId);

        if (latestSnapshot != null && latestSnapshot.getSnapshotJson() != null
                && !latestSnapshot.getSnapshotJson().isBlank()) {

            ResumeDTO oldResume = objectMapper.readValue(
                    latestSnapshot.getSnapshotJson(),
                    ResumeDTO.class
            );

            // 자유입력 성격 값 유지
            resume.setHeadline(safe(oldResume.getHeadline()));
            resume.setSummary(safe(oldResume.getSummary()));
            resume.setLocation(
                    isBlank(oldResume.getLocation()) ? "Seoul, Korea" : oldResume.getLocation()
            );

            // 아직 DB 연동 안 된 섹션들은 이전 snapshot 값 유지
            resume.setProjects(
                    oldResume.getProjects() == null ? Collections.emptyList() : oldResume.getProjects()
            );
            resume.setExperience(
                    oldResume.getExperience() == null ? Collections.emptyList() : oldResume.getExperience()
            );
            resume.setEducation(
                    oldResume.getEducation() == null ? Collections.emptyList() : oldResume.getEducation()
            );
            resume.setCertificationItems(
                    oldResume.getCertificationItems() == null ? Collections.emptyList() : oldResume.getCertificationItems()
            );
            resume.setSocialLinks(
                    oldResume.getSocialLinks() == null ? Collections.emptyList() : oldResume.getSocialLinks()
            );
            resume.setCertifications(
                    oldResume.getCertifications() == null ? Collections.emptyList() : oldResume.getCertifications()
            );
            resume.setContests(
                    oldResume.getContests() == null ? Collections.emptyList() : oldResume.getContests()
            );
            resume.setInterests(
                    oldResume.getInterests() == null ? Collections.emptyList() : oldResume.getInterests()
            );
            resume.setSelectedCertIds(
                    oldResume.getSelectedCertIds() == null ? Collections.emptyList() : oldResume.getSelectedCertIds()
            );
            resume.setSelectedContestIds(
                    oldResume.getSelectedContestIds() == null ? Collections.emptyList() : oldResume.getSelectedContestIds()
            );
        }

        // 3. headline / summary 기본값
        if (isBlank(resume.getHeadline())) {
            resume.setHeadline("My Resume");
        }
        if (isBlank(resume.getSummary())) {
            resume.setSummary("자기소개를 입력해주세요.");
        }

        // 4. user_skill → skill_name 반영 (1단계)
        List<String> skillNames = portfolioMapper.selectUserSkills(userId);
        resume.setSkills(skillNames == null ? Collections.emptyList() : skillNames);
        
        resume.setSkills(portfolioMapper.selectUserSkills(userId));
        resume.setSkillItems(portfolioMapper.selectUserSkillItems(userId));
        
        // 5. user_skill.user_level + skill.skill_name 반영 (2단계)
        List<ResumeSkillDTO> skillItems = portfolioMapper.selectUserSkillItems(userId);
        resume.setSkillItems(skillItems == null ? Collections.emptyList() : skillItems);

        // 디버깅용 로그
        System.out.println("[ResumeSnapshotService] userId = " + userId);
        System.out.println("[ResumeSnapshotService] headline = " + resume.getHeadline());
        System.out.println("[ResumeSnapshotService] skills = " + resume.getSkills());
        System.out.println("[ResumeSnapshotService] skillItems = " + resume.getSkillItems());
        
        System.out.println("=== SNAPSHOT SAVE DEBUG ===");
        System.out.println("userId = " + userId);
        System.out.println("skills = " + portfolioMapper.selectUserSkills(userId));
        System.out.println("skillItems = " + portfolioMapper.selectUserSkillItems(userId));
        
        return resume;
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    private String safe(String s) {
        return s == null ? "" : s;
    }
}