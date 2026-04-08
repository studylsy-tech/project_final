package com.project.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.dao.HotDealMapper;
import com.project.dao.ProductMapper;
import com.project.model.BoardDTO;
import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;
import com.project.util.Criteria;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import com.project.crawling.PriceTracker;
import com.project.dao.AdminMapper; // 패키지 경로가 실제 파일 위치와 일치해야 함
@Slf4j
@Service
@RequiredArgsConstructor // final이 붙은 필드를 생성자 주입으로 처리
public class HotDealServiceImpl implements HotDealService {

    private final ProductMapper productMapper;
    private final HotDealMapper hotDealMapper;
    private final AdminMapper adminMapper;
    
 // 여러 스레드에서 상태를 공유하기 위해 volatile 사용
    private volatile boolean isCrawling = false;
    
    @Override
    public int fetchAndStoreDeals(int ignoredLimit) {
        isCrawling = true; 
        int newlyAddedCount = 0;
        int page = 1;
        ObjectMapper mapper = new ObjectMapper();

        log.info("핫딜 수집 엔진 시작...");

        try {
            while (isCrawling && page <= 500) {
                String apiUrl = "https://hotdeal.zip/api/deals.php?page=" + page + "&category=all";
                URL url = new URL(apiUrl);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("User-Agent", "Mozilla/5.0");

                try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
                    StringBuilder sb = new StringBuilder();
                    String line;
                    while ((line = reader.readLine()) != null) sb.append(line);

                    JsonNode root = mapper.readTree(sb.toString());
                    JsonNode deals = root.path("data");

                    if (deals.isMissingNode() || deals.size() == 0) {
                        log.info("더 이상 수집할 데이터가 없습니다. 종료합니다.");
                        break;
                    }

                    for (JsonNode deal : deals) {
                        if (!isCrawling) break;

                        // 1. 변수 선언 (price)
                        String priceStr = deal.path("price").asText("0");
                        long price = Long.parseLong(priceStr.replaceAll("[^0-9]", ""));

                        HotDealDTO dto = new HotDealDTO();
                        dto.setOriginUrl(deal.path("post_url").asText());
                        dto.setTitle(deal.path("title").asText());
                        dto.setMallName(deal.path("site").asText("기타"));
                        dto.setCommunityName(deal.path("community_name").asText("기타"));
                        dto.setImageUrl(deal.path("thumbnail_url").asText(""));
                        
                        dto.setCurrentPrice(price); 
                        dto.setStartPrice(price);

                        // 2. 변수 선언 (before)
                        int before = hotDealMapper.getTotalCount(); 

                        // 3. 메인 테이블 저장
                        hotDealMapper.upsertHotDeal(dto); 

                        // 4. 가격 이력 저장
                        int finalId = dto.getDealId();
                        if (finalId == 0) {
                            finalId = hotDealMapper.getDealIdByUrl(dto.getOriginUrl());
                        }

                        if (finalId > 0) {
                            hotDealMapper.insertPriceHistory(finalId, price);
                        }

                        // 5. 개수 비교 및 카운트
                        int after = hotDealMapper.getTotalCount();
                        if (after > before) {
                            newlyAddedCount++;
                        }
                    } // <-- for 루프 끝 (여기가 빠져있었습니다)
                }
                
                log.info("현재 {} 페이지 수집 중... (누적 신규: {})", page, newlyAddedCount);
                page++;
                Thread.sleep(500); 
            }
        } catch (Exception e) {
            log.error("수집 중 치명적 오류 발생: {}", e.getMessage());
        } finally {
            isCrawling = false; 
            log.info("핫딜 수집 엔진 정지 완료. 총 {}건 수집", newlyAddedCount);
        }
        return newlyAddedCount;
    }

    @Override
    public void stopCrawling() {
        // 정지 버튼 클릭 시 이 메서드가 호출되어 while 문을 빠져나가게 함
        this.isCrawling = false;
    }


    @Override
    public boolean checkConnection() {
        try {
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
            log.error("마지막 수집 시간 조회 중 오류: {}", e.getMessage());
            return "-";
        }
    }

    @Override
    public int getTotalCount() {
        try {
            return hotDealMapper.getTotalCount();
        } catch (Exception e) {
            log.error("총 개수 조회 실패: {}", e.getMessage());
            return 0;
        }
    }
    
    @Override
    @Transactional
    public void deleteAllDeals() {
        // AdminMapper 또는 HotDealMapper에 정의된 삭제 쿼리 호출
    	hotDealMapper.deleteAllDeals();
    }

    @Override
    public int getTotalDealCount() {
        return hotDealMapper.getTotalCount();
    }

    @Override
    public List<HotDealDTO> getRecentDeals() {
        return hotDealMapper.getRecentDeals();
    }

    @Override
    public List<HotDealDTO> getRecentDealsPaging(Criteria cri) {
        int pageEnd = cri.getPage() * cri.getPerPageNum();
        int pageStart = (cri.getPage() - 1) * cri.getPerPageNum() + 1;
        return hotDealMapper.getRecentDealsPaging(pageStart, pageEnd);
    }

    @Override
    public HotDealDTO getHotDealSummary(int dealId) {
        return hotDealMapper.getHotDealDetail(dealId);
    }

    @Override
    public List<Map<String, Object>> getPriceHistory(int dealId) {
        return hotDealMapper.getHotDealPriceHistory(dealId);
    }

    @Override
    public List<ProductDTO> getNewLowProducts() {
        return productMapper.findNewLowProducts();
    }

	@Override
	public BoardDTO selectBoardDetail(int noticeNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateCount(int noticeNo) {
		// TODO Auto-generated method stub
		
	}

	

	
	@Autowired
	private PriceTracker priceTracker;

	@Override
	public int fetchAndRecordNormalProducts() {
	    // 이제 복잡한 크롤링 로직을 여기서 직접 짜지 않고 분리된 컴포넌트에 맡깁니다.
	    return priceTracker.updateRegisteredProductPrices();
	}

	@Override
	@Transactional
	public int fetchAndRecordHotDeals() {
	    // 핫딜 전용 가격 추적 및 이력 기록 로직 호출
	    return priceTracker.updateRegisteredHotDealPrices();
	}

	
}