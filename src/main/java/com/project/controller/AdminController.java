package com.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.project.model.BoardDTO;
import com.project.model.MemberDTO;
import com.project.service.AdminService;
import com.project.service.HotDealService;
import com.project.service.BoardService;
import com.project.service.MemberService; // 추가
import com.project.util.Criteria;
import com.project.util.PageMaker;
import com.project.util.SearchCriteria;
import com.project.util.SearchPageMaker;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private HotDealService hotDealService;
    
    @Autowired
    private AdminService adminService;

    @Autowired
    private BoardService boardService;

    @Autowired
    private MemberService memberService; // MemberService 주입

    @Autowired
    private com.project.crawling.PriceTracker priceTracker; 

    // 관리자 권한 체크 로직
    private boolean isAdmin(HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("loginUser");
        return loginUser != null && loginUser.getMemberType() == 0;
    }

    // 관리자 메인 (회원 관리 대시보드 통합)
    @GetMapping("/main")
    public String adminMain(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/";

        // 1. 전체 회원 수 조회
        int totalMemberCount = memberService.getTotalMemberCount();
        model.addAttribute("totalMemberCount", totalMemberCount);

        // 2. 전체 회원 목록 조회
        List<MemberDTO> memberList = memberService.selectAllMembers();
        model.addAttribute("memberList", memberList);

        // 3. 미답변 Q&A 개수 조회
        int unansweredCount = boardService.getUnansweredCount();
        model.addAttribute("unansweredCount", unansweredCount);

        return "admin/main"; 
    }

    // 회원 강제 탈퇴 처리
    @GetMapping("/memberDelete")
    public String memberDelete(@RequestParam("phone") String phone, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/";
        
        memberService.deleteMember(phone); // 기존 탈퇴 로직 재활용
        return "redirect:/admin/main";
    }

    // 크롤링 상태 관리 페이지 이동
    @GetMapping("/crawling_status")
    public String crawlingStatus(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/";
        return "admin/crawling_status";
    }

 // 공지사항 관리 페이지 이동 (수정본)
    @GetMapping("/notice_manage")
    public String noticeManage(SearchCriteria scri, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/";

        // 10개씩 보여주기 설정
        scri.setPerPageNum(10);
        scri.setBoardType("NOTICE");

        // 페이징된 목록과 전체 개수 조회
        List<BoardDTO> noticeList = boardService.getNoticeListPaging(scri);
        int totalCount = boardService.getNoticeCount();

        // SearchPageMaker 활용
        SearchPageMaker pageMaker = new SearchPageMaker();
        pageMaker.setCri(scri);
        pageMaker.setTotalCount(totalCount);
        pageMaker.setDisplayPageNum(5); 

        model.addAttribute("noticeList", noticeList);
        model.addAttribute("pm", pageMaker);
        
        return "admin/notice_manage";
    }

    // 상태 변경을 처리할 매핑 추가
    @GetMapping("/updateNoticeStatus")
    public String updateNoticeStatus(@RequestParam("notice_no") int no, 
                                     @RequestParam("status") String status, 
                                     HttpSession session) {
        if (!isAdmin(session)) return "redirect:/";
        
        boardService.updateBoardStatus(no, status);
        return "redirect:/admin/notice_manage";
    }

    @PostMapping("/startPriceUpdate.do")
    @ResponseBody
    public Map<String, Object> startPriceUpdate(@RequestParam String target) {
        Map<String, Object> result = new HashMap<>();
        try {
            int updatedCount = 0;
            if ("HOT".equals(target) || "ALL".equals(target)) {
                updatedCount += hotDealService.fetchAndRecordHotDeals(); 
            }
            if ("NORMAL".equals(target) || "ALL".equals(target)) {
                updatedCount += hotDealService.fetchAndRecordNormalProducts();
            }
            result.put("status", "success");
            result.put("count", updatedCount);
        } catch (Exception e) {
            result.put("status", "error");
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/stopPriceUpdate.do")
    @ResponseBody
    public Map<String, Object> stopUpdate() {
        Map<String, Object> res = new HashMap<>();
        try {
            priceTracker.requestStop(); 
            res.put("status", "success");
            res.put("message", "정지 신호를 보냈습니다.");
        } catch (Exception e) {
            res.put("status", "error");
            res.put("message", e.getMessage());
        }
        return res;
    }
 // [수정] 상세 회원 관리 페이지 이동
 // AdminController.java 수정
    @GetMapping("/members")
    public String memberManagePage(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/";

        List<MemberDTO> memberList = memberService.selectAllMembers();
        model.addAttribute("memberList", memberList);
        
        int totalMemberCount = memberService.getTotalMemberCount();
        model.addAttribute("totalMemberCount", totalMemberCount);

        // 실제 파일명이 members.jsp라면 아래와 같이 수정해야 합니다.
        return "admin/members"; 
    }
    /**
     * 핫딜 수집 엔진 설정 페이지 이동
     * 기존 '크롤링 정책'에서 서비스 성격에 맞게 '핫딜 수집 엔진'으로 명칭 변경
     */
    @GetMapping("/hotdeal_engine")
    public String hotdealEnginePage(HttpSession session, Model model) {
        // 1. 관리자 권한 확인 (memberType == 0)
        if (!isAdmin(session)) return "redirect:/";
        
        // 2. 필요 시 DB에서 현재 수집 사이트 목록 및 설정값을 조회하여 model에 담는 로직 확장 가능
        // 예: List<HotdealSourceDTO> engineSettings = adminService.getEngineSettings();
        // model.addAttribute("settings", engineSettings);
        
        // 3. 핫딜 전용 엔진 설정 JSP 반환
        return "admin/hotdeal_engine"; 
    }
    
    @GetMapping("/error_logs")
    public String errorLogs() {
        return "admin/error_logs"; 
    }
    
 // [추가] 시세 관리 페이지 수치 새로고침 (Ajax 응답용)
    @GetMapping("/refreshStats.do")
    @ResponseBody
    public Map<String, Object> refreshStats(HttpSession session) {
        // 관리자 권한 체크 (안전을 위해)
        if (!isAdmin(session)) {
            Map<String, Object> error = new HashMap<>();
            error.put("status", "error");
            error.put("message", "권한이 없습니다.");
            return error;
        }

        // adminService를 통해 대시보드 통계 수치(TOTALCOUNT, HOTDEALLASTSYNC 등)를 가져옵니다.
        return adminService.getDashboardStats();
    }
}