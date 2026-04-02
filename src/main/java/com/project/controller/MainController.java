package com.project.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.model.HotDealDTO; // HotDealDTO 임포트
import com.project.model.ProductDTO;
import com.project.service.HotDealService; // HotDealService 임포트
import com.project.service.ProductService;
import com.project.util.SearchCriteria;

@Controller
public class MainController {

    @Autowired
    private ProductService productService;

    @Autowired
    private HotDealService hotDealService; // [추가] 핫딜 서비스 주입

    // 메인 홈 매핑
    @GetMapping("/")
    public String mainHome(Model model, SearchCriteria cri) throws Exception {
        
        // 1. 실시간 인기 핫딜 (TB_HOTDEAL_TRACKER 데이터)
        // [수정] 주입받은 변수 hotDealService를 사용 (static 호출 방지)
        List<HotDealDTO> hotDealList = hotDealService.getRecentDeals(); 
        
        // 2. JSP의 items="${hotDealList}"에 전달
        model.addAttribute("hotDealList", hotDealList);
        
        return "index";
    }

    // --- 하단 푸터 관련 메서드들 ---
    @RequestMapping("/footer/terms.do")
    public String terms() {
        return "footer/terms";
    }

    @RequestMapping("/footer/privacy.do")
    public String privacy() {
        return "footer/privacy";
    }

    @RequestMapping("/footer/support.do")
    public String support() {
        return "footer/support";
    }
}