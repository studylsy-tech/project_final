package com.project.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.model.ProductDTO;
import com.project.service.ProductService; // 1. 임포트 확인

@Controller
@RequestMapping("/stock")
public class StockController {

	@Autowired
	private ProductService productService; // 2. 의존성 주입 확인

	@GetMapping("/all")
	public String allStocks(Model model) {
		// productService를 사용하여 데이터 호출
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

	// StockController.java 에 추가
	@GetMapping("/analysis")
	public String analysisStocks(Model model) {
		// 현재는 데이터가 없으므로 빈 리스트 전달 혹은 서비스 호출
		model.addAttribute("boardTitle", "자동 분석 리포트");
		return "stock/stock_list";
	}

	@GetMapping("/new-low")
	public String newLowStocks(Model model) {
		List<ProductDTO> list = productService.findNewLowProducts();
		model.addAttribute("stockList", list);
		model.addAttribute("boardTitle", "최저가 갱신");
		return "stock/stock_list";
	}
}