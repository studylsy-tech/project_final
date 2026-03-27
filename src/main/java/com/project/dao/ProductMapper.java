package com.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.model.ProductDTO;
import com.project.util.SearchCriteria;

@Mapper
public interface ProductMapper {
	// 등록 로직
	int insertProduct(ProductDTO product);
	
	int insertPriceHistory(ProductDTO product);

	Integer findIdByCode(String prodCode);

	// 조회 로직 (추가)
	ProductDTO getProductDetail(int prodId);

	List<Map<String, Object>> getPriceHistory(int prodId);

	List<ProductDTO> findAllProducts();

	List<ProductDTO> findDropProducts();

	List<ProductDTO> findNewLowProducts();
	
	
	// 페이징 및 검색 기능 포함된 목록 조회 메서드 추가
    public List<ProductDTO> listSearch(SearchCriteria cri) throws Exception;

    // 검색 조건에 맞는 총 상품 개수 조회 메서드 추가
    public int listSearchCount(SearchCriteria cri) throws Exception;
}