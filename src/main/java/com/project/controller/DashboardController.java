package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.project.crawling.SeleniumDriver;
import com.project.model.ProductDTO;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {

    @Autowired
    private SeleniumDriver seleniumDriver;

    @GetMapping("/search")
    public String searchList(@RequestParam("query") String query, Model model) {
        List<ProductDTO> searchResults = seleniumDriver.crawlingList(query);
        model.addAttribute("searchResults", searchResults);
        return "dashboard/search_list"; // 검색 결과 목록 페이지로 이동
    }
    
    @PostMapping("/addForm")
    public String addProductForm(ProductDTO product, org.springframework.ui.Model model) {
        // 선택된 상품 정보를 모델에 담아 등록 페이지로 전달
        model.addAttribute("selectedProduct", product);
        
        // 리턴값은 JSP의 경로입니다
        return "dashboard/add_product"; 
    }
}