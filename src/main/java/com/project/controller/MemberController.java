package com.project.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.model.MemberDTO;
import com.project.service.MemberService;
import com.project.util.MailUtil;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;
    
    @Autowired
    private MailUtil mailUtil; // 이메일 인증

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
 // 로그인 처리 (7일 유지 설정 추가)
    @PostMapping("/login")
    public String login(MemberDTO member, HttpSession session, Model model, HttpServletResponse response, String rememberMe) {
        MemberDTO loginUser = memberService.loginCheck(member);
        if (loginUser != null) {
            session.setAttribute("loginUser", loginUser);
            
            // 세션 유지 시간을 7일(604800초)로 설정
            session.setMaxInactiveInterval(604800); 
            
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
            e.printStackTrace();
            return "redirect:/member/join";
        } catch (Exception e) {
            ra.addFlashAttribute("msg", "오류가 발생했습니다.");
            e.printStackTrace();
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
    
    // 이메일 인증번호 발송 요청
    @GetMapping("/mailCheck")
    @ResponseBody // 페이지 이동이 아닌 데이터를 리턴하기 위해 필수!
    public String mailCheck(@RequestParam("email") String email) {
        
        // 6자리 랜덤 인증번호 생성
        int authCode = (int)(Math.random() * 899999) + 100000;
        String code = String.valueOf(authCode);
        
        // 이메일 제목 및 내용 (HTML 지원되므로 예쁘게 꾸밀 수 있다고 함!)
        String subject = "회원가입 인증번호 안내";
        String content = "<div style='margin:20px; border:1px solid #ddd; padding:20px;'>"
                       + "<h3>안녕하세요! 회원가입 인증번호입니다.</h3>"
                       + "<p>아래의 인증번호를 복사하여 입력창에 붙여넣어 주세요.</p>"
                       + "<div style='font-size:24px; font-weight:bold; color:blue;'>" + code + "</div>"
                       + "</div>";

        try {
            // MailUtil의 sendMail 메서드 호출
            mailUtil.sendMail(email, subject, content);
            System.out.println("인증번호 발송 성공! 이메일: " + email + ", 번호: " + code);
            
            return code; // 브라우저 Ajax의 success 결과값으로 전달됨
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    
    // 비밀번호 찾기용 인증번호 발송  
    @GetMapping("/find_pw")
    public String findPwPage() {
        return "member/find_pw"; 
    }
    
    @PostMapping("/findPwCheck")
    @ResponseBody
    public String findPwCheck(MemberDTO dto) {
        // DB 조회 (서비스 호출)
        // int count = memberService.checkMemberForPw(dto);
        int count = 1; // 테스트용: DB 연결 전이라면 1로 가정

        if (count > 0) {
            // 2. 인증번호 생성
            String code = String.valueOf((int)(Math.random() * 899999) + 100000);
            
            // 3. 메일 발송 (MailUtil 재사용)
            String subject = "비밀번호 찾기 인증번호 안내";
            String content = "<div style='border:1px solid #ddd; padding:20px; font-family:sans-serif;'>"
                           + "  <h2 style='color:#2c3e50;'>비밀번호 찾기 인증</h2>"
                           + "  <p>요청하신 인증번호는 아래와 같습니다.</p>"
                           + "  <div style='font-size:30px; font-weight:bold; color:#e74c3c; margin:20px 0;'>" + code + "</div>"
                           + "  <p>인증창에 해당 번호를 입력해 주세요.</p>"
                           + "</div>";
            
            try {
                mailUtil.sendMail(dto.getEmail(), subject, content);
                return code; // 성공 시 JS로 인증번호 전달
            } catch (Exception e) {
                return "error";
            }
        } else {
            // 일치하는 정보가 없을 때
            return "not_found";
        }
    }
    
    // 비밀번호 재설정 페이지 띄우기 (인증 성공 후 이동하는 곳)
    @GetMapping("/resetPwPage")
    public String resetPwPage(@RequestParam("phone") String phone, Model model) {
        model.addAttribute("phone", phone);
        
        // /WEB-INF/views/member/reset_pw.jsp 를 찾아가서 새 비밀번호로 변경하기.
        return "member/reset_pw"; 
    }
    
    // 실제 비밀번호를 DB에 업데이트하는 로직 (Ajax POST 요청 처리)
    @PostMapping("/updatePw")
    @ResponseBody // 페이지 이동이 아닌 "success"라는 결과값만 보낼 때 필수!
    public String updatePw(MemberDTO dto) {
        
        System.out.println("비밀번호 변경 요청 폰번호: " + dto.getPhone());
        
        try {
            int result = memberService.updatePassword(dto); 

            if (result > 0) {
                return "success"; // 성공 시 Ajax의 success: function(result) 로 전달
            } else {
                return "fail";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    
    @GetMapping("/kakaoLogin")
    public String kakaoLogin(@RequestParam("code") String code, HttpSession session) {
        System.out.println("인가 코드 수신 성공: " + code);

        // [원래는 여기서 카카오와 통신해서 유저 정보를 가져와야 함]
        // 테스트를 위해 임시로 유저 객체를 만들어서 세션에 넣어봅시다.
        
        MemberDTO kakaoUser = new MemberDTO();
        kakaoUser.setNickname("카카오유저"); 
        kakaoUser.setMemberType(2); // 정회원
        
        // 이 부분이 핵심! 세션에 도장을 찍어줘야 로그인이 유지됩니다.
        session.setAttribute("loginUser", kakaoUser); 
        session.setMaxInactiveInterval(604800); // 7일 유지

        return "redirect:/"; // 메인으로 가면 이제 '로그아웃' 버튼이 보일 거예요!
    }
    
}