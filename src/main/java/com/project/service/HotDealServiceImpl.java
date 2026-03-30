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
    public int fetchAndStoreDeals(int targetNewCount) {
        int currentNewCount = 0; // 이번 호출에서 실제 신규 삽입된 수
        int page = 1;
        ObjectMapper mapper = new ObjectMapper();

        // 목표치(targetNewCount)를 채울 때까지 또는 최대 5페이지까지 반복
        while (currentNewCount < targetNewCount && page <= 5) {
            try {
                String apiUrl = "https://hotdeal.zip/api/deals.php?page=" + page + "&category=all";
                URL url = new URL(apiUrl);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("User-Agent", "Mozilla/5.0");

                BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) sb.append(line);
                reader.close();

                JsonNode root = mapper.readTree(sb.toString());
                JsonNode deals = root.path("data");

                // 페이지 내의 데이터(보통 20개)를 하나씩 처리
                for (JsonNode deal : deals) {
                    if (currentNewCount >= targetNewCount) break;

                    HotDealDTO dto = new HotDealDTO();
                    dto.setOriginUrl(deal.path("post_url").asText());
                    dto.setTitle(deal.path("title").asText());
                    dto.setMallName(deal.path("site").asText("기타"));
                    dto.setCommunityName(deal.path("community_name").asText("기타"));
                    
                    String priceStr = deal.path("price").asText("0");
                    long price = Long.parseLong(priceStr.replaceAll("[^0-9]", ""));
                    dto.setCurrentPrice(price);
                    dto.setStartPrice(price);

                    // 신규 여부 판단을 위한 개수 체크
                    int beforeCount = hotDealMapper.getTotalCount();
                    hotDealMapper.upsertHotDeal(dto); // MERGE 실행
                    int afterCount = hotDealMapper.getTotalCount();

                    if (afterCount > beforeCount) {
                        currentNewCount++; // 실제 INSERT 발생 시 카운트 증가
                    }
                }
                page++; // 다음 페이지 준비
                
            } catch (Exception e) {
                log.error("페이지 {} 수집 중 오류: {}", page, e.getMessage());
                break;
            }
        }
        return currentNewCount;
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