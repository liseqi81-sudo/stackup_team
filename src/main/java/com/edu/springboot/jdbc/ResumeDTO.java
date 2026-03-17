package com.edu.springboot.jdbc;

import java.util.List;

import lombok.Data;

@Data
public class ResumeDTO {
    private String name;
    private String email;
    private String phone;
    private String location;
    private String summary;
    private String headline;

    private List<String> skills;                  // 1단계: 단순 출력용
    private List<ResumeSkillDTO> skillItems;      // 2단계: level 반영용

    private List<String> certifications;
    private List<String> contests;

    private List<ProjectDTO> projects;
    private List<ExperienceDTO> experience;
    private List<EducationDTO> education;
    private List<String> interests;
    private List<CertifiDTO> certificationItems;
    private List<ContestDTO> contestItems;

    private List<SocialLinkDTO> socialLinks;

    private List<String> selectedCertIds;
    private List<String> selectedContestIds;
}