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
    public String adminInquiryList(Model model) {
        
        // 1. DB에서 모든 문의 내역을 가져옵니다.
        List<FooterInquiryVO> list = footerMapper.selectAllInquiries();
        
        // 2. 가져온 리스트를 'inquiryList'라는 이름으로 JSP에 전달합니다.
        model.addAttribute("inquiryList", list);
        
        // 3. /WEB-INF/views/admin/inquiryList.jsp 파일을 찾아서 보여줍니다.
        return "admin/inquiryList"; 
    }
}