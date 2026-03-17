package com.edu.springboot;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.edu.springboot.jdbc.JobPostingDTO;
import com.edu.springboot.jdbc.UserDTO;   // ✅ UserDTO로 통일
import com.edu.springboot.mapper.JobPostingMapper;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/jobposting")
public class JobPostingController {

    private final JobPostingMapper jobPostingMapper;

    public JobPostingController(JobPostingMapper jobPostingMapper) {
        this.jobPostingMapper = jobPostingMapper;
    }

    // 📄 목록
    @GetMapping("/joblist.do")
    public String list(
        @RequestParam(value="keyword", required=false) String keyword,
        @RequestParam(value="category", required=false, defaultValue="ALL") String category,
        Model model,
        HttpSession session
    ) {
    	UserDTO user = (UserDTO) session.getAttribute("user");
    	String userId = (user != null) ? user.getUser_id() : "";

    	List<JobPostingDTO> list = jobPostingMapper.selectAll(keyword, category, userId);

        model.addAttribute("list", list);
        model.addAttribute("keyword", keyword);
        model.addAttribute("category", category);

        return "jobposting/joblist";
    }

    // 🔍 상세
    @GetMapping("/jobdetail.do")
    public String detail(@RequestParam(value="postingId") String postingId, Model model) {
        JobPostingDTO dto = jobPostingMapper.selectOne(postingId);
        model.addAttribute("job", dto);
        return "jobposting/jobdetail";
    }

    // ✍ 작성 폼 (GET) - 기업만
    @GetMapping("/write.do")
    public String writeForm(HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user"); // ✅ 세션키 user
        if (user == null) return "redirect:/login.do";
        if (!"COMPANY".equals(user.getUser_type())) return "redirect:/jobposting/joblist.do";
        return "jobposting/jobwrite";
    }

    // ✍ 작성 처리 (POST) - 기업만 + skills 조합
    @PostMapping("/write.do")
    public String write(
            JobPostingDTO dto,
            @RequestParam(value="skillsArr", required=false) List<String> skillsArr,
            @RequestParam(value="skillsEtc", required=false) String skillsEtc,
            HttpSession session
    ) {
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) return "redirect:/login.do";
        if (!"COMPANY".equals(user.getUser_type())) return "redirect:/jobposting/joblist.do";

        dto.setWriterId(user.getUser_id());           // ✅ 작성자
//        dto.setPostingId(UUID.randomUUID().toString());// ✅ PK 생성(문자열 PK 가정)

        // skills 조합
        StringBuilder sb = new StringBuilder();
        if (skillsArr != null) {
            for (String s : skillsArr) {
                if (s != null && !s.trim().isEmpty()) {
                    if (sb.length() > 0) sb.append(", ");
                    sb.append(s.trim());
                }
            }
        }
        if (skillsEtc != null && !skillsEtc.trim().isEmpty()) {
            if (sb.length() > 0) sb.append(", ");
//            sb.append("기타: ").append(skillsEtc.trim());
            	sb.append(skillsEtc.trim());
        }
        dto.setSkills(sb.toString());

        jobPostingMapper.insert(dto);
        return "redirect:/jobposting/joblist.do";
    }

    // ✏️ 수정 폼 (GET) - 본인 글만
    @GetMapping("/jobedit.do")
    public String editForm(@RequestParam("postingId") String postingId,
                           Model model,
                           HttpSession session) {

        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) return "redirect:/login.do";
        if (!"COMPANY".equals(user.getUser_type())) return "redirect:/jobposting/joblist.do";

        JobPostingDTO job = jobPostingMapper.selectOne(postingId);
        if (job == null) return "redirect:/jobposting/joblist.do";

        if (job.getWriterId() == null || !job.getWriterId().equals(user.getUser_id())) {
            return "redirect:/jobposting/jobdetail.do?postingId=" + postingId; // ✅ url 통일
        }

        model.addAttribute("job", job);
        return "jobposting/jobedit";
    }

    // ✏️ 수정 처리 (POST) - 본인 글만
    @PostMapping("/jobedit.do")
    public String edit(JobPostingDTO dto,
                       @RequestParam(value="skillsArr", required=false) List<String> skillsArr,
                       @RequestParam(value="skillsEtc", required=false) String skillsEtc,
                       HttpSession session) {

        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) return "redirect:/login.do";
        if (!"COMPANY".equals(user.getUser_type())) return "redirect:/jobposting/joblist.do";

        JobPostingDTO origin = jobPostingMapper.selectOne(dto.getPostingId());
        if (origin == null) return "redirect:/jobposting/joblist.do";

        if (origin.getWriterId() == null || !origin.getWriterId().equals(user.getUser_id())) {
            return "redirect:/jobposting/jobdetail.do?postingId=" + dto.getPostingId();
        }

        // skills 조합
        StringBuilder sb = new StringBuilder();
        if (skillsArr != null) {
            for (String s : skillsArr) {
                if (s != null && !s.trim().isEmpty()) {
                    if (sb.length() > 0) sb.append(", ");
                    sb.append(s.trim());
                }
            }
        }
        if (skillsEtc != null && !skillsEtc.trim().isEmpty()) {
            if (sb.length() > 0) sb.append(", ");
            sb.append("기타: ").append(skillsEtc.trim());
        }
        dto.setSkills(sb.toString());

        dto.setWriterId(origin.getWriterId()); // ✅ 작성자 유지
        jobPostingMapper.update(dto);

        return "redirect:/jobposting/jobdetail.do?postingId=" + dto.getPostingId();
    }

    // 🗑 삭제 처리 (POST) - 본인 글만
    @PostMapping("/jobdelete.do")
    public String delete(@RequestParam("postingId") String postingId,
                         HttpSession session) {

        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) return "redirect:/login.do";
        if (!"COMPANY".equals(user.getUser_type())) return "redirect:/jobposting/joblist.do";

        JobPostingDTO origin = jobPostingMapper.selectOne(postingId);
        if (origin == null) return "redirect:/jobposting/joblist.do";

        if (origin.getWriterId() == null || !origin.getWriterId().equals(user.getUser_id())) {
            return "redirect:/jobposting/jobdetail.do?postingId=" + postingId;
        }

        jobPostingMapper.delete(postingId);
        return "redirect:/jobposting/joblist.do";
    }

    
}