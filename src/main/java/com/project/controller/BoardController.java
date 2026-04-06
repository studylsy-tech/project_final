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
import com.project.util.PageMaker;
import com.project.util.SearchCriteria;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    // 1. 공지사항 목록 조회
    @GetMapping("/notice") 
    public String noticeList(SearchCriteria scri, Model model) {
        scri.setBoardType("NOTICE");
        scri.calcPageRange();
        int totalCount = boardService.getBoardCount(scri);
        
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(scri);
        pageMaker.setTotalCount(totalCount);
        
        List<BoardDTO> list = boardService.selectBoardListPaging(scri);
        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        
        return "board/notice_list";
    }

    // 2. Q&A 목록 조회
    @GetMapping("/qna")
    public String qnaList(SearchCriteria scri, Model model) {
        scri.setBoardType("QNA"); 
        scri.calcPageRange(); 
        int totalCount = boardService.getBoardCount(scri); 

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(scri);
        pageMaker.setTotalCount(totalCount);

        List<BoardDTO> list = boardService.selectBoardListPaging(scri); 
        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);

        return "board/qna_list";
    }

    // 3. 게시글 작성 페이지 이동 (일반 질문용)
    @GetMapping({"/write", "/qnaWrite"})
    public String writeForm(@RequestParam(value="type", required=false) String type, 
                            HttpServletRequest request,
                            Model model, 
                            HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/member/login";
        
        String uri = request.getRequestURI();
        if (uri.contains("qnaWrite") || type == null) {
            type = "QNA";
        }
        
        // 공지사항 작성 시 관리자(0) 권한 체크
        if ("NOTICE".equals(type) && loginUser.getMemberType() != 0) {
            return "redirect:/board/notice";
        }
        
        model.addAttribute("board_type", type);
        return "board/write";
    }

    // 4. Q&A 답변 작성 페이지 이동 (관리자 전용)
    @GetMapping("/qnaReply")
    public String qnaReplyForm(@RequestParam("notice_no") int notice_no, 
                               Model model, 
                               HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        
        // 관리자(0) 권한 체크
        if (loginUser == null || loginUser.getMemberType() != 0) {
            return "redirect:/board/qna";
        }

        BoardDTO parentBoard = boardService.selectBoardDetail(notice_no);
        model.addAttribute("parentBoard", parentBoard);
        model.addAttribute("board_type", "QNA");
        
        return "board/reply"; 
    }

    // 5. 게시글 작성 처리 (통합)
    @PostMapping("/write")
    public String insertBoard(BoardDTO board, HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/member/login";

        String writerName = (loginUser.getNickname() != null && !loginUser.getNickname().isEmpty()) 
                            ? loginUser.getNickname() : loginUser.getName();
        board.setWriter(writerName);
        
        if ("NOTICE".equals(board.getBoard_type())) {
            if (loginUser.getMemberType() == 0) {
                boardService.insertBoard(board);
            }
            return "redirect:/board/notice";
        } else {
            boardService.insertBoard(board);
            return "redirect:/board/qna";
        }
    }

    // 6. 상세 페이지
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
    
    @GetMapping("/delete")
    public String deleteBoard(@RequestParam("notice_no") int notice_no, RedirectAttributes rttr) {
        
        boardService.deleteBoard(notice_no);
        
        // 삭제 성공 메시지 (선택)
        rttr.addFlashAttribute("msg", "삭제되었습니다.");
        
        // [수정] 실제 QNA 목록으로 가는 @RequestMapping 주소를 적어줘야 합니다.
        // 만약 목록 주소가 /board/qna 라면 아래와 같이 작성합니다.
        return "redirect:/board/qna"; 
    }
}