package com.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;
import com.project.util.SearchCriteria;

@Mapper
public interface ProductMapper {

    // --- 핫딜(HotDeal) 관련 메서드 ---

    // URL로 기존 핫딜 데이터 조회
    HotDealDTO findByUrl(String originUrl);

    // 신규 핫딜 저장
    void insertHotDeal(HotDealDTO hotDeal);

    // 핫딜 가격 업데이트
    void updatePrice(@Param("originUrl") String originUrl, @Param("price") long price);

    // 핫딜 전용 가격 이력 저장 (dealId 기반)
    void insertPriceHistoryByDeal(@Param("dealId") int dealId, @Param("price") long price);

    // 전체 핫딜 개수 조회 (분석용)
    int getTotalDealCount();


    // --- 일반 상품(Product) 관련 메서드 ---

    // 상품 고유 코드로 ID(PK) 조회
    Integer findIdByCode(String prodCode);

    // 신규 상품 저장 (board, develop 통합)
    int insertProduct(ProductDTO product);

    // 상품 가격 이력 저장 (ProductDTO 객체 기반)
    int insertPriceHistory(ProductDTO product);
    
    // 가격 이력 저장 (직접 파라미터 전달 방식 추가)
    void insertPriceHistoryManual(@Param("prodId") int prodId, @Param("price") long price);

    // 상세 정보 및 리스트 조회
    ProductDTO getProductDetail(int prodId);
    
    List<Map<String, Object>> getPriceHistory(int prodId);

    List<ProductDTO> findAllProducts();

    List<ProductDTO> findDropProducts();

    List<ProductDTO> findNewLowProducts();


    // --- 페이징 및 검색 (board 브랜치 추가분) ---

    // 검색 조건이 포함된 목록 조회
    List<ProductDTO> listSearch(SearchCriteria cri) throws Exception;

    // 검색 조건에 맞는 총 상품 개수 조회
    int listSearchCount(SearchCriteria cri) throws Exception;
}