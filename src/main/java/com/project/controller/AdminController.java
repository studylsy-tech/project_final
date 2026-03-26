package com.project.controller;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.project.model.MemberDTO;

@Controller
@RequestMapping("/admin") // 주소를 /admin으로 시작하게 설정
public class AdminController {

    @GetMapping("/main")
    public String adminMain(HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        
        // 권한 체크
        if (loginUser == null || !"ADMIN".equals(loginUser.getMemberType())) {
            return "redirect:/"; 
        }
        
        return "admin/main"; // WEB-INF/views/admin/main.jsp 호출
    }
}