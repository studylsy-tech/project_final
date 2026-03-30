package com.project.dao;

import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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


    // --- 일반 상품(Product) 관련 메서드 ---

    // 상품 고유 코드로 ID(PK) 조회 (중복 제거됨)
    Integer findIdByCode(String prodCode);

    // 신규 상품 저장
    void insertProduct(ProductDTO product);

    // 상품 가격 이력 저장 (ProductDTO 객체 기반)
    void insertPriceHistory(ProductDTO product);

    // 상세 정보 및 리스트 조회
    ProductDTO getProductDetail(int prodId);
    List<Map<String, Object>> getPriceHistory(int prodId);
    
    List<ProductDTO> findAllProducts();
    List<ProductDTO> findDropProducts();
    List<ProductDTO> findNewLowProducts();

	void insertPriceHistory(int dealId, long price);

	int getTotalDealCount();
}