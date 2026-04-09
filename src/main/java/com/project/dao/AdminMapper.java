package com.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.model.BoardDTO;
import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;
import com.project.util.SearchCriteria;

@Mapper
public interface AdminMapper {
    // SearchCriteria를 사용하여 페이징 및 검색 처리
    List<BoardDTO> selectBoardListPaging(SearchCriteria scri);
    
    // SearchCriteria를 사용하여 게시글 개수 조회
    int getBoardCount(SearchCriteria scri);
    
    // 기존 상세 조회 및 삽입/조회수 메서드 유지
    BoardDTO selectBoardDetail(int notice_no);
    void insertBoard(BoardDTO board);
    void updateCount(int notice_no);
    
 // 핫딜 정보 저장 (있으면 UPDATE, 없으면 INSERT)
    void upsertHotDeal(HotDealDTO deal);

    // 가격 이력 단건 저장 (스냅샷)
    void insertPriceHistory(@Param("dealId") int dealId, @Param("price") int price);

    List<HotDealDTO> getHotDealList();
    void updateHotDealPrice(@Param("dealId") int dealId, @Param("price") long price);
    void insertHotDealPriceHistory(@Param("dealId") int dealId, @Param("price") long price);
	Map<String, Object> getDashboardStats();

	
	void deleteHotDeals();
	
	// 1. 일반 상품 리스트 가져오기
	List<ProductDTO> getNormalProductList();

	// 2. 메인 테이블 현재가 갱신
	void updateCurrentPrice(@Param("prodId") int prodId, @Param("currentPrice") int currentPrice);

	// 3. 이력 테이블(그래프용) 데이터 추가
	void insertCommonPriceHistory(@Param("prodId") int prodId, @Param("currentPrice") int currentPrice);

	// 핫딜 전용 이력 조회
	List<Map<String, Object>> getHotDealPriceHistory(@Param("dealId") int dealId);

	// 일반 제품 전용 이력 조회 (이름을 일반 제품용으로 변경)
	List<Map<String, Object>> getNormalPriceHistory(@Param("prodId") int prodId);
}
