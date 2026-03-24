package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

    // 1. 서비스 이용약관
    @RequestMapping("/footer/terms.do")
    public String terms() {
        return "footer/terms"; // WEB-INF/views/footer/terms.jsp 호출
    }

    // 2. 개인정보 처리방침
    @RequestMapping("/footer/privacy.do")
    public String privacy() {
        return "footer/privacy"; // WEB-INF/views/footer/privacy.jsp 호출
    }

    // 3. 고객센터
    @RequestMapping("/footer/support.do")
    public String support() {
        return "footer/support"; // WEB-INF/views/footer/support.jsp 호출
    }

    // 메인 홈
    @GetMapping("/") 
    public String mainHome() {
        return "index"; 
    }
}