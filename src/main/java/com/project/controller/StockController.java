package com.project.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;
import com.project.service.ProductService;
import com.project.service.HotDealService; // 서비스 임포트 확인
@Controller
@RequestMapping("/stock")
public class StockController {

    @Autowired
    private ProductService productService;

    @Autowired
    private HotDealService hotDealService;

    // 중복된 @GetMapping("/analysis")를 하나로 통합
    @GetMapping("/analysis")
    public String combinedAnalysis(Model model) {
        // 1. 기존 기능: 최저가 경신 상품 및 통계
        model.addAttribute("boardTitle", "실시간 핫딜 자동분석 리포트");
        model.addAttribute("lowPriceList", hotDealService.getNewLowProducts());
        model.addAttribute("totalCount", hotDealService.getTotalDealCount());

        // 2. 새로운 기능: 실시간 핫딜 목록 (HotDealDTO 리스트)
        List<HotDealDTO> hotDeals = hotDealService.getRecentDeals(); 
        model.addAttribute("hotDealList", hotDeals); 

        // 3. 리턴 페이지 (stock/analysis.jsp)
        return "stock/analysis";
    }
    
    // 나머지 @GetMapping("/all"), "/drop", "/new-low" 메서드는 그대로 유지
}