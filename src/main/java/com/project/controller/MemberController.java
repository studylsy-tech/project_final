package com.project.controller;

import javax.servlet.http.HttpServletResponse;
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

	@PostMapping("/joinFull")
	public String joinFull(MemberDTO member) {
	    // 별명 미입력 시 이름을 별명으로 설정
	    if (member.getNickname() == null || member.getNickname().trim().isEmpty()) {
	        member.setNickname(member.getName());
	    }
	    
	    member.setMemberType("FULL");
	    memberService.registerMember(member);
	    return "redirect:/member/login";
	}
	
    @Autowired
    private MemberService memberService;

    // 로그인 페이지 이동
    @GetMapping("/login")
    public String loginForm(HttpSession session) {
        if (session.getAttribute("loginUser") != null) {
            return "redirect:/";
        }
        return "member/login";
    }

    // 로그인 처리
    @PostMapping("/login")
    public String login(MemberDTO member, HttpSession session, Model model, HttpServletResponse response,
            String rememberMe) {
        MemberDTO loginUser = memberService.loginCheck(member);

        if (loginUser != null) {
            session.setAttribute("loginUser", loginUser);
            memberService.handleCookie(loginUser.getPhone(), rememberMe, response);
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

 // 준회원 가입 처리
    @PostMapping("/joinSemi")
    public String joinSemi(MemberDTO member) {
        // 준회원은 별명이 없으므로 휴대폰 번호를 별명으로 강제 설정
        member.setNickname(member.getPhone());
        member.setMemberType("SEMI");
        
        memberService.registerMember(member);
        return "redirect:/member/login";
    }

    // 정회원 가입 (이름, 별명, 주소 포함)
    @GetMapping("/joinFull")
    public String joinFull() {
        return "member/join_full";
    }

    // 로그아웃
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 무효화
        return "redirect:/";
    }

    // 내 정보 확인 (별명, 주소 등 출력)
    @GetMapping("/info")
    public String myInfoPage(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        model.addAttribute("user", loginUser); 
        return "member/info";
    }

    // 정보 수정 페이지 이동
    @GetMapping("/update")
    public String updateForm(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        model.addAttribute("user", loginUser);
        return "member/update";
    }

    // 실제 정보 수정 처리 (POST)
    @PostMapping("/update")
    public String updateMember(MemberDTO member, HttpSession session) {
        // 1. 세션에서 기존 유저의 등급과 식별 정보를 가져옴
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        
        if (loginUser == null) return "redirect:/member/login";

        // 2. 등급 유지 및 이메일(수정 기준값) 설정
        member.setMemberType(loginUser.getMemberType());
        member.setEmail(loginUser.getEmail()); // 이메일 인증 기반이므로 기준값 고정

        // 3. DB 업데이트 실행
        int result = memberService.updateMember(member);

        if (result > 0) {
            // 4. 세션 정보 갱신 (핵심: 메인에서 바뀐 별명을 바로 부르기 위함)
            // 수정한 정보 외에 누락된 정보(가입일 등)가 있을 수 있으므로 
            // 가급적 DB에서 다시 조회하거나 기존 loginUser와 병합하는 것이 안전합니다.
            loginUser.setName(member.getName());
            loginUser.setNickname(member.getNickname());
            loginUser.setAddress(member.getAddress());
            loginUser.setPw(member.getPw());
            
            session.setAttribute("loginUser", loginUser);
            return "redirect:/member/info"; 
        } else {
            return "redirect:/member/update"; 
        }
        
    }
 // 알림 설정 페이지 이동
    @GetMapping("/notification")
    public String notificationPage(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");

        // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
        if (loginUser == null) {
            return "redirect:/member/login";
        }

        model.addAttribute("user", loginUser); 
        return "member/notification_settings";
    }
}