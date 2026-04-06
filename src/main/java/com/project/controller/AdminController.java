package com.project.controller;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.project.model.MemberDTO;
import com.project.service.AdminService;
import com.project.service.HotDealService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private HotDealService hotDealService;
    
    @Autowired
    private AdminService adminService;

    @Autowired
    private com.project.crawling.PriceTracker priceTracker; 

    // [핵심] 관리자 공통 권한 체크 로직
    private boolean isAdmin(HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        return loginUser != null && loginUser.getMemberType() == 0;
    }

    // 관리자 메인 (대시보드)
    @GetMapping("/main")
    public String adminMain(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/"; // 권한 없으면 메인으로
        
        // 초기 대시보드 데이터 필요 시 추가
        Map<String, Object> stats = adminService.getDashboardStats();
        model.addAttribute("stats", stats);
        
        return "admin/main";
    }

    // 크롤링 상태 관리 페이지 이동
    @GetMapping("/crawling_status")
    public String crawlingStatus(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/";
        return "admin/crawling_status";
    }

    // 오류 로그 페이지 이동
    @GetMapping("/error_logs")
    public String errorLogs(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/";
        return "admin/error_logs";
    }

    // 공지사항 관리 페이지 이동
    @GetMapping("/notice_manage")
    public String noticeManage(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/";
        return "admin/notice_manage";
    }

    // AJAX: 통계 새로고침
    @GetMapping("/refreshStats.do")
    @ResponseBody
    public Map<String, Object> refreshStats(@RequestParam(required = false) String type) {
        return adminService.getDashboardStats(); 
    }

    // AJAX: 크롤링 시작
    @PostMapping("/startPriceUpdate.do")
    @ResponseBody
    public Map<String, Object> startPriceUpdate(@RequestParam String target) {
        Map<String, Object> result = new HashMap<>();
        try {
            int updatedCount = 0;
            if ("HOT".equals(target) || "ALL".equals(target)) {
                updatedCount += hotDealService.fetchAndRecordHotDeals(); 
            }
            if ("NORMAL".equals(target) || "ALL".equals(target)) {
                updatedCount += hotDealService.fetchAndRecordNormalProducts();
            }
            result.put("status", "success");
            result.put("count", updatedCount);
        } catch (Exception e) {
            result.put("status", "error");
            result.put("message", e.getMessage());
        }
        return result;
    }

    // AJAX: 크롤링 정지
    @PostMapping("/stopPriceUpdate.do")
    @ResponseBody
    public Map<String, Object> stopUpdate() {
        Map<String, Object> res = new HashMap<>();
        try {
            priceTracker.requestStop(); 
            res.put("status", "success");
            res.put("message", "정지 신호를 보냈습니다.");
        } catch (Exception e) {
            res.put("status", "error");
            res.put("message", e.getMessage());
        }
        return res;
    }
}