package com.project.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.dao.ProductMapper;
import com.project.dao.SearchMapper;
import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;
import com.project.util.SearchCriteria;
import com.project.util.SearchPageMaker;

@Controller
@RequestMapping("/stock")
public class StockController {

    @Autowired
    private SearchMapper searchMapper;

    @Autowired
    private ProductMapper productMapper;
    // 1. 전체 상품 검색 (Common_Product 전체)
 // StockController.java
    @GetMapping("/all")
    public String searchAll(@ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
        // 분석 페이지용 boardType이 섞이지 않도록 명시적 초기화 (필요 시)
        if ("HOTDEAL".equals(scri.getBoardType())) {
            scri.setBoardType(null);
        }

        List<ProductDTO> list = productMapper.listSearch(scri); 
        int totalCount = productMapper.listSearchCount(scri);
        
        model.addAttribute("stockList", list);
        model.addAttribute("pageMaker", new SearchPageMaker(scri, totalCount, 5));
        return "stock/stock_all";
    }

    // 2. 급락 상품 검색 (BOARD_TYPE = 'DROP')
    @GetMapping("/drop")
    public String searchDrop(@ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
        scri.setBoardType("DROP");
        List<ProductDTO> list = searchMapper.getSearchList(scri);
        int totalCount = searchMapper.getSearchCount(scri);
        
        model.addAttribute("stockList", list);
        model.addAttribute("pageMaker", new SearchPageMaker(scri, totalCount, 5));
        return "stock/stock_drop"; // stock_drop.jsp
    }

    // 3. 최저가 상품 검색 (BOARD_TYPE = 'HOT')
    @GetMapping("/low")
    public String searchLow(@ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
        scri.setBoardType("LOW"); // DB의 'HOT' 구분을 최저가(low)로 매핑
        List<ProductDTO> list = searchMapper.getSearchList(scri);
        int totalCount = searchMapper.getSearchCount(scri);
        
        model.addAttribute("stockList", list);
        model.addAttribute("pageMaker", new SearchPageMaker(scri, totalCount, 5));
        return "stock/stock_low"; // stock_low.jsp
    }

    // 4. 핫딜 분석 검색 (TB_HOTDEAL_TRACKER 테이블)
 // 2. 분석 페이지 (잘못 이동되고 있는 타겟 페이지)
    @GetMapping("/analysis")
    public String searchAnalysis(@ModelAttribute("scri") SearchCriteria scri, javax.servlet.http.HttpServletRequest request, Model model) throws Exception {
        // 상품 클릭 시 이 로그가 찍힌다면, 클라이언트에서 이 주소를 직접 호출한 것입니다.
        System.out.println("\n[CRITICAL] === /stock/analysis 강제 호출됨 ===");
        System.out.println("[CRITICAL] 요청 원인(Referer): " + request.getHeader("referer")); // 어디서 이 페이지로 왔는지 확인
        System.out.println("[CRITICAL] 전달된 파라미터: " + request.getQueryString());
        
        scri.setBoardType("HOTDEAL");
        List<HotDealDTO> list = searchMapper.getHotDealSearchList(scri);
        int totalCount = searchMapper.getHotDealSearchCount(scri);
        
        model.addAttribute("hotDealList", list);
        model.addAttribute("pageMaker", new SearchPageMaker(scri, totalCount, 5));
        return "stock/analysis";
    }
}