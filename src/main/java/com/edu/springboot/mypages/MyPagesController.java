package com.edu.springboot.mypages;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.edu.springboot.jdbc.IJobApplicationService;
import com.edu.springboot.jdbc.IMemberService;
import com.edu.springboot.jdbc.JobApplicationDTO;
import com.edu.springboot.jdbc.JobSeekerContactDTO;
import com.edu.springboot.jdbc.UserDTO;
import com.edu.springboot.mapper.JobSeekerMapper;

import jakarta.servlet.http.HttpSession;

@Controller
public class MyPagesController {

  @Autowired
  private IMemberService dao;
  
  @Autowired
  private JobSeekerMapper seekerMapper;
  
  @Autowired
  private IJobApplicationService jobApplicationMapper;

  @GetMapping("/mypage.do")
  public String mypage(HttpSession session, Model model) {

    UserDTO loginUser = (UserDTO) session.getAttribute("user");

    if (loginUser == null) {
      return "redirect:/login.do";
    }

    String loginId = loginUser.getUser_id();

    UserDTO user = dao.selectMyPage(loginId);
    model.addAttribute("user", user);

    // 개인회원: 받은 채용 제안 목록
    if ("USER".equals(loginUser.getUser_type())) {
      List<JobSeekerContactDTO> contactList = seekerMapper.getReceivedContacts(loginId);
      model.addAttribute("contactList", contactList);

      int unreadContactCount = seekerMapper.getUnreadContactCount(loginId);
      model.addAttribute("unreadContactCount", unreadContactCount);
    }

    // 기업회원: 내 공고 지원 목록
    if ("COMPANY".equals(loginUser.getUser_type())) {
      List<JobApplicationDTO> applicationList =
          jobApplicationMapper.selectApplicationsByCompany(loginId);

      model.addAttribute("applicationList", applicationList);
    }

    return "mypage";
  }
  
  @GetMapping("/mypageEdit.do")
  public String mypageEdit(HttpSession session, Model model) {

    UserDTO loginUser = (UserDTO) session.getAttribute("user");
    if (loginUser == null) {
      return "redirect:/login.do";
    }

    String userId = loginUser.getUser_id();
    UserDTO user = dao.selectMyPage(userId);
    model.addAttribute("user", user);

    return "mypageEdit";
  }

  @PostMapping("/mypageEdit.do")
  public String mypageEditProc(UserDTO form, HttpSession session, Model model) {

    UserDTO loginUser = (UserDTO) session.getAttribute("user");
    if (loginUser == null) {
      return "redirect:/login.do";
    }

    // ✅ 보안: 폼에서 넘어온 user_id 믿지 말고 세션 값으로 덮어쓰기
    form.setUser_id(loginUser.getUser_id());

    int result = dao.updateMyPage(form);

    if (result > 0) {
      // ✅ 세션 user도 최신 정보로 갱신(비번 제외 조회)
      UserDTO refreshed = dao.selectMyPage(loginUser.getUser_id());
      session.setAttribute("user", refreshed);
      return "redirect:/mypage.do";
    }

    model.addAttribute("msg", "수정에 실패했습니다. 다시 시도해주세요.");
    model.addAttribute("user", dao.selectMyPage(loginUser.getUser_id()));
    return "mypageEdit";
  }
}