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

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

 // 1. 공지사항 목록 조회
    @GetMapping("/notice") 
    public String noticeList(SearchCriteria scri, Model model) {
        // 1. 게시판 타입 설정
        scri.setBoardType("NOTICE");
        
        // 2. 페이징 시작/끝 행 번호 계산 (중요)
        scri.calcPageRange();
        
        // 3. 전체 게시글 개수 조회 (검색 조건 포함)
        int totalCount = boardService.getBoardCount(scri);
        
        // 4. 페이징 처리를 위한 PageMaker 설정
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(scri); // 요청하신 대로 setCri 사용
        pageMaker.setTotalCount(totalCount);
        
        // 5. 페이징 처리가 적용된 목록 조회
        List<BoardDTO> list = boardService.selectBoardListPaging(scri);
        
        // 6. 뷰로 데이터 전달
        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        
        return "board/notice_list";
    }

    // 2. Q&A 목록 조회
    @GetMapping("/qna")
    public String qnaList(SearchCriteria scri, Model model) {
        scri.setBoardType("QNA"); 
     // 계산 로직 호출 (SearchCriteria에 정의된 경우)
        scri.calcPageRange(); 
        
        // 콘솔 출력
        System.out.println("=== QNA List Parameters ===");
        System.out.println("Board Type: " + scri.getBoardType());
        System.out.println("Page Start: " + scri.getPageStart());
        System.out.println("Page End: " + scri.getPageEnd());
        System.out.println("Search Type: " + scri.getSearchType());
        System.out.println("Keyword: " + scri.getKeyword());
        int totalCount = boardService.getBoardCount(scri); 

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(scri);
        pageMaker.setTotalCount(totalCount);

        List<BoardDTO> list = boardService.selectBoardListPaging(scri); 

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);

        return "board/qna_list";
    }

    // 3. 게시글 작성 페이지 이동
    @GetMapping({"/write", "/qnaWrite"})
    public String writeForm(@RequestParam(value="type", required=false) String type, 
                            HttpServletRequest request,
                            Model model, 
                            HttpSession session) {
        
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/member/login";
        
        String uri = request.getRequestURI();
        if (uri.contains("qnaWrite")) {
            type = "QNA";
        } else if (type == null) {
            type = "QNA";
        }
        
        // 공지사항 작성 권한 체크
        if ("NOTICE".equals(type) && !"ADMIN".equals(loginUser.getMemberType())) {
            return "redirect:/board/notice";
        }
        
        // JSP에서 폼 태그의 hidden 값으로 사용하기 위해 model에 담음
        model.addAttribute("board_type", type);
        return "board/write";
    }

    // 4. 게시글 작성 처리
    @PostMapping("/write")
    public String insertBoard(BoardDTO board, HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/member/login";

        String writerName = (loginUser.getNickname() != null && !loginUser.getNickname().isEmpty()) 
                            ? loginUser.getNickname() : loginUser.getName();
        
        // 소문자 필드명에 따른 Setter 호출
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
        // 상세 정보 조회
        BoardDTO board = boardService.selectBoardDetail(notice_no);
        
        if (board != null) {
            // 조회수 증가
            boardService.updateCount(notice_no);
            model.addAttribute("board", board);
            return "board/detail"; 
        }
        return "redirect:/board/notice";
    }
}