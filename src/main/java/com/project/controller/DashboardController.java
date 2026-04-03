package com.project.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.crawling.SeleniumDriver;
import com.project.model.ProductDTO;
import com.project.service.ProductService;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {

	@Autowired
	private SeleniumDriver seleniumDriver;

	// 2. 이 부분이 누락되어 에러가 발생한 것입니다. 아래 코드를 추가하세요.
	@Autowired
	private ProductService productService;

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

	@PostMapping("/register")
	public String register(ProductDTO product) {
		// 1. 서비스 호출 (DB 저장 완료 후 product 객체에 prodId가 채워짐)
		productService.registerNewProduct(product);

		// 2. 홈 대신 상세 페이지로 리다이렉트
		// 저장된 직후의 상품 번호(prodId)를 파라미터로 넘깁니다.
		return "redirect:/dashboard/detail?prodId=" + product.getProdId();
	}

	@GetMapping("/detail")
	public String productDetail(@RequestParam("prodId") int prodId, Model model) {
	    // 1. 서비스에서 데이터를 가져옴
	    ProductDTO product = productService.getProductById(prodId);
	    List<Map<String, Object>> history = productService.getPriceHistory(prodId);

	    // 2. JSP에서 사용할 변수명을 "product", "history"로 정확히 지정
	    model.addAttribute("product", product);
	    model.addAttribute("history", history);

	    return "dashboard/history_detail";
	}
}