package com.project.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.dao.FooterMapper;
import com.project.model.FooterInquiryVO;
import com.project.util.MailUtil; // 메일 유틸리티 임포트

@Controller
@RequestMapping("/footer")
public class FooterController {

    @Autowired
    private FooterMapper footerMapper;

    @Autowired
    private MailUtil mailUtil; // 메일 발송 객체 주입

    // 1. 문의하기 페이지 보여주기
    @GetMapping("/support.do")
    public String supportPage() {
        return "footer/support";
    }

    // 2. 문의 내용 저장 및 관리자 페이지 이동 처리
    // produces 설정을 해야 알림창(alert) 한글이 깨지지 않습니다.
    @PostMapping(value = "/support.do", produces = "text/html; charset=UTF-8")    @ResponseBody 
    public String insertInquiry(FooterInquiryVO vo, HttpServletRequest request) {
        
        // [작업 1] DB에 문의 내용 저장
        int result = footerMapper.insertInquiry(vo);
        
        if(result > 0) {
            // [작업 2] 관리자(나)에게 실시간 메일 알림 보내기
            // 보낼 사람, 제목, 내용을 설정합니다.
            String adminEmail = "pafagolue@gmail.com"; 
            String subject = "[신규 문의 알림] " + vo.getUser_name() + "님의 문의입니다.";
            String content = "<h3>새로운 문의가 접수되었습니다.</h3>" +
                             "<p><b>작성자:</b> " + vo.getUser_name() + "</p>" +
                             "<p><b>이메일:</b> " + vo.getUser_email() + "</p>" +
                             "<p><b>내용:</b> " + vo.getUser_content() + "</p>";
            
            mailUtil.sendMail(adminEmail, subject, content);

         // [작업 3] 알림창을 띄우고 메인 페이지로 이동
            String script = "<script>" +
                            "alert('문의가 정상적으로 접수되었습니다.');" +
                            "location.href='" + request.getContextPath() + "/';" + 
                            "</script>";
            return script;
        }
        
        // 저장 실패 시 처리
        return "<script>alert('접수 중 오류가 발생했습니다.'); history.back();</script>";
    }
}