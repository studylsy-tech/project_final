package com.project.controller;

import java.util.List;
import javax.servlet.http.HttpSession; // 추가 필요 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.dao.FooterMapper;
import com.project.model.FooterInquiryVO;
import com.project.model.MemberDTO; // 추가 필요 

@Controller
@RequestMapping("/admin") // 모든 경로는 /admin으로 시작합니다 
public class AdminController {

    @Autowired
    private FooterMapper footerMapper; // 

    // 관리자 문의 목록 페이지 (http://localhost:8080/프로젝트명/admin/list.do)
    @GetMapping("/list.do")
    public String adminInquiryList(HttpSession session, Model model) {
        
        // 1. 세션에서 로그인 정보 확인 
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");

        // 2. 권한 체크: 로그인이 안 되어 있거나 관리자가 아니면 메인으로 리다이렉트 
        if (loginUser == null || !"ADMIN".equals(loginUser.getMemberType())) {
            return "redirect:/"; // 
        }

        // 3. DB에서 모든 문의 내역을 가져옵니다 
        List<FooterInquiryVO> list = footerMapper.selectAllInquiries();
        
        // 4. 가져온 리스트를 'inquiryList'라는 이름으로 JSP에 전달합니다 
        model.addAttribute("inquiryList", list);
        
        // 5. /WEB-INF/views/admin/inquiryList.jsp 파일을 호출합니다 
        return "admin/inquiryList"; 
    }
}
