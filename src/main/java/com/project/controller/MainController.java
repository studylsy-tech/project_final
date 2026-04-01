package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.model.ProductDTO;
import com.project.service.ProductService;
import com.project.util.SearchCriteria;

@Controller
public class MainController {

	// 1. 서비스 이용약관
	@RequestMapping("/footer/terms.do")
	public String terms() {
		return "footer/terms"; // WEB-INF/views/footer/terms.jsp 호출
	}

	// 2. 개인정보 처리방침
	@RequestMapping("/footer/privacy.do")
	public String privacy() {
		return "footer/privacy"; // WEB-INF/views/footer/privacy.jsp 호출
	}

	// 3. 고객센터
	@RequestMapping("/footer/support.do")
	public String support() {
		return "footer/support"; // WEB-INF/views/footer/support.jsp 호출
	}
	@Autowired
    private ProductService productService;
	
	@GetMapping("/")
    public String mainHome(Model model, SearchCriteria cri) throws Exception {
        
        
        // [수정 후] 주입받은 변수명(productService)을 사용하여 메서드 호출
        List<ProductDTO> list = productService.findAllProducts(); 
        
        model.addAttribute("hotDealList", list);
        
        return "index";
    }
}