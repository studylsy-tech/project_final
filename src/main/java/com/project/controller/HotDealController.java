package com.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.project.service.HotDealService;
import com.project.model.HotDealDTO;

@Controller
public class HotDealController {

    @Autowired
    private HotDealService hotDealService;

    // 1. 핫딜 상세 페이지 처리 (404 해결 핵심)
    @GetMapping("/hotdeal/detail")
    public String getHotDealDetail(@RequestParam("dealId") int dealId, Model model) {
        // 1. 상단 정보 (제목, 현재가 등)
        HotDealDTO deal = hotDealService.getHotDealSummary(dealId);
        
        // 2. 하단 이력 (차트, 테이블) - 서비스 메서드 호출
        List<Map<String, Object>> history = hotDealService.getPriceHistory(dealId);
        
        if (deal == null) {
            return "redirect:/stock/analysis"; 
        }

        model.addAttribute("deal", deal);
        model.addAttribute("history", history); // JSP의 ${history}와 연결
        
        return "dashboard/history_detail"; 
    }

    // --- 아래는 기존 관리자 기능들입니다. 경로 앞에 /admin을 추가하여 기존 AJAX와 호환성을 유지합니다. ---

    @GetMapping("/admin/getHotDealStatus.do")
    @ResponseBody
    public Map<String, Object> getHotDealStatus() {
        Map<String, Object> result = new HashMap<>();
        result.put("HOTDEALCOUNT", hotDealService.getTotalDealCount()); 
        return result;
    }

    @PostMapping("/admin/runHotDealEngine.do")
    @ResponseBody
    public Map<String, Object> runHotDealEngine() {
        Map<String, Object> result = new HashMap<>();
        try {
            new Thread(() -> {
                hotDealService.fetchAndStoreDeals(0);
            }).start();
            result.put("status", "success");
            result.put("message", "수집이 시작되었습니다.");
        } catch (Exception e) {
            result.put("status", "error");
        }
        return result;
    }

    @PostMapping("/admin/deleteAllDeals.do")
    @ResponseBody
    public Map<String, Object> deleteAllDeals() {
        Map<String, Object> result = new HashMap<>();
        try {
            hotDealService.deleteAllDeals();
            result.put("status", "success");
        } catch (Exception e) {
            result.put("status", "error");
        }
        return result;
    }
    
    @PostMapping("/admin/stopHotDealEngine.do")
    @ResponseBody
    public Map<String, Object> stopHotDealEngine() {
        Map<String, Object> result = new HashMap<>();
        try {
            hotDealService.stopCrawling(); 
            result.put("status", "success");
            result.put("message", "엔진에 정지 신호를 보냈습니다.");
        } catch (Exception e) {
            result.put("status", "error");
        }
        return result;
    }
}