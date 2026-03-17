package com.edu.springboot;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.edu.springboot.jdbc.BoardDTO;
import com.edu.springboot.jdbc.CertifiDTO;
import com.edu.springboot.jdbc.IBoardService;
import com.edu.springboot.jdbc.ICertifiService;
import com.edu.springboot.jdbc.ISkillupService;
import com.edu.springboot.jdbc.JobPostingDTO;
import com.edu.springboot.mapper.ContestMapper;
import com.edu.springboot.mapper.JobPostingMapper;
import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {

    private final ICertifiService certifidao;
    private final ContestMapper contestMapper;
    private final JobPostingMapper jobPostingMapper;
    private final IBoardService boardService;
    private final ISkillupService skillupService; // 주입용 필드

    // 생성자 주입: 모든 서비스와 매퍼를 스프링으로부터 받습니다.
    public MainController(
          ContestMapper contestMapper,
          JobPostingMapper jobPostingMapper,
          ICertifiService certifidao,
          IBoardService boardService,
          ISkillupService skillupService 
      ) {
        this.contestMapper = contestMapper;
        this.jobPostingMapper = jobPostingMapper;
        this.certifidao = certifidao;
        this.boardService = boardService;
        this.skillupService = skillupService;
    }

    @GetMapping({ "/", "/main.do" })
    public String main(Model model, HttpSession session) {
        
        // 1. 공용 데이터 조회
        List<JobPostingDTO> topJobs = jobPostingMapper.selectTop5();
        model.addAttribute("topJobs", topJobs);
        model.addAttribute("contestList", contestMapper.selectTop6());
        
        List<CertifiDTO> popularList = certifidao.selectTop5PopularCerti();
        int[] rankChange = {1, -1, 2, 0, -2};
        model.addAttribute("popularList", popularList);
        model.addAttribute("rankChange", rankChange);
        
        List<CertifiDTO> deadlineList = certifidao.selectTop5Deadline();
        model.addAttribute("deadlineList", deadlineList);
        
        List<BoardDTO> reviewList = boardService.getTopReviews();
        model.addAttribute("reviewList", reviewList);
        
        // 2. 로그인 사용자별 개인 데이터 조회
        String userId = (String) session.getAttribute("userId");
        if (userId != null) {            
            // D-Day 정보와 진행 리스트를 모델에 담음
            model.addAttribute("mainExam", skillupService.selectMainExam(userId));
            model.addAttribute("userIngList", skillupService.selectUserIngList(userId));
        }
        
        return "main";
    }

	

	@RequestMapping("/purpose.do")
	public String purpose() {
		return "purpose";
	}

	@RequestMapping("/portfolioGuide.do")
	public String portfolioGuide() {
		return "portfolioGuide";
	}

	@GetMapping("/contest/listMain.do")
	public String contestListMain() {
		return "redirect:/contest/contestlist.do";
	}

	// 로그아웃
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate(); // 세션 전체 삭제
		return "redirect:/main.do";
	}
	
	
	
	

//    @GetMapping("/contest/list.do")
//    public String contestList(Model model) {
//
//        // 전체 공모전 목록 조회 (최신/마감순 등은 Mapper에서 정해도 됨)
//        List<ContestDTO> contestList = contestMapper.selectAll();
//
//        model.addAttribute("contestList", contestList);
//
//        // views/contest/contestList.jsp 로 이동
//        return "contest/contestList";
//    }
}