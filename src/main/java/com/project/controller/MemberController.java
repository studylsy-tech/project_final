package com.project.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.model.MemberDTO;
import com.project.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    // 정회원 가입 처리 (POST)
    @PostMapping("/joinFull")
    public String joinFull(MemberDTO member, Model model) {
        try {
            if (member.getNickname() == null || member.getNickname().trim().isEmpty()) {
                member.setNickname(member.getName());
            }
            
            // [수정] 정회원 타입을 숫자 2로 설정
            member.setMemberType(2); 
            memberService.registerMember(member);
            return "redirect:/member/login";
            
        } catch (DuplicateKeyException e) {
            // 이메일 UNIQUE 제약 조건에 의해 이메일 중복 시에도 이 블록이 실행됩니다.
            model.addAttribute("msg", "이미 사용 중인 휴대폰 번호 또는 이메일입니다.");
            model.addAttribute("member", member); 
            return "member/join"; 
        } catch (Exception e) {
            model.addAttribute("msg", "가입 중 알 수 없는 오류가 발생했습니다.");
            return "member/join";
        }
    }

    // 로그인 페이지 이동
    @GetMapping("/login")
    public String loginForm(HttpSession session) {
        if (session.getAttribute("loginUser") != null) {
            return "redirect:/";
        }
        return "member/login";
    }

    // 로그인 처리 (누락된 부분 추가)
    @PostMapping("/login")
    public String login(MemberDTO member, HttpSession session, Model model, HttpServletResponse response, String rememberMe) {
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


    /**
     * 준회원 가입 처리 (POST)
     * println 및 PrintWriter를 제거하고 Spring의 리다이렉트 방식을 사용합니다.
     */
    @PostMapping("/joinSemi")
    public String joinSemi(MemberDTO member, RedirectAttributes ra) {
        try {
            // 준회원 타입 1 설정
            member.setMemberType(1);
            int result = memberService.insertSemiMember(member);

            if (result > 0) {
                ra.addFlashAttribute("msg", "알림 신청이 완료되었습니다.");
                return "redirect:/";
            } else {
                ra.addFlashAttribute("msg", "가입에 실패했습니다. 다시 시도해주세요.");
                return "redirect:/member/join";
            }

        } catch (DuplicateKeyException e) {
            // 중복된 번호일 경우 경고 메시지와 함께 가입 페이지로 리다이렉트
            ra.addFlashAttribute("msg", "이미 등록된 휴대폰 번호입니다. 번호를 확인해 주세요.");
            return "redirect:/member/join";
        } catch (Exception e) {
            ra.addFlashAttribute("msg", "오류가 발생했습니다.");
            return "redirect:/member/join";
        }
    }

    // 로그아웃
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    // 회원 탈퇴 처리
    @GetMapping("/delete")
    public String deleteMember(HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser != null) {
            memberService.deleteMember(loginUser.getPhone());
            session.invalidate();
        }
        return "redirect:/"; 
    }

    // 내 정보 확인
    @GetMapping("/info")
    public String myInfoPage(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/member/login";

        model.addAttribute("user", loginUser); 
        return "member/info";
    }

    // 정보 수정 페이지 이동
    @GetMapping("/update")
    public String updateForm(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/member/login";

        model.addAttribute("user", loginUser);
        return "member/update";
    }

    // 정보 수정 처리
    @PostMapping("/update")
    public String updateMember(MemberDTO member, HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/member/login";

        member.setMemberType(loginUser.getMemberType());
        member.setEmail(loginUser.getEmail());

        int result = memberService.updateMember(member);
        if (result > 0) {
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
 // MemberController 내부
    @GetMapping("notification") // 또는 전체 경로가 /member/notification 인지 확인
    public String notificationPage(HttpSession session) {
        // 1. 로그인 체크 (세션에 유저 정보가 없으면 로그인 페이지로)
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/member/login";
        }
        
        // 2. 파일명을 notification.jsp로 바꿨으므로 반환값도 수정
        // (prefix: /WEB-INF/views/, suffix: .jsp 가 설정되어 있다고 가정)
        return "member/notification"; 
    }
}