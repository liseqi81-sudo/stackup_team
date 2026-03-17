package com.edu.springboot.skillup;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.edu.springboot.jdbc.ISkillupService;
import com.edu.springboot.jdbc.UserIngDTO;
import com.edu.springboot.jdbc.UserSkillDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class SkillUpController {

    @Autowired
    private ISkillupService skillupService; 

    // 메인 페이지 로드
    @GetMapping("/skillup.do")
    public String mainPage(HttpSession session, HttpServletResponse response, Model model) throws Exception {
    	
    	Object user = session.getAttribute("user");
        
        if (user == null) {
            response.setContentType("text/html; charset=UTF-8");
            java.io.PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('로그인이 필요한 서비스입니다.');");
            out.println("location.href='/login.do?backUrl=/skillup.do';");
            out.println("</script>");
            out.flush();
            return null;
        }
        
        String userId = (String) session.getAttribute("userId"); 
        String userName = (String) session.getAttribute("userName");

        model.addAttribute("userSkillList", skillupService.selectUserSkillList(userId));
        model.addAttribute("allSkills", skillupService.selectAllSkills());
        model.addAttribute("savedItemList", skillupService.selectSavedItemList(userId));
        model.addAttribute("userIngList", skillupService.selectUserIngList(userId));
        model.addAttribute("userName", userName);
        model.addAttribute("userId", userId);
        model.addAttribute("mainExam", skillupService.selectMainExam(userId));

        // 추가
        UserJobDTO userJob = skillupService.selectUserJob(userId);
        model.addAttribute("userJob", userJob);

        if (userJob != null) {
            model.addAttribute("jobSkillList", skillupService.selectJobSkills(userJob.getJobName()));
        }
        return "skillup/skillupmain";
    }
        
    // 핵심 역량 스킬 업데이트
    @PostMapping("/skill/update.do")
    public String updateSkill(HttpSession session, HttpServletRequest request) {
        String userId = (String) session.getAttribute("userId");
        String[] skillIds = request.getParameterValues("skill_id");
        String[] skillLevels = request.getParameterValues("user_level");
        
        if (userId != null && skillIds != null) {
            skillupService.deleteUserSkills(userId); 
            for (int i = 0; i < skillIds.length; i++) {
                UserSkillDTO dto = new UserSkillDTO();
                dto.setUserId(userId);
                dto.setSkillId(skillIds[i]);
                int percent = Integer.parseInt(skillLevels[i]);
                int dbLevel = (int) Math.round(percent / 20.0);
                dto.setUserLevel(dbLevel);
                skillupService.insertUserSkill(dto);
            }
        }
        return "redirect:/skillup.do";
    }
    
    // 진행 중인 일정 개별 해제 (기존 Form 방식)
    @PostMapping("/skillup/ing/delete.do")
    public String deleteUserIng(@RequestParam("ingId") String ingId,
                                HttpSession session,
                                HttpServletResponse response) throws Exception {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) return "redirect:/login.do";

        Map<String, String> params = new HashMap<>();
        params.put("ingId", ingId);
        params.put("userId", userId);
        skillupService.deleteUserIngByUser(params);
        return "redirect:/skillup.do";
    }

    /**
     * [수정 완료] 진행 중인 일정 다중 삭제 (AJAX)
     */
    @PostMapping("/skillup/ing/deleteMultiple.do")
    @ResponseBody
    public String deleteMultipleIng(@RequestParam("ingIds") String ingIds, HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) return "login_required";
        
        try {
            if (ingIds != null && !ingIds.isEmpty()) {
                String[] idArray = ingIds.split(",");
                for (String ingId : idArray) {
                    Map<String, String> params = new HashMap<>();
                    params.put("ingId", ingId.trim()); // trim()으로 공백 제거
                    params.put("userId", userId);      // push -> put으로 수정 완료!
                    skillupService.deleteUserIngByUser(params);
                }
                return "success";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
        return "fail";
    }

    /**
     * [수정 완료] 즐겨찾기 다중 삭제 (AJAX)
     */
    @PostMapping("/skillup/favorite/delete.do")
    @ResponseBody
    public String deleteFavorites(@RequestParam("favIds") String favIds, HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) return "login_required";
        
        try {
            if (favIds != null && !favIds.isEmpty()) {
                String[] idArray = favIds.split(",");
                for (String targetId : idArray) {
                    // CERTI와 CONTEST 둘 다 삭제 시도
                    skillupService.removeFavorite(userId, targetId.trim(), "CERTI");
                    skillupService.removeFavorite(userId, targetId.trim(), "CONTEST");
                }
                return "success";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
        return "fail";
    }
    @PostMapping("/skillup/auth/simpleUpload.do")
    @ResponseBody
    public Map<String, Object> simpleUpload(@RequestParam("ingId") String ingId, 
                                            @RequestParam("uploadFiles") List<MultipartFile> uploadFiles) {
        Map<String, Object> result = new HashMap<>();
        try {
            UserIngDTO vo = skillupService.getIngInfo(ingId); 
            
            if (vo != null) {
                int dDay = vo.getDayLeft(); // 여기서 19가 나와야 합니다.
                
                // 디버깅용 (콘솔에서 반드시 확인하세요)
                System.out.println(">>> 가져온 시험날짜: " + vo.getExamDate());
                System.out.println(">>> 계산된 D-Day: " + dDay);

                if (dDay > 0) {
                    double currentStatus = (double)vo.getStatus();
                    // 100 / 19 = 약 5.26%
                    double increment = 100.0 / dDay;
                    
                    double newStatus = currentStatus + increment;
                    if (newStatus > 100) newStatus = 100;

                    vo.setStatus((int)Math.round(newStatus));
                    skillupService.updateStatus(vo);

                    result.put("success", true);
                    result.put("newStatus", vo.getStatus());
                } else {
                    // dDay가 0이거나 음수면 이미 시험일이 지났거나 데이터를 못 읽은 것
                    result.put("success", false);
                    result.put("msg", "남은 기간을 계산할 수 없습니다. (D-Day: " + dDay + ")");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
        }
        return result;
    }
}