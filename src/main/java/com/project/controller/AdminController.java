package com.project.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.model.MemberDTO;
import com.project.service.AdminService;
import com.project.service.HotDealService;

import lombok.extern.slf4j.Slf4j;
@Component
@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private HotDealService hotDealService;
    
    @Autowired
    private AdminService adminService;

    // [추가] PriceTracker 주입 (타입을 명확히 지정)
    @Autowired
    private com.project.crawling.PriceTracker priceTracker; 

    // ... 기존 메서드들 (adminMain, crawlingStatus 등) 생략 ...

    /**
     * [수정] 핫딜/일반 상품 가격 추적 실행
     */
    @PostMapping("/startPriceUpdate.do")
    @ResponseBody
    public Map<String, Object> startPriceUpdate(@RequestParam String target) {
        Map<String, Object> result = new HashMap<>();
        try {
            int updatedCount = 0;
            
            // Service 내부에 이미 작성하신 PriceTracker 호출 로직이 있다면 그대로 사용
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

    /**
     * [수정] 실시간 크롤링 정지 명령
     * JSP 요청 경로: ${path}/admin/stopPriceUpdate.do
     */
    @PostMapping("/stopPriceUpdate.do")
    @ResponseBody
    public Map<String, Object> stopUpdate() {
        Map<String, Object> res = new HashMap<>();
        try {
            // 주입받은 priceTracker 객체의 정지 메서드 호출
            priceTracker.requestStop(); 
            
            res.put("status", "success");
            res.put("message", "정지 신호를 보냈습니다.");
        } catch (Exception e) {
            res.put("status", "error");
            res.put("message", e.getMessage());
        }
        return res;
    }
 // AdminController.java
    
    @GetMapping("/refreshStats.do")
    @ResponseBody
    public Map<String, Object> refreshStats(@RequestParam(required = false) String type) {
        // DB에서 최신 수치와 시간을 다시 조회하여 Map으로 반환
        // AdminService의 getDashboardStats()가 항상 DB 최신본을 가져오는지 확인 필요
        Map<String, Object> stats = adminService.getDashboardStats();
        
        log.info("[새로고침] 요청 타입: {} | 결과: {}", type, stats);
        return stats; 
    }
    
    @GetMapping("/main")
    public String adminMain(Model model) {
        // 관리자 메인 페이지 이동 로직
        return "admin/main"; // JSP 경로가 정확한지도 확인
    }
}