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
	    System.out.println("\n========= [급락순위 SQL 결과 디버깅] =========");
	    if(dropList != null && !dropList.isEmpty()) {
	        System.out.println("성공: " + dropList.size() + "건의 급락 데이터 조회됨.");
	        for(Map<String, Object> map : dropList) {
	            System.out.println(" > " + map.toString());
	        }
	    } else {
	        System.out.println("결과: [0건] - 아래 원인 중 하나일 확률이 높습니다.");
	        System.out.println("-------------------------------------------");
	        System.out.println(" 1. 가격 이력이 1회만 수집됨 (과거 가격이 없음)");
	        System.out.println(" 2. 현재가가 이전 가격보다 떨어진 상품이 없음");
	        System.out.println(" 3. DB 테이블 자체가 비어있음");
	        System.out.println("-------------------------------------------");
	        
	        // [추가] 실제 DB에 이력이 몇 개 쌓여있는지 찍어보면 확실합니다.
	        // adminService나 hotDealService에 카운트 쿼리가 있다면 호출해보세요.
	        // 예: System.out.println("참고: 현재 DB 이력 총 건수 = " + hotDealService.getTotalHistoryCount());
	    }
	    System.out.println("============================================\n");

	 model.addAttribute("dropList", dropList);

	    // 3. 최저가 틱커 데이터 가져오기 [추가]
	    List<Map<String, Object>> lowestList = hotDealService.getLowestPriceDeals();
	 // MainController.java 틱커 부분


	    System.out.println("\n========== [최저가 틱커 실데이터 최종 검증] ==========");
	    if (lowestList != null && !lowestList.isEmpty()) {
	        for (int i = 0; i < lowestList.size(); i++) {
	            Map<String, Object> low = lowestList.get(i);
	            
	            // 1. Map에 실제로 존재하는 모든 키와 값을 통째로 출력
	            System.out.println((i + 1) + "번 상품 전체 데이터: " + low.toString());

	            // 2. 대소문자 무관하게 값을 안전하게 꺼내서 출력해보기
	            Object idVal = low.get("id") != null ? low.get("id") : low.get("ID");
	            Object titleVal = low.get("title") != null ? low.get("title") : low.get("TITLE");
	            Object typeVal = low.get("type") != null ? low.get("type") : low.get("TYPE");

	            System.out.println("   -> [추출 결과] ID: " + idVal + " | 제목: " + titleVal + " | 타입: " + typeVal);
	        }
	    } else {
	        System.out.println("!! 틱커 리스트가 비어있습니다 !!");
	    }
	    System.out.println("====================================================\n");
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