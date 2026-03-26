package com.project.controller;

import javax.servlet.http.HttpSession;

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
    @RequestMapping("/logout")
    public String logout(javax.servlet.http.HttpSession session) {
        session.invalidate(); // 로그아웃 시 세션 정보를 완전히 삭제
        return "redirect:/member/login"; // 로그아웃 알림창 후 메인으로 이동
    }
    
    // 내 정보 보기
    @GetMapping("/info")
    public String memberInfo(HttpSession session, org.springframework.ui.Model model) {
        // 세션에서 로그인한 유저 정보 가져오기
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        // 로그인 안 되어 있으면 로그인 페이지로 보내버리기
        if(loginUser == null) {
            return "redirect:/member/login";
        }
        model.addAttribute("user", loginUser);
        return "member/info"; 
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