package com.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.ProductMapper;
import com.project.model.ProductDTO;
import com.project.util.SearchCriteria;

@Service
public class ProductService {

    @Autowired
    private ProductMapper productMapper;

    // --- [1] 상품 등록 및 상세 조회 로직 ---
    @Transactional
    public void registerNewProduct(ProductDTO product) {
        Integer existingId = productMapper.findIdByCode(product.getProdCode());
        if (existingId != null) {
            product.setProdId(existingId);
            return;
        }
        productMapper.insertProduct(product);
        productMapper.insertPriceHistory(product);
    }

    public ProductDTO getProductById(int prodId) {
        return productMapper.getProductDetail(prodId);
    }

    public List<Map<String, Object>> getPriceHistory(int prodId) {
        return productMapper.getPriceHistory(prodId);
    }

    // --- [2] ProductController 전용 (급락/최저가 등 일반 리스트) ---
    public List<ProductDTO> listSearch(SearchCriteria cri) throws Exception {
        // SearchCriteria에 추가한 계산 메서드 활용
        cri.calcPageRange(); 
        return productMapper.listSearch(cri);
    }

    public int listSearchCount(SearchCriteria cri) throws Exception {
        // 0 대신 실제 매퍼의 카운트 쿼리를 호출해야 페이징 번호가 나옵니다.
        return productMapper.listSearchCount(cri);
    }

    // --- [3] AllProductController 전용 (전체 통합 리스트) ---
    public List<ProductDTO> findAllIntegratedList(SearchCriteria cri) throws Exception {
        // 페이징 범위 계산 (pageStart, pageEnd 세팅)
        cri.calcPageRange(); 
        
        return productMapper.findAllIntegratedList(
            cri.getSearchType(), 
            cri.getKeyword(), 
            cri.getPageStart(), 
            cri.getPageEnd()
        );
    }

    public int findAllIntegratedCount(SearchCriteria cri) throws Exception {
        return productMapper.findAllIntegratedCount(cri);
    }

	public List<ProductDTO> findNewLowProducts() {
		// TODO Auto-generated method stub
		return null;
	}

	public List<ProductDTO> findDropProducts() {
		// TODO Auto-generated method stub
		return null;
	}

	public List<ProductDTO> findAllProducts() {
		// DAO 또는 Mapper의 메서드를 호출하여 반환합니다.
		return productMapper.findNewLowProducts();	}

    
}