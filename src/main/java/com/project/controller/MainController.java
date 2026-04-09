package com.project.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.model.HotDealDTO;
import com.project.model.MemberDTO;
import com.project.service.HotDealService; // HotDealService 임포트
import com.project.service.MemberService;
import com.project.service.ProductService;
import com.project.util.SearchCriteria;

@Controller
public class MainController {

	@Autowired
	private ProductService productService;

	@Autowired
	private HotDealService hotDealService; // [추가] 핫딜 서비스 주입

	@Autowired
	private MemberService memberService;

	// 메인 홈 매핑
	@GetMapping("/")
	public String mainHome(Model model, SearchCriteria cri) throws Exception {

	    // 1. 실시간 인기 핫딜
	    List<HotDealDTO> hotDealList = hotDealService.getRecentDeals();
	    model.addAttribute("hotDealList", hotDealList);

	    // 2. 급락 순위 데이터 가져오기 [추가]
	    List<Map<String, Object>> dropList = hotDealService.getTopDroppingDeals();

	 // 콘솔 출력 (데이터가 어떻게 들어있는지 확인)
	 System.out.println("========= 급락순위 데이터 디버깅 =========");
	 if(dropList != null && !dropList.isEmpty()) {
	     for(Map<String, Object> map : dropList) {
	         System.out.println(map.toString());
	     }
	 } else {
	     System.out.println("데이터가 비어있습니다. (SQL 결과 0건)");
	 }
	 System.out.println("=======================================");

	 model.addAttribute("dropList", dropList);

	    // 3. 최저가 틱커 데이터 가져오기 [추가]
	    List<Map<String, Object>> lowestList = hotDealService.getLowestPriceDeals();
	    model.addAttribute("lowestList", lowestList);

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

	// MemberController.java에 추가
	@GetMapping("/delete")
	public String deleteMember(HttpSession session) {
		MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");

		if (loginUser != null) {
			// DB에서 삭제 수행 (식별자인 phone 사용)
			memberService.deleteMember(loginUser.getPhone());
			// 세션 무효화
			session.invalidate();
		}

		return "redirect:/"; // 메인 페이지로 이동
	}
}