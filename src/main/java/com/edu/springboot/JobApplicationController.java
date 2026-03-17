package com.edu.springboot;

import java.io.File;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.edu.springboot.jdbc.IJobApplicationService;
import com.edu.springboot.jdbc.JobApplicationDTO;
import com.edu.springboot.jdbc.UserDTO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/jobapplication")
public class JobApplicationController {

    private final IJobApplicationService applicationDao;

    public JobApplicationController(IJobApplicationService applicationDao) {
        this.applicationDao = applicationDao;
    }

    @PostMapping("/apply.do")
    public String applyJob(
        @RequestParam("postingId") String postingId,
        @RequestParam("applyTitle") String applyTitle,
        @RequestParam("applyContent") String applyContent,
        @RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile,
        HttpSession session,
        RedirectAttributes rttr
    ) {

        UserDTO loginUser = (UserDTO) session.getAttribute("user");

        if (loginUser == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/login.do";
        }

        if (!"USER".equals(loginUser.getUser_type())) {
            rttr.addFlashAttribute("msg", "개인회원만 지원할 수 있습니다.");
            return "redirect:/jobposting/jobdetail.do?postingId=" + postingId;
        }

        String userId = loginUser.getUser_id();

        int dup = applicationDao.checkDuplicateApplication(userId, postingId);
        if (dup > 0) {
            rttr.addFlashAttribute("msg", "이미 지원한 공고입니다.");
            return "redirect:/jobposting/jobdetail.do?postingId=" + postingId;
        }

        String savedFileName = null;

        try {
            if (uploadFile != null && !uploadFile.isEmpty()) {
                String originalName = uploadFile.getOriginalFilename();
                savedFileName = System.currentTimeMillis() + "_" + originalName;

                String savePath = session.getServletContext().getRealPath("/uploads");
                File dir = new File(savePath);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                uploadFile.transferTo(new File(savePath, savedFileName));
            }

            JobApplicationDTO dto = new JobApplicationDTO();
            dto.setUser_id(userId);
            dto.setPosting_id(postingId);
            dto.setApply_title(applyTitle);
            dto.setApply_content(applyContent);
            dto.setResume_file(savedFileName);

            applicationDao.insertApplication(dto);

            rttr.addFlashAttribute("msg", "지원이 완료되었습니다.");
            return "redirect:/jobposting/joblist.do";

        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("msg", "지원 중 오류가 발생했습니다.");
            return "redirect:/jobposting/jobdetail.do?postingId=" + postingId;
        }
    }
}