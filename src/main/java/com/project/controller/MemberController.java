package com.project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.model.MemberDTO;
import com.project.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    // 로그인 페이지 이동
    @GetMapping("/login")
    public String loginForm(HttpSession session) {
        if(session.getAttribute("loginUser") != null) {
            return "redirect:/";
        }
        return "member/login"; 
    }

    // 로그인 처리
    @PostMapping("/login")
    public String login(MemberDTO member, HttpSession session, Model model) {
        MemberDTO loginUser = memberService.loginCheck(member);
        
        if(loginUser != null) {
            session.setAttribute("loginUser", loginUser);
            return "redirect:/";
        } else {
            model.addAttribute("msg", "아이디 또는 비밀번호를 확인해주세요.");
            return "member/login";
        }
    }
    
    @GetMapping("/join")
    public String joinPage() {
        return "member/join"; 
    }
    
    @PostMapping("/joinSemi")
    public String joinSemi(MemberDTO member) {
        member.setMemberType("SEMI");
        memberService.registerMember(member);
        return "redirect:/member/login";
    }

    @GetMapping("/joinFull")
    public String joinFull() {
        return "member/join_full";
    }
    
    @PostMapping("/joinFull")
    public String joinFull(MemberDTO member) {
        member.setMemberType("FULL");
        memberService.registerMember(member);
        return "redirect:/"; 
    }
    
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/member/login";
    }
    
    // [수정] 내 정보 보기
    @GetMapping("/info")
    public String memberInfo(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if(loginUser == null) return "redirect:/member/login";
        
        model.addAttribute("user", loginUser);
        return "member/info";
    }

    // [추가] 알림 설정 페이지 이동
    @GetMapping("/notification")
    public String notificationSettings(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if(loginUser == null) return "redirect:/member/login";
        
        // 현재는 보이기 전용이므로 바로 JSP 리턴
        // 추후 알림 잔여 슬롯 등을 DB에서 조회하여 model에 담는 로직이 들어갈 자리입니다.
        return "member/notification_settings";
    }
}