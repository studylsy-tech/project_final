package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.model.MemberDTO;
import com.project.service.MemberService;

@Controller
@RequestMapping("/member") // 경로를 /member로 통일
public class MemberController {

    @Autowired
    private MemberService memberService;

    // 로그인 페이지 이동 (GET)
    @GetMapping("/login")
    public String loginForm(javax.servlet.http.HttpSession session) {
        // 실제 JSP 위치: /WEB-INF/views/member/login.jsp (폴더명 확인 필수!)
    	
    	// session 에 loginUser 가 있는지 확인 여부
    	if(session.getAttribute("loginUser") != null) {
    		return "redirect:/"; // 이미 로그인 한 상태이면 메인으로
    	}
    	
        return "member/login"; 
    }

    // 로그인 처리 (POST)
    @PostMapping("/login")
    public String login(MemberDTO member, javax.servlet.http.HttpSession session, org.springframework.ui.Model model) {
    	 // 로그인 로직 수행
    	MemberDTO loginUser = memberService.loginCheck(member);
    	
    	if(loginUser != null) {
    		// 로그인 성공시
    		session.setAttribute("loginUser", loginUser);
    		
    		System.out.println("로그인 시도 번호: " + member.getPhone());
    		return "redirect:/";
    	}else {
			// 로그인 실패시
    		model.addAttribute("msg", "아이디 또는 비밀번호를 확인해주세요.");
            return "member/login";
		}
    
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
    member.setMemberType("SEMI"); // 회원 유형 명시
    memberService.registerMember(member);
    return "redirect:/member/login";
    }

    // 정회원 가입(GET)
    @GetMapping("/joinFull")
    public String joinFull() {
    	return "member/join_full";
    }
    
    // 정회원 가입
    @PostMapping("/joinFull")
    public String joinFull(MemberDTO member) {
        member.setMemberType("FULL");
        memberService.registerMember(member);
        return "redirect:/"; 
    }
    
    
    // 로그아웃
    @GetMapping("/logout")
    public String logout(javax.servlet.http.HttpSession session) {
        session.invalidate(); // 로그아웃 시 세션 정보를 완전히 삭제
        return "member/logout"; // 메인 페이지로 이동
    }
    
    
    
}