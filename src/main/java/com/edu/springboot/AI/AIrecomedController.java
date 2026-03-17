package com.edu.springboot.AI;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.springboot.jdbc.AIrecomedDTO;
import com.edu.springboot.jdbc.UserDTO;
import com.edu.springboot.mapper.AIrecomedMapper;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class AIrecomedController {

	
	@Autowired
	IJobService jobService;
	
    @Autowired
    private AIrecomedMapper aiRecomedMapper;

    @RequestMapping("/airecommend.do")
    public String aiMain(Model model, HttpSession session, HttpServletResponse response) throws Exception {
    	
    	Object user = session.getAttribute("user");
        
        if (user == null) {
            // [backUrl 적용] 자바스크립트로 알림 후 로그인 페이지 이동
            response.setContentType("text/html; charset=UTF-8");
            java.io.PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('로그인이 필요한 서비스입니다.');");
            // 현재 페이지인 /airecommend.do를 backUrl로 전달
            out.println("location.href='/login.do?backUrl=/airecommend.do';"); 
            out.println("</script>");
            out.flush();
            return null; // 뷰를 리턴하지 않고 종료
        }
    	

        // 1. DB에서 스킬 목록 가져오기 (왼쪽 스킬 선택 셀렉트 박스용)
    	List<Map<String, Object>> allSkills = aiRecomedMapper.getAllSkills();
        model.addAttribute("allSkills", allSkills);
        
        // 2. JOB_ROLE에서 직무 목록 가져오기
        List<JobRoleDTO> jobList = jobService.getJobRoleList();

        List<AIrecomedDTO> tempRecommendList = new ArrayList<>();

        for (int i = 0; i < Math.min(5, jobList.size()); i++) {

            JobRoleDTO job = jobList.get(i);
            
            if (job == null) {
                System.out.println("jobList[" + i + "] is null");
                continue;
            }

            AIrecomedDTO dto = new AIrecomedDTO();
            dto.setJobName(job.getJobName());
            dto.setRequiredSpec("AI 분석중...");
            dto.setLackSpec("AI 분석중...");

            tempRecommendList.add(dto);
        }

        // JSP의 c:forEach에서 사용할 이름 'recommendList'
        model.addAttribute("recommendList", tempRecommendList);

        return "AI/AImain";
    }
    
    @ResponseBody
    @GetMapping("/loadUserSkills.do")
    public List<Map<String, Object>> loadUserSkills(HttpSession session) {
    	String userId = (String) session.getAttribute("userId"); 

        if (userId == null) {
            throw new RuntimeException("로그인이 필요합니다.");
        }

        return aiRecomedMapper.getUserSkills(userId);
    }
    
    
    @Autowired
    private AIRecommendService aiRecommendService;

    @ResponseBody
    @PostMapping("/analyzeJobs.do")
    public List<RecommendResultDTO> analyzeJobs(@RequestBody List<UserSkillRequestDTO> userSkills) {
      System.out.println("받은 userSkills 개수: " + userSkills.size());

      for (UserSkillRequestDTO skill : userSkills) {
        System.out.println("skill = " + skill.getName() + ", level = " + skill.getLevel());
      }

      return aiRecommendService.recommendJobs(userSkills);
    }
    
    @ResponseBody
    @PostMapping("/saveUserSkills.do")
    public String saveUserSkills(@RequestBody List<UserSkillRequestDTO> userSkills, HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            return "login";
        }

        String userId = user.getUser_id();

        try {
            aiRecommendService.saveUserSkills(userId, userSkills);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
    
    
    
    @Autowired
    private AIService aiService;
    
    @PostMapping("/saveRecommendedJob.do")
    @ResponseBody
    public String saveRecommendedJob(@RequestBody SaveRecommendedJobDTO dto, HttpSession session) {
      UserDTO loginUser = (UserDTO) session.getAttribute("user");

      if (loginUser == null) {
        return "login";
      }

      try {
        aiService.saveRecommendedJob(loginUser.getUser_id(), dto);
        return "success";
      } catch (Exception e) {
        e.printStackTrace();
        return "fail";
      }
    }
    
    @ResponseBody
    @PostMapping("/checkUserJob.do")
    public String checkUserJob(HttpSession session) {
        UserDTO loginUser = (UserDTO) session.getAttribute("user");

        if (loginUser == null) {
            return "login";
        }

        try {
            int exists = aiRecommendService.existsUserJob(loginUser.getUser_id());
            return exists > 0 ? "exists" : "not_exists";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
}