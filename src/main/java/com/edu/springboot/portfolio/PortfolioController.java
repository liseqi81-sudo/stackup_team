package com.edu.springboot.portfolio;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.springboot.jdbc.PortfolioNewDTO;
import com.edu.springboot.jdbc.PortfolioSnapshotDTO;
import com.edu.springboot.jdbc.ResumeDTO;
import com.edu.springboot.jdbc.UserDTO;
import com.edu.springboot.mapper.PortfolioMapper;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class PortfolioController {

    private final PortfolioMapper portfolioMapper;
    private final ResumeSnapshotService resumeSnapshotService;
    private final ObjectMapper objectMapper = new ObjectMapper();

    public PortfolioController(PortfolioMapper portfolioMapper,
                               ResumeSnapshotService resumeSnapshotService) {
        this.portfolioMapper = portfolioMapper;
        this.resumeSnapshotService = resumeSnapshotService;
    }

    @GetMapping("/resume.do")
    public String resume(HttpSession session, Model model) throws Exception {
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) return "redirect:/login.do";

        String userId = user.getUser_id();

        PortfolioSnapshotDTO snapshot = portfolioMapper.selectLatestSnapshotByUserId(userId);

        ResumeDTO resume = null;
        if (snapshot != null && snapshot.getSnapshotJson() != null) {
            resume = objectMapper.readValue(snapshot.getSnapshotJson(), ResumeDTO.class);
            applyUserInfo(resume, user);
        }

        model.addAttribute("resume", resume);
        return "portfolio/resume";
    }

    @GetMapping("/portfolio/dashboard.do")
    public String dashboard(HttpSession session, HttpServletResponse response, Model model) throws Exception {
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            response.setContentType("text/html; charset=UTF-8");
            java.io.PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('로그인이 필요한 서비스입니다.');");
            out.println("location.href='/login.do?backUrl=/portfolio/dashboard.do';");
            out.println("</script>");
            out.flush();
            return null;
        }

        String userId = user.getUser_id();

        List<PortfolioNewDTO> portfolios = portfolioMapper.selectPortfoliosByUserId(userId);

        Map<Long, PortfolioSnapshotDTO> latestMap = new HashMap<>();
        Map<Long, Integer> versionCountMap = new HashMap<>();

        for (PortfolioNewDTO p : portfolios) {
            Long pid = p.getPortfolioId();
            if (pid == null) continue;

            PortfolioSnapshotDTO latest = portfolioMapper.selectLatestSnapshot(pid);
            int cnt = portfolioMapper.countSnapshotsByPortfolioId(pid);

            latestMap.put(pid, latest);
            versionCountMap.put(pid, cnt);
        }

        ResumeDTO resume = null;
        PortfolioSnapshotDTO latestUserSnapshot = portfolioMapper.selectLatestSnapshotByUserId(userId);

        if (latestUserSnapshot != null && latestUserSnapshot.getSnapshotJson() != null) {
            resume = objectMapper.readValue(latestUserSnapshot.getSnapshotJson(), ResumeDTO.class);
            applyUserInfo(resume, user);
        }

        model.addAttribute("resume", resume);
        model.addAttribute("portfolios", portfolios);
        model.addAttribute("latestMap", latestMap);
        model.addAttribute("versionCountMap", versionCountMap);

        return "portfolio/dashboard";
    }

    @PostMapping("/portfolio/createResumePortfolio.do")
    public String createResumePortfolio(HttpSession session) throws Exception {
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) return "redirect:/login.do";

        // 포트폴리오 없으면 생성 + 첫 snapshot 저장
        resumeSnapshotService.saveResumeSnapshot(user);

        return "redirect:/portfolio/dashboard.do";
    }

    @PostMapping("/portfolio/snapshot/save.do")
    public String saveSnapshot(HttpSession session) throws Exception {
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) return "redirect:/login.do";

        resumeSnapshotService.saveResumeSnapshot(user);

        return "redirect:/portfolio/dashboard.do";
    }

    private void applyUserInfo(ResumeDTO resume, UserDTO user) {
        if (resume == null || user == null) return;

        if (user.getUser_name() != null && !user.getUser_name().isBlank()) {
            resume.setName(user.getUser_name());
        }
        if ((resume.getEmail() == null || resume.getEmail().isBlank()) && user.getUser_email() != null) {
            resume.setEmail(user.getUser_email());
        }
        if ((resume.getPhone() == null || resume.getPhone().isBlank()) && user.getUser_phone() != null) {
            resume.setPhone(user.getUser_phone());
        }
    }
    @PostMapping("portfolio/snapshot/update.do")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateSnapshot(
            @RequestBody PortfolioSnapshotUpdateRequest req,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        try {
            UserDTO user = (UserDTO) session.getAttribute("user");
            if (user == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return ResponseEntity.ok(result);
            }

            if (req == null || req.getPortfolioId() == null) {
                result.put("success", false);
                result.put("message", "portfolioId가 없습니다.");
                return ResponseEntity.ok(result);
            }

            if (req.getSnapshotJson() == null) {
                result.put("success", false);
                result.put("message", "저장할 snapshotJson 데이터가 없습니다.");
                return ResponseEntity.ok(result);
            }

            String snapshotJsonString = objectMapper.writeValueAsString(req.getSnapshotJson());

            int updated = portfolioMapper.updateLatestSnapshotJson(
                    req.getPortfolioId(),
                    user.getUser_id(),
                    snapshotJsonString
            );

            if (updated > 0) {
                result.put("success", true);
                result.put("message", "수정된 레쥬메가 저장되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "업데이트할 스냅샷을 찾지 못했습니다.");
            }

            return ResponseEntity.ok(result);

        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "서버 오류: " + e.getMessage());
            return ResponseEntity.ok(result);
        }
    }
}