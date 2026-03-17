package com.edu.springboot;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.edu.springboot.jdbc.JobSeekerContactDTO;
import com.edu.springboot.jdbc.JobSeekerDTO;

import com.edu.springboot.jdbc.UserDTO;
// import com.edu.springboot.mapper.JobSeekerContactMapper; // 🚩 삭제됨
import com.edu.springboot.mapper.JobSeekerMapper;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/jobseeker")
public class JobSeekerController {

    private final JobSeekerMapper seekerMapper;

    // 🚩 생성자에서 seekerMapper 하나만 주입받도록 수정
    @Autowired
    public JobSeekerController(JobSeekerMapper seekerMapper) {
        this.seekerMapper = seekerMapper;
    }

    
    @GetMapping("/seekerlist.do")
    public String list(
        @RequestParam(value="keyword", required=false) String keyword,
        @RequestParam(value="category", required=false, defaultValue="ALL") String category,
        // pageNum은 이제 DataTable이 내부적으로 관리하므로 필수는 아니지만 유지해도 무방합니다.
        Model model
    ) {
        // 🚩 수정: offset과 pageSize를 넘기지 않고 전체 리스트를 가져옵니다.
        // (Mapper 인터페이스와 XML에서도 이 파라미터들을 제거해야 합니다)
        List<JobSeekerDTO> list = seekerMapper.selectAll(keyword, category); 
        
        int totalCount = seekerMapper.countList(keyword, category);
        
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("seekerList", list); // 이제 112개가 통째로 JSP로 갑니다.
        model.addAttribute("keyword", keyword);
        model.addAttribute("category", category);
        
        return "jobseeker/seekerlist";
    }

    // 🔍 인재 상세
    @GetMapping("/seekerdetail.do")
    public String detail(@RequestParam("seekId") int seekId, Model model) {
        JobSeekerDTO dto = seekerMapper.selectOne(seekId);
        model.addAttribute("seeker", dto); 
        return "jobseeker/seekerdetail";
    }

    // ✍ 등록 폼
    @GetMapping("/seekerwrite.do")
    public String writeForm(HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) return "redirect:/login.do";

        // 기존 중복 코드를 정리하고 권한 체크 로직 통합
        String type = user.getUser_type();
        if (!"SEEKER".equalsIgnoreCase(type) && !"USER".equalsIgnoreCase(type)) {
            return "redirect:/jobseeker/seekerlist.do";
        }
        
        return "jobseeker/seekerwrite"; // JSP 파일명과 일치해야 함
    }

    // ✍ 등록 처리
    @PostMapping("/seekerwrite.do")
    public String write(
            JobSeekerDTO dto,
            @RequestParam(value="skillsArr", required=false) List<String> skillsArr,
            @RequestParam(value="skillsEtc", required=false) String skillsEtc,
            HttpSession session
    ) {
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) return "redirect:/login.do";
        dto.setUserId(user.getUser_id());
        dto.setSkills(combineSkills(skillsArr, skillsEtc));
        seekerMapper.insert(dto);
        return "redirect:/jobseeker/seekerlist.do";
    }

    // ✏️ 수정 폼
    @GetMapping("/seekeredit.do")
    public String editForm(@RequestParam("seekId") int seekId, Model model, HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) return "redirect:/login.do";
        JobSeekerDTO seeker = seekerMapper.selectOne(seekId);
        if (seeker == null || !seeker.getUserId().equals(user.getUser_id())) {
            return "redirect:/jobseeker/seekerlist.do";
        }
        model.addAttribute("seeker", seeker);
        return "jobseeker/seekeredit";
    }

    // ✏️ 수정 처리
    @PostMapping("/seekeredit.do")
    public String edit(
            JobSeekerDTO dto,
            @RequestParam(value="skillsArr", required=false) List<String> skillsArr,
            @RequestParam(value="skillsEtc", required=false) String skillsEtc,
            HttpSession session
    ) {
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) return "redirect:/login.do";
        JobSeekerDTO origin = seekerMapper.selectOne(dto.getSeekId());
        if (origin == null || !origin.getUserId().equals(user.getUser_id())) {
            return "redirect:/jobseeker/seekerlist.do";
        }
        dto.setSkills(combineSkills(skillsArr, skillsEtc));
        dto.setUserId(origin.getUserId()); 
        seekerMapper.update(dto);
        return "redirect:/jobseeker/seekerdetail.do?seekId=" + dto.getSeekId();
    }

    // 🗑 삭제 처리
    @PostMapping("/seekerdelete.do")
    public String delete(@RequestParam("seekId") int seekId, HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) return "redirect:/login.do";
        JobSeekerDTO origin = seekerMapper.selectOne(seekId);
        if (origin != null && origin.getUserId().equals(user.getUser_id())) {
            seekerMapper.delete(seekId);
        }
        return "redirect:/jobseeker/seekerlist.do";
    }

    // 🤝 채용 제안 저장 (연락하기)
    @PostMapping("/contactSave.do")
    public String contactSave(JobSeekerContactDTO dto, HttpSession session) {
        UserDTO loginUser = (UserDTO) session.getAttribute("user");
        if (loginUser == null) return "redirect:/login.do";
        
        dto.setSenderId(loginUser.getUser_id());

        MultipartFile file = dto.getUploadFile();
        if (file != null && !file.isEmpty()) {
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            File saveDir = new File("C:/uploads/job_cards/");
            if(!saveDir.exists()) saveDir.mkdirs();
            
            try {
                file.transferTo(new File(saveDir, fileName));
                dto.setCardImg(fileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
        // 🚩 수정: contactMapper 대신 seekerMapper 사용
        seekerMapper.insertContact(dto);
        return "redirect:/jobseeker/seekerlist.do";
    }

    private String combineSkills(List<String> skillsArr, String skillsEtc) {
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
            sb.append(skillsEtc.trim());
        }
        return sb.toString();
    }
    
    @GetMapping("/contactDetail.do")
    public String contactDetail(@RequestParam("contactId") int contactId, Model model) {
    	
    	seekerMapper.updateReadDate(contactId);

        JobSeekerContactDTO contact = seekerMapper.getReceivedContactDetail(contactId);
        model.addAttribute("contact", contact);

        return "contectdetail";
    }
    
    
}