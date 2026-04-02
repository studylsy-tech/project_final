package com.project.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody; // ResponseBody import 추가

import com.project.dao.FooterMapper;
import com.project.model.FooterInquiryVO;
import com.project.model.MemberDTO;
import com.project.service.HotDealService; // Service import 추가
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private FooterMapper footerMapper;

    @Autowired
    private HotDealService hotDealService;

    // 1. 관리자 메인 페이지
    @GetMapping("/main")
    public String adminMain(HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null || !"ADMIN".equals(loginUser.getMemberType())) {
            return "redirect:/member/login";
        }
        return "admin/main";
    }

    // 2. 크롤링 관리 페이지 (중복 제거 및 통합)
    @GetMapping("/crawling_manage")
    public String crawlingManage(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null || !"ADMIN".equals(loginUser.getMemberType())) {
            return "redirect:/member/login";
        }
        
        // 페이지 진입 시 초기 데이터 바인딩 (스토리보드 Screen 14 통계 카드) [cite: 348]
        int totalCount = hotDealService.getTotalCount();
        String lastTime = hotDealService.getLastCollectTime();
        boolean isDbConnected = hotDealService.checkConnection();

        model.addAttribute("totalCount", totalCount);
        model.addAttribute("lastTime", lastTime);
        model.addAttribute("isDbConnected", isDbConnected);

        return "admin/crawling_manage";
    }

    // 3. 실시간 수집 실행 API
    @RequestMapping("/fetchDeals.do")
    @ResponseBody
    public Map<String, Object> fetchDeals() {
        Map<String, Object> result = new HashMap<>();
        try {
            int newlyAdded = hotDealService.fetchAndStoreDeals(20); 
            int total = hotDealService.getTotalCount(); 
            
            result.put("status", "success");
            result.put("newlyAdded", newlyAdded);
            result.put("totalCount", total);
            result.put("lastTime", new SimpleDateFormat("HH:mm:ss").format(new Date()));
        } catch (Exception e) {
            result.put("status", "error");
            result.put("message", e.getMessage());
        }
        return result;
    }

    // 4. 상태 새로고침 API (이 메서드가 추가되어야 새로고침이 작동합니다)
    @RequestMapping(value = "/getDbStatus.do", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getDbStatus() {
        Map<String, Object> map = new HashMap<>();
        // DB 연결 상태 및 통계 정보 조회
        map.put("connected", hotDealService.checkConnection());
        map.put("totalCount", hotDealService.getTotalCount());
        map.put("lastTime", hotDealService.getLastCollectTime());
        return map;
    }
    
 // 5. 오류 로그 관리 페이지 매핑 추가
    @GetMapping("/error_logs")
    public String errorLogs(HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null || !"ADMIN".equals(loginUser.getMemberType())) {
            return "redirect:/member/login";
        }
        return "admin/error_logs"; // WEB-INF/views/admin/error_logs.jsp 호출
    }

    // 6. 공지사항 관리 페이지 매핑 추가
    @GetMapping("/notice_manage")
    public String noticeManage(HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        if (loginUser == null || !"ADMIN".equals(loginUser.getMemberType())) {
            return "redirect:/member/login";
        }
        return "admin/notice_manage"; // WEB-INF/views/admin/notice_manage.jsp 호출
    }
}
