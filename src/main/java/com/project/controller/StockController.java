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
import com.project.util.PageMaker;

@Controller
@RequestMapping("/stock")
public class StockController {

@Autowired
private ProductService productService;

@Autowired
private HotDealService hotDealService;

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

@GetMapping("/new-low")
public String newLowStocks(Model model) {
    List<ProductDTO> list = productService.findNewLowProducts();
    model.addAttribute("stockList", list);
    model.addAttribute("boardTitle", "최저가 갱신");
    return "stock/stock_list";
}

@GetMapping("/analysis")
public String analysisStocks(Criteria cri, Model model) {
    // 1. 한 페이지당 보여줄 게시글 수를 10개로 강제 설정 (기본값이 10이면 생략 가능)
    cri.setPerPageNum(10); 

    // 2. 전체 핫딜 개수 조회 (PageMaker 계산용)
    int totalCount = hotDealService.getTotalDealCount(); 

    // 3. 페이징 처리된 핫딜 목록 조회 (Service에 해당 메서드 구현 필요)
    List<HotDealDTO> hotDeals = hotDealService.getRecentDealsPaging(cri); 

    // 4. PageMaker 설정
    PageMaker pageMaker = new PageMaker();
    pageMaker.setCriteria(cri);
    pageMaker.setTotalCount(totalCount);

    model.addAttribute("boardTitle", "실시간 핫딜 자동분석 리포트");
    model.addAttribute("hotDealList", hotDeals); 
    model.addAttribute("pageMaker", pageMaker);
    model.addAttribute("totalCount", totalCount);

    return "stock/analysis";
}

@GetMapping("/list")
public String list(SearchCriteria cri, Model model) throws Exception {
    List<ProductDTO> list = productService.listSearch(cri);
    int totalCount = productService.listSearchCount(cri);
    
    SearchPageMaker pageMaker = new SearchPageMaker((Criteria)cri, totalCount, 10);
    
    model.addAttribute("stockList", list);
    model.addAttribute("pageMaker", pageMaker);

    String title = "전체 상품 목록";
    if ("drop".equals(cri.getSearchType())) title = "오늘의 급락 상품";
    else if ("low".equals(cri.getSearchType())) title = "최저가 갱신";
    else if ("analysis".equals(cri.getSearchType())) title = "자동 분석 리포트";
    
    model.addAttribute("boardTitle", title);

    return "stock/stock_list";
}
}