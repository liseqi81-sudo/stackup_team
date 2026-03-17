package com.edu.springboot;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.edu.springboot.jdbc.IQnaService;
import com.edu.springboot.jdbc.QnaDTO;
import com.edu.springboot.jdbc.QnaCommentDTO;
import com.edu.springboot.jdbc.UserDTO;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;

@Controller
public class QnaController {

    @Autowired
    private IQnaService qnaDao;

    // 리스트 보기
    @GetMapping("/qnaList.do")
    public String qnaList(HttpServletRequest req, Model model) {
        // 1. [수정] 검색어 파라미터는 그대로 두되, 페이징 계산 로직은 삭제합니다.
        // DataTable이 검색 기능도 대신해주므로 사실 검색어도 필수는 아니에요!
        
        // 2. [핵심] 10개씩 끊어오는 getQnaList 대신, 전체를 가져오는 메서드를 호출합니다.
        // (만약 IQnaService에 전체조회 메서드가 없다면 아래 2번 항목을 참고해서 만드세요!)
        List<QnaDTO> qnaList = qnaDao.getAllQnaList(); 
        
        model.addAttribute("qnaList", qnaList);

        return "qna/qnaList"; 
    }
    
    // 상세보기
    @GetMapping("/qnaView.do")
    public String qnaView(@RequestParam("qna_idx") int qna_idx, 
            HttpSession session, 
            HttpServletRequest req, 
            HttpServletResponse resp, 
            Model model) {

    	// 1. 로그인 체크
    	UserDTO user = (UserDTO) session.getAttribute("user");
    	if (user == null) {
    		return "redirect:/login.do";
    	}

    	// 2. 조회수 중복 차단 로직 (쿠키 활용)
    	Cookie[] cookies = req.getCookies();
    	boolean hasVisited = false;

    	if (cookies != null) {
    		for (Cookie cookie : cookies) {
    			if (cookie.getName().equals("qna_view_" + qna_idx)) {
    				hasVisited = true;
    				break;
    			}
    		}
    	}

    	if (!hasVisited) {
    		// 처음 방문 시에만 DB 조회수 증가
    		qnaDao.updateQnaCount(qna_idx);

    		// 해당 게시글 전용 쿠키 생성 (24시간 유지)
    		Cookie newCookie = new Cookie("qna_view_" + qna_idx, "true");
    		newCookie.setMaxAge(60 * 60 * 24); 
    		newCookie.setPath("/"); 
    		resp.addCookie(newCookie);
    	}

    	// 3. 게시글 상세 데이터 가져오기 (Join 쿼리가 적용된 Mapper 활용)
    	QnaDTO dto = qnaDao.getQnaDetail(qna_idx);

    	// 4. 데이터 검증 (디버깅 로그)
    	if(dto != null) {
    		System.out.println("[QnA 상세] 번호: " + dto.getQna_idx() + " | 이름: " + dto.getUser_name());
    	}

    	// 5. 모델 바인딩 (JSP에서 qnaDTO와 commentList로 사용)
    	model.addAttribute("qnaDTO", dto);
    	model.addAttribute("commentList", qnaDao.getCommentList(qna_idx));

    	return "qna/qnaView";
    }
    
 // 질문 작성 폼으로 이동 (GET 방식)
    @GetMapping("/qnaWrite.do")
    public String qnaWriteForm(HttpSession session) {
        // [로그인 체크] 글쓰기 페이지 진입 전 한 번 더 확인!
        if (session.getAttribute("user") == null) {
            return "redirect:/login.do";
        }
        return "qna/qnaWrite"; // views/qna/qnaWrite.jsp를 찾아감
    }

    // 질문 저장 처리 (POST 방식)
    @PostMapping("/qnaWrite.do")
    public String qnaWrite(QnaDTO qnaDTO, HttpSession session) {
        // 1. 세션에서 로그인 아이디 가져오기
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user != null) {
        	System.out.println("2. 로그인 유저 확인: " + user.getUser_id());
            qnaDTO.setUser_id(user.getUser_id());
        }
        
        else {
            System.out.println("2. 로그인 유저 없음 (null)");
            qnaDTO.setUser_id("guest"); // 임시 아이디
        }

        System.out.println("3. DB 저장 시도 직전...");
        qnaDao.qnaWrite(qnaDTO); 
        System.out.println("4. DB 저장 완료!"); // <-- 여기까지 찍히나 확인!

        return "redirect:/qnaList.do";
    }
    
    // 답변 쓰기
    @PostMapping("/commentWrite.do")
    public String commentWrite(QnaCommentDTO commentDTO, HttpSession session) {
        // 1. 로그인 체크
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.do";
        }

        // 2. 답변 작성자 설정 (로그인한 사람의 ID)
        commentDTO.setUser_id(user.getUser_id());
        
        // 3. DB 저장 (답변 테이블에 Insert)
        int result = qnaDao.commentWrite(commentDTO); 
        
        if(result > 0) {
            // 4. 답변이 성공적으로 달렸다면, 질문의 상태를 '완료'로 변경!
            qnaDao.updateQnaStatus(commentDTO.getQna_idx()); 
        }
        
        // 5. 다시 상세보기 페이지로 이동 (작성한 답변 바로 확인 가능)
        return "redirect:/qnaView.do?qna_idx=" + commentDTO.getQna_idx();
    }
    
 // 질문 수정 폼으로 이동 (GET)
    @GetMapping("/qnaEdit.do")
    public String qnaEditForm(@RequestParam("qna_idx") int qna_idx, Model model) {
        // 기존 상세내용 가져오기 (이미 만들어두신 getQnaDetail 활용)
        QnaDTO qnaDTO = qnaDao.getQnaDetail(qna_idx);
        
        // JSP에서 ${board.title}로 쓰고 계시니 이름을 "board"로 넘겨줍니다.
        model.addAttribute("board", qnaDTO); 
        
        return "qna/qnaEdit"; // jsp 파일 경로 (WEB-INF/views/qna/qnaEdit.jsp)
    }

    // 질문 수정 처리 (POST)
    @PostMapping("/qnaEdit.do")
    public String qnaEdit(QnaDTO qnaDTO) {
        // DB 수정 처리 (IQnaService에 updateQna가 있다고 가정)
        int result = qnaDao.updateQna(qnaDTO);
        
        if (result > 0) {
            System.out.println(qnaDTO.getQna_idx() + "번 문의글 수정 성공!");
        }
        
        return "redirect:/qnaView.do?qna_idx=" + qnaDTO.getQna_idx();
    }
    
 // 질문 삭제 처리
    @GetMapping("/qnaDelete.do")
    public String qnaDelete(@RequestParam("qna_idx") int qna_idx) {
        // 1. 위에서 정의한 qnaDao 변수명을 사용해야 합니다!
        // 2. 서비스(인터페이스)에 정의된 삭제 메서드명을 확인하세요. (보통 deleteQna)
        int result = qnaDao.deleteQna(qna_idx); 
        
        if (result > 0) {
            System.out.println(qna_idx + "번 문의글 삭제 완료!");
        }
        
        return "redirect:/qnaList.do";
    }
}