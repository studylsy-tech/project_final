package com.project.controller;

import javax.servlet.http.HttpSession;

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
    
    
    
    
    
    // Q&A (임시로 넣은 애들이라 수정 예정)
    // 1. 회원이 질문 작성 페이지로 이동할 때 (GET)
    @GetMapping("/qnaWrite")
    public String qnaWriteForm() {
        return "board/qnaWrite"; // qnawrite.jsp 화면을 보여줌
    }
    
    // 회원이 질문을 등록할 때 (POST)
    @PostMapping("/qnaWrite")
    public String qnaWrite(String title, String content, HttpSession session) {
        // 세션에서 로그인한 회원 정보를 가져와서 작성자로 저장
        // System.out.println("회원 질문 등록: " + title);
        return "board/qna_list"; // 질문 완료 후 목록으로 이동
    }
    
//    // 2. 관리자가 답변 작성 페이지(혹은 상세페이지)로 이동할 때 (GET)
//    @GetMapping("/qnaDetail")
//    public String qnaDetail(int qnaNo) {
//        // 특정 번호의 글 상세 내용을 가져와서 보여줌
//        return "board/qnaDetail"; 
//    }
//    
//    // 관리자가 답변을 등록할 때 (POST)
//    @PostMapping("/qnaAnswer")
//    public String qnaAnswer(int qnaNo, String answerContent) {
//        // 특정 질문 번호(테이블 미정)에 답변 내용을 업데이트하고 상태를 '답변완료'로 변경
//        
//        return "redirect:/board/qna_list"; // 답변 완료 후 목록으로 이동
//    }
     
    
}