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

	    System.out.println("\n===== [데이터 추적 시작] =====");
	    List<Map<String, Object>> history = null;

	    if (prodId != null) {
	        System.out.println("▶ 요청받은 prodId: " + prodId);
	        model.addAttribute("product", productService.getProductById(prodId));
	        history = productService.getPriceHistory(prodId);
	    } 
	    else if (dealId != null) {
	        System.out.println("▶ 요청받은 dealId: " + dealId);
	        ProductDTO dealData = productService.getProductById(dealId); 
	        model.addAttribute("product", dealData); 
	        history = productService.getPriceHistory(dealId);
	    }

	    // 🔍 [핵심 로그] history 데이터의 실체 확인
	    if (history != null && !history.isEmpty()) {
	        System.out.println("✅ [성공] 조회된 이력 개수: " + history.size());
	        
	        // 첫 번째 행만 꺼내서 어떤 키(Key)가 들어있는지 확인
	        Map<String, Object> firstRow = history.get(0);
	        System.out.println("📍 [첫 번째 데이터 샘플]: " + firstRow);
	        System.out.println("🔑 [실제 사용 중인 키 목록]: " + firstRow.keySet());
	        
	        // 각 키의 값 타입도 확인 (Date인지 String인지)
	        for (String key : firstRow.keySet()) {
	            Object value = firstRow.get(key);
	            System.out.println("   - 키: [" + key + "] | 값: " + value + " | 타입: " + (value != null ? value.getClass().getName() : "null"));
	        }
	    } else {
	        System.out.println("❌ [실패] history 리스트가 비어있거나 null입니다.");
	        System.out.println("   (SQL에서 데이터가 안 들어갔거나, PROD_ID 매칭이 안 된 상태일 수 있음)");
	    }

	    System.out.println("===== [데이터 추적 종료] =====\n");

	    model.addAttribute("history", history);
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