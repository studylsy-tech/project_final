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
import com.project.dao.HotDealMapper; // [추가] HotDealMapper 임포트
import com.project.dao.ProductMapper;
import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;
import com.project.util.Criteria;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class HotDealServiceImpl implements HotDealService {

    private final ProductMapper productMapper;
    private final HotDealMapper hotDealMapper;
    // [추가] SqlSession 주입을 위해 final로 선언합니다.
    //private final org.apache.ibatis.session.SqlSession sqlSession;

    // ... 기존 메서드들 (getRecentDeals, fetchAndStoreDeals 등) ...

    @Override
    public int getTotalCount() {
        try {
            return hotDealMapper.getTotalCount();
        } catch (Exception e) {
            log.error("총 개수 조회 실패: {}", e.getMessage());
            return 0; // 에러 발생 시 0 반환으로 500 에러 방지
        }
    }

    @Override
    public boolean checkConnection() {
        try {
        	// 별도의 SqlSession 주입 없이 Mapper의 간단한 메서드를 호출해봄으로써 
            // DB 연결 상태를 간접적으로 확인할 수 있습니다.
            return hotDealMapper.getTotalCount() >= 0;
        } catch (Exception e) {
            log.error("DB 연결 확인 중 오류 발생: {}", e.getMessage());
            return false;
        }
    }

    @Override
    public String getLastCollectTime() {
        try {
            String lastTime = hotDealMapper.getLastCollectTime();
            return (lastTime != null) ? lastTime : "-";
        } catch (Exception e) {
            log.error("마지막 수집 시간 조회 중 오류(테이블명 확인 필요): {}", e.getMessage());
            return "-";
        }
    }

    @Override
    @Transactional
    public int fetchAndStoreDeals(int limit) {
        int newlyAddedCount = 0;
        int page = 1;
        ObjectMapper mapper = new ObjectMapper();

        try {
            while (newlyAddedCount < limit && page <= 5) {
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

                for (JsonNode deal : deals) {
                    if (newlyAddedCount >= limit) break;

                    HotDealDTO dto = new HotDealDTO();
                    dto.setOriginUrl(deal.path("post_url").asText());
                    dto.setTitle(deal.path("title").asText());
                    dto.setMallName(deal.path("site").asText("기타"));
                    dto.setCommunityName(deal.path("community_name").asText("기타"));
                    
                 // fetchAndStoreDeals 메서드 내 이미지 수집 부분 수정
                    String imageUrl = deal.path("thumbnail_url").asText("");
                    dto.setImageUrl(imageUrl);
                    
                    String priceStr = deal.path("price").asText("0");
                    long price = Long.parseLong(priceStr.replaceAll("[^0-9]", ""));
                    dto.setCurrentPrice(price);
                    dto.setStartPrice(price);

                    int before = hotDealMapper.getTotalCount();
                    hotDealMapper.upsertHotDeal(dto); 
                    int after = hotDealMapper.getTotalCount();

                    if (after > before) {
                        newlyAddedCount++;
                    }
                }
                page++;
            }
        } catch (Exception e) {
            log.error("핫딜 수집 중 오류 발생: {}", e.getMessage());
        }
        return newlyAddedCount;
    }



    @Override
    public List<ProductDTO> getNewLowProducts() {
        // 대시보드(Screen 8)의 '이번 달 최저가 갱신' 상품 목록을 가져옵니다 [cite: 194, 228]
        return productMapper.findNewLowProducts();
    }

    @Override
    public int getTotalDealCount() {
        // 통계 카드(Screen 14)의 '오늘 수집 건수' 등을 계산하기 위해 전체 건수를 반환합니다 [cite: 348]
        return hotDealMapper.getTotalCount();
    }




    // 페이징 처리된 핫딜 목록 조회 추가 구현
    @Override
    public List<HotDealDTO> getRecentDeals() {
        // 기본적으로 첫 페이지의 10개 데이터를 가져오도록 처리하거나 
        // 전체 최신 리스트를 반환하도록 매퍼를 호출합니다.
        return hotDealMapper.getRecentDeals(); 
    }

    // 페이징 처리된 핫딜 목록 조회 (완성본)
    @Override
    public List<HotDealDTO> getRecentDealsPaging(Criteria cri) {
        // 1. 오라클 rownum 기준 시작 및 끝 번호 계산 (10개씩 보기)
        int pageEnd = cri.getPage() * cri.getPerPageNum();
        int pageStart = (cri.getPage() - 1) * cri.getPerPageNum() + 1;
        
        // 2. 매퍼 호출 (pageStart, pageEnd 파라미터 전달)
        return hotDealMapper.getRecentDealsPaging(pageStart, pageEnd);
    }

    
}