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

	void updateCurrentPrice(int prodId, int currentPrice);

	void insertCommonPriceHistory(int prodId, int currentPrice);

	List<ProductDTO> getNormalProductList();

	void deleteHotDeals();
    
}