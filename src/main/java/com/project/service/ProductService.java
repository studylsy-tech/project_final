package com.project.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.project.dao.ProductMapper;
import com.project.model.ProductDTO;

@Service
public class ProductService {

	@Autowired
	private ProductMapper productMapper;

	// 1. 등록 메서드
	@Transactional
	public void registerNewProduct(ProductDTO product) {
		// 1. 이미 등록된 상품인지 PROD_CODE로 확인
		Integer existingId = productMapper.findIdByCode(product.getProdCode());

		if (existingId != null) {
			// 이미 있다면, 생성된 ID를 DTO에 세팅하고 종료 (컨트롤러에서 이 ID를 사용)
			product.setProdId(existingId);
			System.out.println("이미 등록된 상품입니다. 기존 ID 반환: " + existingId);
			return;
		}

		// 2. 없는 상품일 때만 신규 등록 진행
		productMapper.insertProduct(product);
		productMapper.insertPriceHistory(product);
		System.out.println("신규 상품 등록 완료. 생성된 ID: " + product.getProdId());
	}

	// 2. 상세 정보 조회 메서드 (등록 메서드 외부로 이동)
	public ProductDTO getProductById(int prodId) {
		return productMapper.getProductDetail(prodId);
	}

	// 3. 가격 이력 조회 메서드
	public List<Map<String, Object>> getPriceHistory(int prodId) {
		return productMapper.getPriceHistory(prodId);
	}

	// src/main/java/com/project/service/ProductService.java 에 추가

	public List<ProductDTO> findAllProducts() {
		return productMapper.findAllProducts(); //
	}

	public List<ProductDTO> findDropProducts() {
		return productMapper.findDropProducts(); //
	}

	public List<ProductDTO> findNewLowProducts() {
		return productMapper.findNewLowProducts(); //
	}
}