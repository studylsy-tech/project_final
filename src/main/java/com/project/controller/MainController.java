package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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

	@GetMapping("/")
	public String mainHome(Model model) {
		// 여기에 DB에서 전체 상품 리스트를 가져와서 model에 담는 로직을 추가하면
		// 홈 화면(index.jsp)에서 내가 등록한 상품들을 볼 수 있습니다.
		return "index";
	}
}