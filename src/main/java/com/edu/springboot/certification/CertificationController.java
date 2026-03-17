package com.edu.springboot.certification;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.springboot.jdbc.CertifiDTO;
import com.edu.springboot.jdbc.ICertifiService;
import com.edu.springboot.jdbc.UserDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class CertificationController {

    @Autowired
    ICertifiService dao;

    // 1. 자격증 리스트 조회 (비로그인 허용)
    @RequestMapping("/certification.do")
    public String certList(Model model, HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");
        
        // 유저 정보가 없으면 빈 문자열, 있으면 ID 추출
        String userId = (user != null) ? user.getUser_id() : "";

        // 전체 리스트 및 카테고리 정보 조회 (비로그인 시 userId가 ""이므로 즐겨찾기 표시 안됨)
        List<CertifiDTO> list = dao.certifiList(userId);
        
        List<Map<String, Object>> catList = dao.getTypeCounts();

        model.addAttribute("catList", catList);
        model.addAttribute("cList", list);
        
        // JSP에서 로그인 여부를 스크립트로 체크하기 위해 추가
        model.addAttribute("isLoggedIn", user != null); 

        return "certifi/clist";
    }

    // 2. 즐겨찾기 컨트롤 (로그인 필수)
    @RequestMapping("/favorite.do")
    @ResponseBody
    public String favoriteControl(HttpServletRequest request, HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");
        
        // [수정] 세션 없으면 JS에서 인지할 수 있도록 "login" 반환
        if (user == null) return "login";

        String userId = user.getUser_id();
        String action = request.getParameter("action");
        String targetId = request.getParameter("targetId");
        String type = request.getParameter("type");

        if ("add".equals(action)) {
            dao.addFavorite(userId, targetId, type);
        } else if ("remove".equals(action)) {
            dao.removeFavorite(userId, targetId, type);
        }

        return "success";
    }
    
    // 3. 스킬업(진행 중인 일정) 추가 (로그인 필수)
    @RequestMapping("/skillupexamadd.do")
    @ResponseBody
    public String skillupControl(HttpServletRequest request, HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");
        
        // [수정] 세션 없으면 JS에서 인지할 수 있도록 "login" 반환
        if (user == null) return "login";

        String userId = user.getUser_id();
        String action = request.getParameter("action");
        String targetId = request.getParameter("targetId");
        String type = request.getParameter("type");

        if (targetId == null || targetId.trim().isEmpty()) {
            return "targetIdNull";
        }

        if ("add".equals(action)) {
            int cnt = dao.checkUserIng(userId, targetId, type);
            if (cnt > 0) return "dup";

            int result = dao.addUserIng(userId, targetId, type, 0);
            return result > 0 ? "addSuccess" : "addFail";
        } 
        else if ("remove".equals(action)) {
            int result = dao.removeUserIng(userId, targetId, type);
            return result > 0 ? "removeSuccess" : "removeFail";
        }

        return "invalidAction";
    }
}