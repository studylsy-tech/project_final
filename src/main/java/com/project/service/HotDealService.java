package com.project.service;

import java.util.List;
import java.util.Map;

import com.project.model.BoardDTO;
import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;
import com.project.util.Criteria;

public interface HotDealService {

    // 데이터 수집 및 상태 확인
    int fetchAndStoreDeals(int limit);
    boolean checkConnection();
    String getLastCollectTime();
    int getTotalCount();
    int getTotalDealCount();

    // 핫딜 목록 조회
    List<HotDealDTO> getRecentDeals();
    List<HotDealDTO> getRecentDealsPaging(Criteria cri);
    
    // 상세 정보 및 이력
    HotDealDTO getHotDealSummary(int dealId);
    List<Map<String, Object>> getPriceHistory(int dealId);

    // 상품 관련 연동
    List<ProductDTO> getNewLowProducts();
BoardDTO selectBoardDetail(int noticeNo);
    
    void updateCount(int noticeNo);
	int fetchAndRecordHotDeals();
	int fetchAndRecordNormalProducts();
	void deleteAllDeals();
	void stopCrawling();
    
    
}