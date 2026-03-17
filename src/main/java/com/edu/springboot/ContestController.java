package com.edu.springboot;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.springboot.jdbc.ContestDTO;
import com.edu.springboot.jdbc.UserDTO;
import com.edu.springboot.mapper.ContestMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ContestController {

    private final ContestMapper contestMapper;

    public ContestController(ContestMapper contestMapper) {
        this.contestMapper = contestMapper;
    }

    @GetMapping("/contest/contestlist.do")
    public String list(
        @RequestParam(value="keyword", required=false) String keyword,
        @RequestParam(value="category", required=false, defaultValue="ALL") String category,
        @RequestParam(value="sort", required=false, defaultValue="deadline") String sort,
        Model model,
        HttpSession session
    ){
        List<String> categoryList = contestMapper.selectCategoryList();
        model.addAttribute("categoryList", categoryList);

        // 로그인 유저 아이디
        UserDTO user = (UserDTO) session.getAttribute("user");
        String userId = (user != null) ? user.getUser_id() : "";

        // userId를 함께 넘김
        List<ContestDTO> list = contestMapper.selectList(keyword, category, sort, userId);
        model.addAttribute("contestList", list);

        model.addAttribute("keyword", keyword);
        model.addAttribute("category", category);
        model.addAttribute("sort", sort);

        return "contest/contestlist";
    }
    
    @GetMapping("/contest/skillup.do")
    @ResponseBody
    public String contestSkillupControl(HttpServletRequest request, HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) return "login";

        String userId = user.getUser_id();
        String action = request.getParameter("action");
        String targetId = request.getParameter("targetId");
        String type = request.getParameter("type");

        if (targetId == null || targetId.trim().isEmpty()) {
            return "targetIdNull";
        }

        if ("add".equals(action)) {
            int cnt = contestMapper.checkUserIng(userId, targetId, type);
            if (cnt > 0) return "dup";

            int result = contestMapper.addUserIng(userId, targetId, type, 0);
            return result > 0 ? "addSuccess" : "addFail";
        } 
        else if ("remove".equals(action)) {
            int result = contestMapper.removeUserIng(userId, targetId, type);
            return result > 0 ? "removeSuccess" : "removeFail";
        }

        return "invalidAction";
    }
}