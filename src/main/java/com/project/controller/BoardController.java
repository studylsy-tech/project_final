package com.project.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.model.BoardDTO;
import com.project.model.MemberDTO;
import com.project.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    // 1. 공지사항 목록 조회
    @GetMapping("/notice") 
    public String noticeList(Model model) {
        List<BoardDTO> list = boardService.selectBoardList("NOTICE");
        model.addAttribute("list", list);
        return "board/notice_list";
    }

    // 2. Q&A 목록 조회
    @GetMapping("/qna")
    public String qnaList(Model model) {
        List<BoardDTO> list = boardService.selectBoardList("QNA");
        model.addAttribute("list", list);
        return "board/qna_list";
    }

    // 3. 게시글 작성 페이지 이동 (다중 매핑 적용)
    @GetMapping({"/write", "/qnaWrite"})
    public String writeForm(@RequestParam(value="type", required=false) String type, 
                            HttpServletRequest request,
                            Model model, 
                            HttpSession session) {
        
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/member/login";
        
        // qnaWrite 경로로 들어온 경우 type을 QNA로 강제 할당
        String uri = request.getRequestURI();
        if (uri.contains("qnaWrite")) {
            type = "QNA";
        } else if (type == null) {
            // /write 주소로 그냥 들어왔을 때의 기본값
            type = "QNA";
        }
        
        // 공지사항 작성 권한 체크
        if ("NOTICE".equals(type) && !"ADMIN".equals(loginUser.getMemberType())) {
            return "redirect:/board/notice";
        }
        
        model.addAttribute("board_type", type);
        return "board/write"; // 통합된 write.jsp 하나만 사용
    }

    // 4. 게시글 작성 처리
    @PostMapping("/write")
    public String insertBoard(BoardDTO board, HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/member/login";

        String writerName = (loginUser.getNickname() != null && !loginUser.getNickname().isEmpty()) 
                            ? loginUser.getNickname() : loginUser.getName();
        board.setWriter(writerName);
        
        if ("NOTICE".equals(board.getBoard_type())) {
            if ("ADMIN".equals(loginUser.getMemberType())) {
                boardService.insertBoard(board);
            }
            return "redirect:/board/notice";
        } else {
            boardService.insertBoard(board);
            return "redirect:/board/qna";
        }
    }

    // 5. 상세 페이지
    @GetMapping("/detail")
    public String boardDetail(@RequestParam("notice_no") int notice_no, Model model) {
        BoardDTO board = boardService.selectBoardDetail(notice_no);
        if (board != null) {
            boardService.updateCount(notice_no);
            model.addAttribute("board", board);
            return "board/detail"; 
        }
        return "redirect:/board/notice";
    }
}