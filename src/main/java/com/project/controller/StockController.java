package com.project.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;
import com.project.service.HotDealService;
import com.project.service.ProductService;
import com.project.util.SearchCriteria;
import com.project.util.SearchPageMaker;
import com.project.util.Criteria;

@Controller
@RequestMapping("/stock")
public class StockController {

    @Autowired
    private ProductService productService;

    @Autowired
    private HotDealService hotDealService;

    // 1. 전체 상품 (Common_Product + HotDeal 통합)
    @GetMapping("/all")
    public String allStocks(SearchCriteria cri, Model model) throws Exception {
        // [핵심 수정] 빈 문자열로 넘어오는 검색 조건을 null로 통합
        if (cri.getSearchType() != null && cri.getSearchType().trim().isEmpty()) {
            cri.setSearchType(null);
        }
        if (cri.getKeyword() != null && cri.getKeyword().trim().isEmpty()) {
            cri.setKeyword(null);
        }

        // 이제 totalCount가 첫 접속 때와 동일하게 (일반+핫딜) 모두 집계됩니다.
        int totalCount = productService.listSearchCount(cri);
        SearchPageMaker pageMaker = new SearchPageMaker((Criteria) cri, totalCount, 10);

        List<ProductDTO> list = productService.listSearch(cri); 

        model.addAttribute("stockList", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("boardTitle", "전체 상품 목록");

        return "stock/stock_all";
    }

    // 2. 오늘의 급락 상품
    @GetMapping("/drop")
    public String dropStocks(SearchCriteria cri, Model model) throws Exception {
        cri.setSearchType("drop"); 
        
        int totalCount = productService.listSearchCount(cri);
        
        // 번호 개수 10개 설정
        SearchPageMaker pageMaker = new SearchPageMaker((Criteria) cri, totalCount, 10);

        List<ProductDTO> list = productService.listSearch(cri); 

        model.addAttribute("stockList", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("boardTitle", "오늘의 급락 상품");
        
        return "stock/stock_drop";
    }

    // 3. 최저가 갱신 상품
    @GetMapping("/low")
    public String newLowStocks(SearchCriteria cri, Model model) throws Exception {
        cri.setSearchType("low");

        int totalCount = productService.listSearchCount(cri);

        // 번호 개수 10개 설정
        SearchPageMaker pageMaker = new SearchPageMaker((Criteria) cri, totalCount, 10);

        List<ProductDTO> list = productService.listSearch(cri); 

        model.addAttribute("stockList", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("boardTitle", "최저가 갱신");
        
        return "stock/stock_low";
    }

    // 4. 자동 분석 리포트
    @GetMapping("/analysis")
    public String analysisStocks(SearchCriteria cri, Model model) {
        int totalCount = hotDealService.getTotalDealCount();

        // 번호 개수 10개 설정
        SearchPageMaker pageMaker = new SearchPageMaker((Criteria) cri, totalCount, 10);

        List<HotDealDTO> hotDeals = hotDealService.getRecentDealsPaging(cri);

        model.addAttribute("hotDealList", hotDeals);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("boardTitle", "실시간 핫딜 자동분석 리포트");

        return "stock/analysis";
    }
}