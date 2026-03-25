package com.project.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.model.MemberDTO;
import com.project.service.MemberService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private MemberService memberService;
	
	// 관리자 메인 또는 회원 목록 보기 + 
	@GetMapping("/memberList")
	public String memberList(HttpSession session, Model model) {
		// 보안 체크 => 관리자 권한 확인 및 로그인 여부 확인
		MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
		
		if (loginUser == null || !loginUser.getMemberType().equals("ADMIN")) {
            // 관리자가 아니면 메인으로 내보내기
            return "redirect:/"; 
        }
		
		/* 임시 주석 List<MemberDTO> userList = memberService.getAllMembers(); */
        
        // JSP로 데이터 전달
		/* model.addAttribute("list", userList); */
        
        return "admin/member_list";
	}
	
}
