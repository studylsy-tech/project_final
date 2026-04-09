package com.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;
import org.apache.ibatis.annotations.Param;
@Mapper
public interface HotDealMapper {
    // 1. URL 중복 체크 후 삽입/업데이트
    void upsertHotDeal(HotDealDTO dto);

    // 2. 최신 핫딜 목록 조회 (이름을 getRecentDeals로 통일)
    List<HotDealDTO> getRecentDeals(); 

    // 3. 전체 핫딜 개수 조회
    int getTotalCount();

    // 4. 마지막 수집 시간 조회
    String getLastCollectTime();

    // 5. 페이징 처리된 목록 조회
    List<HotDealDTO> getRecentDealsPaging(
        @Param("pageStart") int pageStart, 
        @Param("pageEnd") int pageEnd
    );
    
    List<ProductDTO> findMainHotDeals();

 // 핫딜 상세 정보 조회
    HotDealDTO getHotDealDetail(int dealId);
    
    // 핫딜 가격 이력 조회
    List<Map<String, Object>> getHotDealPriceHistory(int dealId);

	int deleteAllDeals();


	void insertPriceHistory(@Param("dealId") int dealId, @Param("price") long price);
	int getDealIdByUrl(@Param("originUrl") String originUrl);
	
HotDealDTO getHotDealSummary(Integer dealId);
    
    List<Map<String, Object>> getPriceHistory(Integer dealId);
    
    List<Map<String, Object>> getTopDroppingDeals();
    List<Map<String, Object>> getLowestPriceDeals();
}