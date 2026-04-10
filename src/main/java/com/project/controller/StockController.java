package com.project.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
        // 1. 로그로 값이 오는지 확인
        System.out.println("급락 검색 타입: " + scri.getSearchType());
        System.out.println("급락 검색어: " + scri.getKeyword());

        scri.setBoardType("DROP"); // 필요하다면 유지

        // 2. productMapper를 호출하도록 변경! (이게 핵심입니다)
        List<ProductDTO> list = productMapper.listSearch(scri); 
        int totalCount = productMapper.listSearchCount(scri);
        
        model.addAttribute("stockList", list);
        model.addAttribute("pageMaker", new SearchPageMaker(scri, totalCount, 5));
        return "stock/stock_drop";
    }

    @GetMapping("/low")
    public String searchLow(@ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
        // 1. 로그를 찍어서 검색어가 잘 들어오는지 확인 (핵심!)
        System.out.println("검색 타입: " + scri.getSearchType());
        System.out.println("검색어: " + scri.getKeyword());

        // 2. productMapper의 listSearch를 호출하도록 변경
        // (사용자님이 열심히 고친 XML 쿼리가 이 메서드니까요!)
        List<ProductDTO> list = productMapper.listSearch(scri); 
        int totalCount = productMapper.listSearchCount(scri);
        
        model.addAttribute("stockList", list);
        model.addAttribute("pageMaker", new SearchPageMaker(scri, totalCount, 5));
        return "stock/stock_low";
    }

    // 4. 핫딜 분석 검색 (TB_HOTDEAL_TRACKER 테이블)
 // 2. 분석 페이지 (상세 정보를 보여주도록 로직 수정)
    @GetMapping("/analysis")
    public String searchAnalysis(@ModelAttribute("scri") SearchCriteria scri, 
                                 @RequestParam(value="prodId", required=false) Integer prodId, 
                                 Model model) throws Exception {
        
        // [추가] 상품 상세 보기 로직
        if (prodId != null) {
            System.out.println("▶ [상세조회] 상품 ID: " + prodId);
            
            // 1. 상품 기본 정보 가져오기 (ProductMapper 활용)
            ProductDTO product = productMapper.read(prodId); // 또는 getProductDetail
            model.addAttribute("product", product);
            
            // 2. 가격 변동 이력 가져오기
            List<Map<String, Object>> history = productMapper.getPriceHistory(prodId);
            model.addAttribute("history", history);
            
            // 상세 페이지 JSP로 바로 이동 (리스트 검색 로직을 타지 않음)
            return "admin/product_detail"; 
        }

        // [기존] prodId가 없을 때는 원래대로 검색 리스트 조회
        scri.setBoardType("HOTDEAL");
        List<HotDealDTO> list = searchMapper.getHotDealSearchList(scri);
        int totalCount = searchMapper.getHotDealSearchCount(scri);
        
        model.addAttribute("hotDealList", list);
        model.addAttribute("pageMaker", new SearchPageMaker(scri, totalCount, 5));
        
        return "stock/analysis"; // 리스트 페이지
    }
}