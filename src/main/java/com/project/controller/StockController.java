package com.project.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.model.ProductDTO;
import com.project.service.ProductService;
import com.project.service.HotDealService; // 서비스 임포트 확인

@Controller
@RequestMapping("/stock")
public class StockController {

    @Autowired
    private ProductService productService;

    @Autowired
    private HotDealService hotDealService; // 필드 주입 위치 통합

    @GetMapping("/all")
    public String allStocks(Model model) {
        List<ProductDTO> list = productService.findAllProducts();
        model.addAttribute("stockList", list);
        model.addAttribute("boardTitle", "전체 상품 목록");
        return "stock/stock_list";
    }

    @GetMapping("/drop")
    public String dropStocks(Model model) {
        List<ProductDTO> list = productService.findDropProducts();
        model.addAttribute("stockList", list);
        model.addAttribute("boardTitle", "오늘의 급락 상품");
        return "stock/stock_list";
    }

    // 두 메서드를 하나로 통합한 분석 메서드
    @GetMapping("/analysis")
    public String stockAnalysis(Model model) {
        // 1. 기존의 제목 설정 기능 통합
        model.addAttribute("boardTitle", "자동 분석 리포트");

        // 2. 새로운 핫딜 및 최저가 데이터 추가
        model.addAttribute("lowPriceList", hotDealService.getNewLowProducts());
        model.addAttribute("totalCount", hotDealService.getTotalDealCount());
        
        // 3. 리턴 페이지 결정 (분석 전용 페이지인 stock/analysis로 이동)
        return "stock/analysis";
    }

    @GetMapping("/new-low")
    public String newLowStocks(Model model) {
        List<ProductDTO> list = productService.findNewLowProducts();
        model.addAttribute("stockList", list);
        model.addAttribute("boardTitle", "최저가 갱신");
        return "stock/stock_list";
    }
}