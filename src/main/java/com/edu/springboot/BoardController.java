package com.edu.springboot;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.edu.springboot.jdbc.BoardDTO;
import com.edu.springboot.jdbc.IBoardService;
import com.edu.springboot.jdbc.UserDTO;
import com.edu.springboot.utils.PagingUtil; // 이따가 만들 클래스입니다.

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;

@Controller
public class BoardController {
	
    @Autowired
    private IBoardService boardDao;

    /* ==========================================================
     * 1. 공지사항 (Notice)
     * ========================================================== */

    @GetMapping("/noticeList.do")
    public String noticeList(Model model) {
        // 모든 공지사항을 한 번에 가져와서 DataTables에게 처리를 맡깁니다.
        // (MyBatis XML에 getList에서 OFFSET 부분을 뺀 getAllList 같은 쿼리가 필요합니다)
        List<BoardDTO> lists = boardDao.getAllList("notice"); 
        model.addAttribute("lists", lists);
        return "notice/noticeList";
    }

    @GetMapping("/noticeWrite.do")
    public String noticeWrite(Model model) {
        model.addAttribute("board_type", "notice");
        return "notice/noticeWrite";
    }

    @PostMapping("/noticeWrite.do")
    public String noticeWritePost(BoardDTO boardDTO, HttpSession session) {
        // 1. 세션에서 "user" 객체를 가져옴
        UserDTO user = (UserDTO) session.getAttribute("user");
        
        if (user != null) {
            // 세션에 유저가 있다면 ID를 세팅
            boardDTO.setUser_id(user.getUser_id()); 
        } else {
            // [중요] 만약 유저가 null이라면? (로그인이 안 된 상태거나 세션 만료)
            // 테스트 중이라면 임시로 'admin'을 넣어 에러를 피하세요.
            boardDTO.setUser_id("admin"); 
        }
        
        boardDTO.setBoard_type("notice");
        boardDao.write(boardDTO);
        return "redirect:/noticeList.do";
    }
    
    @RequestMapping("/noticeView.do")
    public String noticeView(HttpServletRequest req, HttpServletResponse resp, Model model) {
        int idx = Integer.parseInt(req.getParameter("idx"));
        
        Cookie[] cookies = req.getCookies();
        boolean hasVisited = false;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("notice_view_" + idx)) {
                    hasVisited = true;
                    break;
                }
            }
        }

        if (!hasVisited) {
            boardDao.updateCount(idx);
            Cookie newCookie = new Cookie("notice_view_" + idx, "true");
            newCookie.setMaxAge(60 * 60 * 24);
            newCookie.setPath("/");
            resp.addCookie(newCookie);
        }

        BoardDTO boardDTO = boardDao.getDetail(idx);
        if (boardDTO != null && boardDTO.getContent() != null) {
            boardDTO.setContent(boardDTO.getContent().replace("\r\n", "<br/>"));
        }
        model.addAttribute("boardDTO", boardDTO);
        return "notice/noticeView";
    }

    @GetMapping("/noticeEdit.do")
    public String noticeEdit(@RequestParam("idx") int idx, Model model) {
        model.addAttribute("board", boardDao.getDetail(idx));
        return "notice/noticeEdit";
    }

    @PostMapping("/noticeEdit.do")
    public String noticeEditPost(BoardDTO boardDTO) {
        boardDao.update(boardDTO);
        return "redirect:/noticeList.do";
    }

    @GetMapping("/noticeDelete.do")
    public String noticeDelete(@RequestParam("idx") int idx) {
        boardDao.delete(idx);
        return "redirect:/noticeList.do";
    }

    /* ==========================================================
     * 2. 수강 리뷰 (Review)
     * ========================================================== */

    @GetMapping("/reviewList.do")
    public String reviewList(HttpServletRequest req, Model model) {
        // 1. 검색어만 받아옵니다.
        String searchField = req.getParameter("searchField");
        String searchWord = req.getParameter("searchWord");

        // 2. [수정] getList(잘라서 가져오기) 대신 getAllList(통째로 가져오기)를 사용합니다.
        // 만약 getAllList가 없다면 boardDao에 새로 만드셔야 해요!
        List<BoardDTO> lists = boardDao.getAllList("review"); 

        // 3. 모델에 담아줍니다. (이제 pagingImg 같은 건 안 보내도 됩니다)
        model.addAttribute("lists", lists);
        model.addAttribute("boardTitle", "수강 리뷰");

        return "review/reviewList";
    }
    
    @GetMapping("/reviewWrite.do")
    public String reviewWrite(Model model) {
        model.addAttribute("board_type", "review");
        return "review/reviewWrite";
    }

    @PostMapping("/reviewWrite.do")
    public String reviewWritePost(BoardDTO boardDTO, HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user != null) {
            boardDTO.setUser_id(user.getUser_id());
        } else {
            boardDTO.setUser_id("guest"); 
        }
        boardDTO.setBoard_type("review");
        boardDao.write(boardDTO);
        return "redirect:/reviewList.do";
    }

    @RequestMapping("/reviewView.do")
    public String reviewView(HttpServletRequest req, HttpServletResponse resp, Model model, HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.do"; 
        }
        
        int idx = Integer.parseInt(req.getParameter("idx"));

        Cookie[] cookies = req.getCookies();
        boolean hasVisited = false;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("review_view_" + idx)) {
                    hasVisited = true;
                    break;
                }
            }
        }

        if (!hasVisited) {
            boardDao.updateCount(idx);
            Cookie newCookie = new Cookie("review_view_" + idx, "true");
            newCookie.setMaxAge(60 * 60 * 24);
            newCookie.setPath("/");
            resp.addCookie(newCookie);
        }

        BoardDTO boardDTO = boardDao.getDetail(idx);
        if (boardDTO != null && boardDTO.getContent() != null) {
            boardDTO.setContent(boardDTO.getContent().replace("\r\n", "<br/>"));
        }
        model.addAttribute("boardDTO", boardDTO);
        return "review/reviewView";
    }

    @GetMapping("/reviewEdit.do")
    public String reviewEdit(@RequestParam("idx") int idx, Model model) {
        model.addAttribute("board", boardDao.getDetail(idx));
        return "review/reviewEdit";
    }

    @PostMapping("/reviewEdit.do")
    public String reviewEditPost(BoardDTO boardDTO) {
        boardDao.update(boardDTO);
        return "redirect:/reviewList.do";
    }

    @GetMapping("/reviewDelete.do")
    public String reviewDelete(@RequestParam("idx") int idx) {
        boardDao.delete(idx);
        return "redirect:/reviewList.do";
    }
}