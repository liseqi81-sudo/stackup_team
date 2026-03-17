package com.edu.springboot.portfolio;

import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.edu.springboot.jdbc.PortfolioNewDTO;
import com.edu.springboot.jdbc.PortfolioSnapshotDTO;
import com.edu.springboot.jdbc.ProjectDTO;
import com.edu.springboot.jdbc.ResumeDTO;
import com.edu.springboot.jdbc.UserDTO;
import com.edu.springboot.mapper.PortfolioMapper;

import jakarta.servlet.http.HttpSession;
import tools.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/portfolio")
public class PortfolioController_skip {

	private final PortfolioMapper portfolioMapper;
	private final ObjectMapper objectMapper = new ObjectMapper();

	public PortfolioController_skip(PortfolioMapper portfolioMapper) {
		this.portfolioMapper = portfolioMapper;
	}

	/**
	 * ✅ 내 포트폴리오 목록 (header/footer 유지 + 가운데 카드 목록) URL: /portfolio/myportfolio.do
	 */
	@GetMapping("/myportfolio.do")
	public String myPortfolio(HttpSession session, Model model) {
		UserDTO user = (UserDTO) session.getAttribute("user");
		if (user == null)
			return "redirect:/login.do";

		String userId = user.getUser_id(); // String

		List<PortfolioNewDTO> list = portfolioMapper.selectPortfoliosByUserId(userId);
		if (list == null)
			list = Collections.emptyList();

		model.addAttribute("list", list);

		// ✅ 절대 앞에 "/" 붙이지 말기 (// 때문에 Spring Security firewall에 걸림)
		// JSP: /WEB-INF/views/portfolio/myportfolio.jsp
		return "portfolio/myportfolio";
	}

	/**
	 * ✅ 포트폴리오 보기 (템플릿 렌더) URL: /portfolio/view.do?id=1
	 */
//	@GetMapping("/view.do")
	/*
	 * public String view(@RequestParam("id") long portfolioId, Model model) throws
	 * Exception {
	 * 
	 * PortfolioNewDTO portfolio = portfolioMapper.selectPortfolioById(portfolioId);
	 * 
	 * PortfolioSnapshotDTO snapshot =
	 * portfolioMapper.selectLatestSnapshot(portfolioId);
	 * 
	 * ResumeDTO resume;
	 * 
	 * if (snapshot == null || snapshot.getSnapshotJson() == null ||
	 * snapshot.getSnapshotJson().isBlank()) { resume = new ResumeDTO(); } else {
	 * resume = objectMapper.readValue(snapshot.getSnapshotJson(), ResumeDTO.class);
	 * }
	 * 
	 * 
	 * model.addAttribute("portfolio", portfolio); model.addAttribute("resume",
	 * resume);
	 * 
	 * // ✅ JSP: /WEB-INF/views/portfolio/templates/t1-tech.jsp return
	 * "portfolio/templates/t1-tech"; }
	 */
	/**
	 * ✅ 스냅샷 저장 (DB 최신 스킬/자격증/공모전 반영 후 snapshot INSERT) URL: POST
	 * /portfolio/snapshot/save.do
	 */
/*	@PostMapping("/snapshot/save.do")
	public String saveSnapshot(@RequestParam("id") long portfolioId, HttpSession session) throws Exception {

		UserDTO user = (UserDTO) session.getAttribute("user");
		if (user == null)
			return "redirect:/login.do";

		String userId = user.getUser_id(); // ✅ String

		// 1) 최신 스냅샷에서 사용자 입력(Experience/선택ID/소셜 등) 기반(base) 가져오기
		PortfolioSnapshotDTO latest = portfolioMapper.selectLatestSnapshot(portfolioId);

		ResumeDTO base;
		if (latest != null && latest.getSnapshotJson() != null && !latest.getSnapshotJson().isBlank()) {
			base = objectMapper.readValue(latest.getSnapshotJson(), ResumeDTO.class);
		} else {
			base = new ResumeDTO();
		}

		// 2) 자동 수집: skills는 항상 DB 최신으로 반영
		List<String> skills = portfolioMapper.selectUserSkills(userId);
		base.setSkills(skills);

		// 3) 자동 수집: cert/contest는 snapshot_json에 저장된 “선택된 ID” 기준으로 최신 이름 반영
		List<String> certNames = List.of();
		if (base.getSelectedCertIds() != null && !base.getSelectedCertIds().isEmpty()) {
			certNames = portfolioMapper.selectCertNamesByIds(base.getSelectedCertIds());
		}
		base.setCertifications(certNames);

		List<String> contestNames = List.of();
		if (base.getSelectedContestIds() != null && !base.getSelectedContestIds().isEmpty()) {
			contestNames = portfolioMapper.selectContestNamesByIds(base.getSelectedContestIds());
		}
		base.setContests(contestNames);

		// (선택) base.setEmail(user.getEmail()); 같은 자동 세팅을 여기에 추가해도 됨

		// 4) 새 스냅샷 저장
		String json = objectMapper.writeValueAsString(base);
		portfolioMapper.insertSnapshot(portfolioId, json);

		// ✅ redirect도 반드시 /portfolio 포함
		return "redirect:/portfolio/view.do?id=" + portfolioId + "&saved=1";
	}

	*//**
	 * ✅ 포트폴리오 생성 화면(템플릿 선택 페이지) URL: /portfolio/createportfolio.do
	 *//*
	@GetMapping("/createportfolio.do")
	public String createForm(HttpSession session) {
		UserDTO user = (UserDTO) session.getAttribute("user");
		if (user == null)
			return "redirect:/login.do";

		// JSP: /WEB-INF/views/portfolio/createportfolio.jsp
		return "portfolio/createportfolio";
	}*/

	/*
	 * @GetMapping("/resume.do") public String resume(HttpSession session, Model
	 * model) { UserDTO user = (UserDTO) session.getAttribute("user"); if (user ==
	 * null) return "redirect:/login.do";
	 * 
	 * String userId = user.getUser_id();
	 * 
	 * ResumeDTO resume = portfolioMapper.selectResumeHeader(userId);
	 * List<UserSkillDTO> skills = portfolioMapper.selectUserSkills(userId);
	 * List<ProjectDTO> projects = portfolioMapper.selectResumeProjects(userId);
	 * List<ExperienceDTO> activities =
	 * portfolioMapper.selectResumeActivities(userId); List<EducationDTO> educations
	 * = portfolioMapper.selectResumeEducations(userId); List<CertifiDTO> certs =
	 * portfolioMapper.selectResumeCerts(userId);
	 * 
	 * model.addAttribute("user", user); model.addAttribute("resume", resume);
	 * model.addAttribute("skills", skills); model.addAttribute("projects",
	 * projects); model.addAttribute("activities", activities);
	 * model.addAttribute("educations", educations); model.addAttribute("certs",
	 * certs);
	 * 
	 * return "portfolio/resume"; }
	 */
}