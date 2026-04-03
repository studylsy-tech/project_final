package com.project.service;

import java.util.List;
import java.util.Map;
import com.project.model.ProductDTO;
import com.project.util.SearchCriteria;

public interface ProductService {

    // 상품 등록 및 상세 조회
    void registerNewProduct(ProductDTO product);
    ProductDTO getProductById(int prodId);
    ProductDTO getProductSummary(int prodId);
    List<Map<String, Object>> getPriceHistory(int prodId);

    // 일반 검색 리스트 (급락/최저가 등)
    List<ProductDTO> listSearch(SearchCriteria cri) throws Exception;
    int listSearchCount(SearchCriteria cri) throws Exception;

    // 전체 통합 리스트
    List<ProductDTO> findAllIntegratedList(SearchCriteria cri) throws Exception;
    int findAllIntegratedCount(SearchCriteria cri) throws Exception;

    // 메인화면용 상품 리스트
    List<ProductDTO> findNewLowProducts();
    List<ProductDTO> findDropProducts();
    List<ProductDTO> findAllProducts();
}