package com.project.service;

import java.util.List;
import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;
import com.project.util.Criteria;

public interface HotDealService {
	int fetchAndStoreDeals(int limit);
    
    // [추가] DB에서 최신 핫딜 목록을 가져오는 추상 메서드 선언
    List<HotDealDTO> getRecentDeals(); 
    
    List<ProductDTO> getNewLowProducts();
    int getTotalDealCount();

	boolean checkConnection();

	int getTotalCount();

	String getLastCollectTime();

	List<HotDealDTO> getRecentDealsPaging(Criteria cri);
}