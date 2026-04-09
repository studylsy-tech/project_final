package com.project.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.crawling.SeleniumDriver;
import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;
import com.project.service.HotDealService;
import com.project.service.ProductService;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {

	@Autowired
	private SeleniumDriver seleniumDriver;

	// 2. 이 부분이 누락되어 에러가 발생한 것입니다. 아래 코드를 추가하세요.
	@Autowired
	private ProductService productService;
	
    @Autowired
    private HotDealService hotDealService;
	@GetMapping("/search")
	public String searchList(@RequestParam("query") String query, Model model) {
		List<ProductDTO> searchResults = seleniumDriver.crawlingList(query);
		model.addAttribute("searchResults", searchResults);
		return "dashboard/search_list";
	}

	@PostMapping("/addForm")
	public String addProductForm(ProductDTO product, Model model) {
		model.addAttribute("selectedProduct", product);
		return "dashboard/add_product";
	}

	@GetMapping("/main")
	public String dashboardMain(Model model) {
		// 여기에 DB에서 등록된 상품 리스트를 가져오는 로직을 추후 추가하면 됩니다.
		// 현재는 페이지 이동 여부만 확인하기 위해 뷰 이름만 리턴합니다.
		return "dashboard/main"; // WEB-INF/views/dashboard/main.jsp를 호출합니다.
	}

	

	@GetMapping("/detail")
	public String productDetail(
	    @RequestParam(value = "prodId", required = false) Integer prodId, 
	    @RequestParam(value = "dealId", required = false) Integer dealId, 
	    Model model) {

	    System.out.println("\n========== [데이터 전송 직전 최종 진단] ==========");
	    
	    if (prodId != null) {
	        System.out.println("[타입] 일반 상품 요청");
	        model.addAttribute("product", productService.getProductById(prodId));
	        List<Map<String, Object>> history = productService.getPriceHistory(prodId);
	        
	        if (history != null && !history.isEmpty()) {
	            System.out.println("일반상품 첫 이력 데이터: " + history.get(0));
	        }
	        model.addAttribute("history", history);
	        model.addAttribute("isProduct", true);
	    } 
	    else if (dealId != null) {
	        System.out.println("[타입] 핫딜 상품 요청");
	        
	        // 핫딜 상세 정보
	        HotDealDTO deal = hotDealService.getHotDealSummary(dealId);
	        System.out.println("핫딜 상세 정보(DTO): " + deal);
	        model.addAttribute("deal", deal);
	        
	        // 핫딜 가격 이력
	        List<Map<String, Object>> history = hotDealService.getPriceHistory(dealId);
	        if (history != null && !history.isEmpty()) {
	            System.out.println("핫딜 이력 첫 행 데이터: " + history.get(0));
	            System.out.println("사용 중인 날짜 키값: " + history.get(0).keySet());
	        } else {
	            System.out.println("!!! 경고: 핫딜 이력 데이터(history)가 비어있습니다 !!!");
	        }
	        
	        model.addAttribute("history", history);
	        model.addAttribute("isProduct", false);
	    }
	    
	    System.out.println("========== [진단 종료] ==========\n");

	    return "dashboard/history_detail";
	}
	
	@PostMapping("/register")
	public String registerProduct(ProductDTO productDTO) {
	    try {
	        productService.registerNewProduct(productDTO);
	        // /fin_project/stock/all 페이지가 실제로 존재하는지 확인!
	        return "redirect:/stock/all"; 
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "common/error";
	    }
	}
	
}