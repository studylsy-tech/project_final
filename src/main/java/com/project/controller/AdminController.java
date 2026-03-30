package com.project.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody; // ResponseBody import 추가

import com.project.dao.FooterMapper;
import com.project.model.FooterInquiryVO;
import com.project.model.MemberDTO;
import com.project.service.HotDealService; // Service import 추가

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private FooterMapper footerMapper;

    @Autowired
    private HotDealService hotDealService; // 필드 선언 위치를 클래스 상단으로 이동

    // 1. 관리자 메인 페이지
    @GetMapping("/main")
    public String adminMain(HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null || !"ADMIN".equals(loginUser.getMemberType())) {
            return "redirect:/member/login";
        }
        return "admin/main";
    }

    // 2. 관리자 문의 목록 페이지
    @GetMapping("/list.do")
    public String adminInquiryList(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null || !"ADMIN".equals(loginUser.getMemberType())) {
            return "redirect:/";
        }

        List<FooterInquiryVO> list = footerMapper.selectAllInquiries();
        model.addAttribute("inquiryList", list);
        return "admin/inquiryList"; 
    }

    // 3. 크롤링 관리 페이지 이동
    @GetMapping("/crawling_manage")
    public String crawlingManage(HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null || !"ADMIN".equals(loginUser.getMemberType())) {
            return "redirect:/member/login";
        }
        return "admin/crawling_manage";
    }

    @RequestMapping("/fetchDeals.do")
    @ResponseBody
    public Map<String, Object> fetchDeals() {
        Map<String, Object> result = new HashMap<>();
        try {
            // 1. 실제 신규로 추가된 개수를 받아옴
            int newlyAdded = hotDealService.fetchAndStoreDeals(20); 
            
            // 2. 전체 DB 누적 건수 조회
            int total = hotDealService.getTotalDealCount(); 
            
            result.put("status", "success");
            result.put("newlyAdded", newlyAdded); // "신규 20건 수집 완료" 메시지용
            result.put("totalCount", total);      // "총 수집 건수" 표시용
            result.put("lastTime", new SimpleDateFormat("HH:mm:ss").format(new Date()));
            
        } catch (Exception e) {
            result.put("status", "error");
            result.put("message", e.getMessage());
        }
        return result;
    }
    
    
} // 클래스 끝을 알리는 중괄호는 가장 마지막에 한 번만 나옵니다.