package com.project.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;

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

@Slf4j
@Service
@RequiredArgsConstructor
public class HotDealServiceImpl implements HotDealService {

    private final ProductMapper productMapper;
    private final HotDealMapper hotDealMapper;

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

                try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
                    StringBuilder sb = new StringBuilder();
                    String line;
                    while ((line = reader.readLine()) != null) sb.append(line);

                    JsonNode root = mapper.readTree(sb.toString());
                    JsonNode deals = root.path("data");

                    for (JsonNode deal : deals) {
                        if (newlyAddedCount >= limit) break;

                        HotDealDTO dto = new HotDealDTO();
                        dto.setOriginUrl(deal.path("post_url").asText());
                        dto.setTitle(deal.path("title").asText());
                        dto.setMallName(deal.path("site").asText("기타"));
                        dto.setCommunityName(deal.path("community_name").asText("기타"));
                        dto.setImageUrl(deal.path("thumbnail_url").asText(""));
                        
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
                }
                page++;
            }
        } catch (Exception e) {
            log.error("핫딜 수집 중 오류 발생: {}", e.getMessage());
        }
        return newlyAddedCount;
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
}