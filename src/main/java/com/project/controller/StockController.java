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
import com.project.service.HotDealService;
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

    // 1. 전체 상품 목록 (stock_all 페이지 사용)
    @GetMapping("/all")
    public String allStocks(SearchCriteria cri, Model model) throws Exception {
        List<ProductDTO> list = productService.listSearch(cri); 
        int totalCount = productService.listSearchCount(cri);

        SearchPageMaker pageMaker = new SearchPageMaker((Criteria) cri, totalCount, 10);

        model.addAttribute("stockList", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("boardTitle", "전체 상품 목록");

        return "stock/stock_all"; 
    }

    // 2. 오늘의 급락 상품
    @GetMapping("/drop")
    public String dropStocks(Model model) {
        List<ProductDTO> list = productService.findDropProducts();
        model.addAttribute("stockList", list);
        model.addAttribute("boardTitle", "오늘의 급락 상품");
        return "stock/stock_list";
    }

    // 3. 최저가 갱신 상품
    @GetMapping("/new-low")
    public String newLowStocks(Model model) {
        List<ProductDTO> list = productService.findNewLowProducts();
        model.addAttribute("stockList", list);
        model.addAttribute("boardTitle", "최저가 갱신");
        return "stock/stock_list";
    }

    // 4. 자동 분석 리포트 (핫딜 기반)
    @GetMapping("/analysis")
    public String analysisStocks(SearchCriteria cri, Model model) {
        cri.setPerPageNum(10); // 한 페이지당 10개 출력

        // 데이터 및 전체 개수 조회
        List<HotDealDTO> hotDeals = hotDealService.getRecentDealsPaging(cri);
        int totalCount = hotDealService.getTotalDealCount();

        // 페이징 설정
        SearchPageMaker pageMaker = new SearchPageMaker((Criteria) cri, totalCount, 10);

        model.addAttribute("hotDealList", hotDeals);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("boardTitle", "실시간 핫딜 자동분석 리포트");

        return "stock/analysis";
    }

    // 5. 통합 리스트 (검색 타입에 따른 동적 처리)
    @GetMapping("/list")
    public String list(SearchCriteria cri, Model model) throws Exception {
        List<ProductDTO> list = productService.listSearch(cri);
        int totalCount = productService.listSearchCount(cri);

        SearchPageMaker pageMaker = new SearchPageMaker((Criteria) cri, totalCount, 10);

        // 검색 타입(searchType)에 따른 타이틀 동적 설정
        String title = "전체 상품 목록";
        String searchType = cri.getSearchType();
        
        if (searchType != null) {
            switch (searchType) {
                case "name": title = "상품 검색 결과"; break;
                case "drop": title = "오늘의 급락 상품"; break;
                case "low":  title = "최저가 갱신"; break;
                case "analysis": title = "자동 분석 리포트"; break;
            }
        }

        model.addAttribute("stockList", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("boardTitle", title);

        return "stock/stock_list";
    }
}