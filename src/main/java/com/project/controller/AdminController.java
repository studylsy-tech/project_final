package com.project.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.dao.FooterMapper;
import com.project.model.FooterInquiryVO;

@Controller
@RequestMapping("/admin") // 모든 경로는 /admin으로 시작합니다.
public class AdminController {

    @Autowired
    private FooterMapper footerMapper;

    // 관리자 문의 목록 페이지 (http://localhost:8080/프로젝트명/admin/list.do)
    @GetMapping("/list.do")
public String adminInquiryList(HttpSession session, Model model) {
    // 세션에서 로그인 정보 확인
    MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");

    // 권한 체크: 로그인이 안 되어 있거나 관리자가 아니면 메인으로 리다이렉트
    if (loginUser == null || !"ADMIN".equals(loginUser.getMemberType())) {
        return "redirect:/";
    }

    List<FooterInquiryVO> list = footerMapper.selectAllInquiries();
    model.addAttribute("inquiryList", list);
    return "admin/inquiryList";
}
}
