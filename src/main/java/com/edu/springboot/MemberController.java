package com.edu.springboot;

import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.edu.springboot.jdbc.IMemberService;
import com.edu.springboot.jdbc.UserDTO;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {

    @Autowired
    private IMemberService dao;

    @Autowired
    private JavaMailSender mailSender;

    @GetMapping("/login.do")
    public String login() {
        return "member/login";
    }

    @PostMapping("/login.do")
    public String loginProcess(UserDTO userDTO, HttpSession session, Model model,
            @RequestParam(value = "backUrl", required = false) String backUrl) {
        UserDTO loginUser = dao.loginCheck(userDTO);

        if (loginUser != null) {
            session.setAttribute("userId", loginUser.getUser_id());
            session.setAttribute("user", loginUser);
            session.setAttribute("userName", loginUser.getUser_name());

            if (backUrl != null && !backUrl.isEmpty()) {
                return "redirect:" + backUrl;
            }
            return "redirect:/main.do";
        } else {
        	model.addAttribute("error", "가입 처리 중 오류가 발생했습니다.");
            return "member/regist";
        }
    }

    @RequestMapping(value = "/regist.do", method = RequestMethod.GET)
    public String member1() {
        return "member/regist";
    }

 // 기존의 @PostMapping("/regist.do")와 @PostMapping("/registProcess.do")를 
 // 아래 하나의 메서드로 통합하세요!

 @PostMapping("/registProcess.do")
 public String registProcess(UserDTO userDTO, HttpSession session, Model model) {
     
     // 1. 기업 회원일 경우 필수값인 USER_NAME을 담당자 이름으로 채워줌 (에러 방지 핵심!)
     if ("COMPANY".equals(userDTO.getUser_type())) {
         if (userDTO.getUser_name() == null || userDTO.getUser_name().isEmpty()) {
             userDTO.setUser_name(userDTO.getManager_name());
         }
     }

     // 2. 디버깅을 위한 로그 출력 (콘솔에서 확인용)
     System.out.println("가입 시도 유저 타입: " + userDTO.getUser_type());
     System.out.println("가입 시도 이름(USER_NAME): " + userDTO.getUser_name());
     System.out.println("가입 시도 기업명: " + userDTO.getCompany_name());

     // 3. DB 저장 실행
     int result = dao.insertUser(userDTO);

     if (result == 1) {
         // 가입 성공 시 로그인 페이지로 리다이렉트
    	// [수정] 가입 성공 시 세션에 정보 저장 (자동 로그인)
         session.setAttribute("userId", userDTO.getUser_id());
         session.setAttribute("user", userDTO);
         session.setAttribute("userName", userDTO.getUser_name());
    	 
         return "redirect:/main.do";
     } else {
         // 실패 시 다시 가입 페이지로 (모델에 에러 메시지를 담아도 좋습니다)
         model.addAttribute("error", "가입 처리 중 오류가 발생했습니다.");
         return "member/regist";
     }
 }
    
    @GetMapping("/companyExtra.do")
    public String companyExtra() {
        return "member/companyExtra";
    }

    @PostMapping("/companyExtra.do")
    public String companyExtraProcess(UserDTO userDTO, HttpSession session) {
        UserDTO loginUser = (UserDTO) session.getAttribute("user");
        if (loginUser != null) {
            userDTO.setUser_id(loginUser.getUser_id());
            int result = dao.updateCompanyInfo(userDTO);
            if (result == 1) return "redirect:/skillup.do";
        }
        return "member/companyExtra";
    }

    @PostMapping("/checkId.do")
    @ResponseBody
    public String checkId(@RequestParam("user_id") String user_id) {
        int result = dao.checkId(user_id);
        return String.valueOf(result);
    }

    @GetMapping("/findId.do")
    public String findId() {
        return "member/findId";
    }

    @PostMapping("/findIdProcess.do")
    public String findIdProcess(@RequestParam("user_name") String user_name,
            @RequestParam("user_email") String user_email, Model model) {
        String foundId = dao.findId(user_name, user_email);
        if (foundId != null) {
            model.addAttribute("foundId", foundId);
            model.addAttribute("user_name", user_name);
            return "member/findIdResult";
        } else {
            model.addAttribute("error", "일치하는 정보가 없습니다.");
            return "member/findId";
        }
    }

    @GetMapping("/findPw.do")
    public String findPw() {
        return "member/findPw";
    }

    @PostMapping("/findPwProcess.do")
    public String findPwProcess(@RequestParam("user_name") String user_name, 
            @RequestParam("user_id") String user_id,
            @RequestParam("user_email") String user_email, Model model) {
        int count = dao.checkUserForPw(user_name, user_id, user_email);
        if (count > 0) {
            String tempPw = UUID.randomUUID().toString().substring(0, 8);
            dao.updatePw(user_id, tempPw);
            try {
                SimpleMailMessage message = new SimpleMailMessage();
                message.setTo(user_email);
                message.setSubject("[StackUp] 임시 비밀번호 발급");
                message.setText(user_name + "님, 임시 비밀번호는 [" + tempPw + "] 입니다.");
                mailSender.send(message);
                model.addAttribute("msg", "이메일로 임시 비밀번호를 발송했습니다.");
                return "member/login";
            } catch (Exception e) {
                model.addAttribute("error", "메일 발송 중 오류가 발생했습니다.");
                return "member/findPw";
            }
        } else {
            model.addAttribute("error", "입력 정보가 일치하지 않습니다.");
            return "member/findPw";
        }
    }
}