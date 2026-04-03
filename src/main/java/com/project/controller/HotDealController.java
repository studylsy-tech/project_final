package com.project.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.model.BoardDTO;
import com.project.model.HotDealDTO;
import com.project.service.HotDealService;

@Controller
@RequestMapping("/hotdeal")
public class HotDealController {

    @Autowired
    private HotDealService hotDealService; // 인스턴스 주입

    @GetMapping("/detail")
    public String hotDealDetail(@RequestParam("dealId") int dealId, Model model) {
        HotDealDTO hotDeal = hotDealService.getHotDealSummary(dealId);
        List<Map<String, Object>> history = hotDealService.getPriceHistory(dealId);

        model.addAttribute("hotDeal", hotDeal);
        model.addAttribute("history", history);

        // 변경: 기존 대시보드용 jsp 파일을 사용
        return "dashboard/history_detail"; 
    }

    
}