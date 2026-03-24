package com.project.controller;

import com.project.model.MemberDTO;
import com.project.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member") // 경로를 /member로 통일
public class MemberController {

    @Autowired
    private MemberService memberService;

    // 로그인 페이지 이동 (GET)
    @GetMapping("/login")
    public String loginForm() {
        // 실제 JSP 위치: /WEB-INF/views/member/login.jsp (폴더명 확인 필수!)
        return "member/login"; 
    }

    // 로그인 처리 (POST)
    @PostMapping("/login")
    public String login(MemberDTO member) {
        // 로그인 로직 수행
        System.out.println("로그인 시도 번호: " + member.getPhone());
        return "redirect:/";
    }
    @GetMapping("/join")
    public String joinPage() {
        // 리턴값은 JSP 파일의 경로입니다. 
        // /WEB-INF/views/member/join.jsp 파일이 있어야 합니다.
        return "member/join"; 
    }
    // 반회원 가입
    @PostMapping("/joinSemi")
    public String joinSemi(MemberDTO member) {
        member.setMemberType("SEMI"); 
        memberService.registerMember(member);
        return "redirect:/"; 
    }

    // 정회원 가입
    @PostMapping("/joinFull")
    public String joinFull(MemberDTO member) {
        member.setMemberType("FULL");
        memberService.registerMember(member);
        return "redirect:/"; 
    }
}