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
    @GetMapping("/all")
    public String searchAll(@ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
        // SearchMapper 대신 수정된 ProductMapper의 메서드를 호출해야 합니다.
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
    @GetMapping("/analysis")
    public String searchAnalysis(@ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
        scri.setBoardType("HOTDEAL");
        List<HotDealDTO> list = searchMapper.getHotDealSearchList(scri);
        int totalCount = searchMapper.getHotDealSearchCount(scri);
        
        model.addAttribute("hotDealList", list);
        model.addAttribute("pageMaker", new SearchPageMaker(scri, totalCount, 5));
        return "stock/analysis"; // analysis.jsp
    }
}