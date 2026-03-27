package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.model.ProductDTO;
import com.project.service.ProductService; // 1. 임포트 확인
import com.project.util.SearchCriteria;
import com.project.util.SearchPageMaker;

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
	
	
	// 목록 리스트
	@GetMapping("/list")
	public String list(SearchCriteria cri, Model model) throws Exception {
	    
	    // 페이징/검색 통합 서비스 호출
	    List<ProductDTO> list = productService.listSearch(cri);
	    model.addAttribute("stockList", list);
	    
	    // 검색 조건에 맞는 전체 데이터 개수 구하기
	    int totalCount = productService.listSearchCount(cri);
	    
	    // SearchPageMaker(기준정보, 전체개수, 페이지버튼개수)
	    SearchPageMaker pageMaker = new SearchPageMaker((com.project.util.Criteria)cri, totalCount, 10);
	    
	    // 잘 나오는지 확인용도 - 추후 삭제 예정
	    System.out.println("조회된 데이터 개수: " + totalCount);
	    
	    model.addAttribute("pageMaker", pageMaker);

	    // 화면 타이틀 분기 처리
	    String title = "전체 상품 목록";
	    if ("drop".equals(cri.getSearchType())) title = "오늘의 급락 상품";
	    else if ("low".equals(cri.getSearchType())) title = "최저가 갱신";
	    else if ("analysis".equals(cri.getSearchType())) title = "자동 분석 리포트";
	    
	    model.addAttribute("boardTitle", title);

	    return "stock/stock_list";
	}
	
	
	
}