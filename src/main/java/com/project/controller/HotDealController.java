package com.project.controller;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.project.service.HotDealService;

@Controller
@RequestMapping("/admin") // JSP의 AJAX URL(/admin/...)과 일치시키기 위해 설정
public class HotDealController {

    @Autowired
    private HotDealService hotDealService;

    // 1. 실시간 핫딜 현황 조회 (개수 확인)
    @GetMapping("/getHotDealStatus.do")
    @ResponseBody
    public Map<String, Object> getHotDealStatus() {
        Map<String, Object> result = new HashMap<>();
        // 서비스의 getTotalDealCount()를 호출하여 현재 DB 개수를 반환
        result.put("HOTDEALCOUNT", hotDealService.getTotalDealCount()); 
        return result;
    }

 // 2. 핫딜 엔진 실행 (10개 수집)
    @PostMapping("/runHotDealEngine.do")
    @ResponseBody
    public Map<String, Object> runHotDealEngine() {
        Map<String, Object> result = new HashMap<>();
        try {
            // 비동기 스레드로 수집 로직 실행 (사용자가 정지할 때까지 무한 루프)
            new Thread(() -> {
                hotDealService.fetchAndStoreDeals(0); // limit 0은 무제한을 의미하도록 서비스 구현
            }).start();

            result.put("status", "success");
            result.put("message", "수집이 시작되었습니다.");
        } catch (Exception e) {
            result.put("status", "error");
        }
        return result;
    }

    // 3. 핫딜 데이터 삭제
    @PostMapping("/deleteAllDeals.do")
    @ResponseBody
    public Map<String, Object> deleteAllDeals() {
        Map<String, Object> result = new HashMap<>();
        try {
            hotDealService.deleteAllDeals(); // 서비스 메서드명 통일
            result.put("status", "success");
        } catch (Exception e) {
            result.put("status", "error");
        }
        return result;
    }
    
 // 4. 수집 정지 명령
    @PostMapping("/stopHotDealEngine.do")
    @ResponseBody
    public Map<String, Object> stopHotDealEngine() {
        Map<String, Object> result = new HashMap<>();
        try {
            // PriceTracker 등에 정지 플래그를 세우는 서비스 호출
            hotDealService.stopCrawling(); 
            result.put("status", "success");
            result.put("message", "엔진에 정지 신호를 보냈습니다.");
        } catch (Exception e) {
            result.put("status", "error");
        }
        return result;
    }
    
}