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
    public String login(MemberDTO member, HttpSession session, Model model, HttpServletResponse response, String rememberMe) {
        MemberDTO loginUser = memberService.loginCheck(member);
        
        if(loginUser != null) {
            session.setAttribute("loginUser", loginUser);
            
            // MemberService 에 존재하는 쿠키 로직 갖고오기
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
    
    @PostMapping("/joinSemi")
    public String joinSemi(MemberDTO member) {
        member.setMemberType("SEMI");
        memberService.registerMember(member);
        return "redirect:/member/login";
    }


    // 정회원 가입(GET)
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
    
    // 로그아웃
    @RequestMapping("/logout")
    public String logout(HttpSession session, HttpServletResponse response) {
//        session.invalidate();
//        memberService.handleCookie(null, "off", response);
        return "member/logout";
    }
    
    // 내 정보 확인 (GET)
    @GetMapping("/info")
    public String myInfoPage(HttpSession session, Model model) {
        // 수정: "user" -> "loginUser"
        MemberDTO user = (MemberDTO) session.getAttribute("loginUser"); 
        
        if (user == null) {
            return "redirect:/member/login";
        }
        
        model.addAttribute("user", user); // JSP에서는 ${user}로 쓰기 위해 모델 이름은 유지
        return "member/info";
    }

    // 알림 설정 (GET)
    @GetMapping("/notification")
    public String notificationPage(HttpSession session, Model model) {
        // 수정: "user" -> "loginUser"
        MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
        
        if (user == null) {
            return "redirect:/member/login";
        }
        
        model.addAttribute("user", user);
        return "member/notification_settings";
    }
    
    // 내 정보 수정
    @GetMapping("/update")
    public String updateForm(HttpSession session, org.springframework.ui.Model model) {
        // 세션에서 현재 로그인한 유저 정보 가져오기
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        
        if (loginUser == null) {
            return "redirect:/member/login";
        }
        
        // JSP에서 사용할 'user'라는 이름으로 세션 정보를 모델에 담아주는 역할
        model.addAttribute("user", loginUser);
        return "member/update"; // => WEB-INF/views/member/update.jsp 실행
    }
    
    
    // 실제 정보 수정 처리 용 (POST)
    @PostMapping("/update")
    public String updateMember(MemberDTO member, HttpSession session) {
    	// 세션에서 기존 로그인 정보 꺼내기
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        
        // 정보 수정시 회원등급 바뀌는 오류 확인용
        member.setMemberType(loginUser.getMemberType());
        
        // DB 수정 실행 (service 호출)
        int result = memberService.updateMember(member);
        
        if (result > 0) {
            // DB가 바뀌었으니 세션에 저장된 loginUser 정보도 새 정보로 교체 역할
            session.setAttribute("loginUser", member); 
            return "redirect:/member/info"; // 수정 후 정보 확인 페이지로 다시 이동
        } else {
        	return "redirect:/member/update"; // 실패 시 다시 정보 수정 란으로(없으면 적절한 곳으로 리다이렉트)
        }
    }
}