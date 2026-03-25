package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class BoardController {

	// 공지사항 목록
    @GetMapping("/notice")
    public String noticeList() {
        return "board/notice_list"; // notice_list.jsp 호출
    }

 // QNA 목록
    @GetMapping("/qna")
    public String qnaList() {
        return "board/qna_list"; // qna_list.jsp 호출
    }
    
 // 2. 글쓰기 페이지 이동 (GET)
    @GetMapping("/write")
    public String writeForm() {
        return "board/write_admin"; // 파일명: WEB-INF/views/board/write_admin.jsp
    }

    // 3. 실제 글 등록 처리 (POST)
    @PostMapping("/write")
    public String writePro(String title, String content) {
        // 여기에 Service.insert(vo) 로직이 들어갈 자리입니다.
        System.out.println("제목: " + title);
        System.out.println("내용: " + content);
        
        return "redirect:/board/notice"; // 등록 후 목록으로 이동
    }
}