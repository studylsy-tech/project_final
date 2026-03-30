package com.project.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.crawling.SeleniumDriver;
import com.project.dao.HotDealMapper; // [추가] HotDealMapper 임포트
import com.project.dao.ProductMapper;
import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class HotDealServiceImpl implements HotDealService {

    private final ProductMapper productMapper;
    private final HotDealMapper hotDealMapper; // [추가] 핫딜 전용 매퍼 주입
    private final SeleniumDriver seleniumDriver;

    // 1. 누락되었던 인터페이스 메서드 구현
    @Override
    public List<HotDealDTO> getRecentDeals() {
        return hotDealMapper.selectRecentDeals();
    }

    @Override
    @Transactional
    public void fetchAndStoreDeals(int limit) {
        try {
            String apiUrl = "https://hotdeal.zip/api/deals.php?page=1&category=all";
            
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("User-Agent", 
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36");
            conn.setRequestProperty("Referer", "https://hotdeal.zip/");
            
            BufferedReader reader = new BufferedReader(
                new InputStreamReader(conn.getInputStream(), "UTF-8"));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) sb.append(line);
            reader.close();
            
            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(sb.toString());
            JsonNode deals = root.path("data");
            
            int count = 0;
            for (JsonNode deal : deals) {
                if (count >= limit) break;
                try {
                    HotDealDTO dto = new HotDealDTO();
                    
                    // JSON 필드명 확인됨
                    dto.setOriginUrl(deal.path("post_url").asText());
                    dto.setTitle(deal.path("title").asText());
                    dto.setMallName(deal.path("site").asText("기타"));
                    dto.setCommunityName(deal.path("community_name").asText("기타"));
                    
                    // 가격은 null인 경우 있음 ("거울 속 유령" 같은 무료 게임)
                    String priceStr = deal.path("price").asText("0");
                    long price = 0;
                    if (!priceStr.equals("null") && !priceStr.isEmpty()) {
                        price = Long.parseLong(priceStr.replaceAll("[^0-9]", ""));
                    }
                    dto.setCurrentPrice(price);
                    dto.setStartPrice(price);
                    
                    hotDealMapper.upsertHotDeal(dto);
                    count++;
                } catch (Exception e) {
                    log.error("항목 저장 실패: {}", e.getMessage());
                }
            }
            log.info("총 {}개 저장 완료", count);
            
        } catch (Exception e) {
            log.error("API 호출 오류: {}", e.getMessage());
        }
        // finally에서 seleniumDriver.closeDriver() 제거 - 더 이상 불필요
    }

    @Override
    public List<ProductDTO> getNewLowProducts() {
        return productMapper.findNewLowProducts();
    }
    
    @Override
    public int getTotalDealCount() {
        return productMapper.getTotalDealCount();
    }
}