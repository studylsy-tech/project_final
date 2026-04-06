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
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductMapper productMapper;

    @Override
    @Transactional
    public void registerNewProduct(ProductDTO product) {
        // 1. PROD_CODE(고유 키/URL)로 기존 상품 ID 조회
        Integer existingId = productMapper.findIdByCode(product.getProdCode()); 

        if (existingId == null) {
            // 2. 신규 상품인 경우: Common_Product에 INSERT
            productMapper.insertProduct(product); 
        } else {
            // 3. 기존 상품인 경우: ID를 설정하고 현재가(PROD_PRICE) 등 최신 정보 UPDATE
            product.setProdId(existingId);
            productMapper.updateProductPrice(product); 
        }
        
        // 4. 가격 이력 저장: 신규/기존 상관없이 호출하여 날짜별 데이터 축적
        // SQL에서 REG_DATE가 SYSDATE로 설정되어 있으므로 호출 시점의 데이터가 기록됨
        productMapper.insertPriceHistory(product); 
    }

    @Override
    public ProductDTO getProductById(int prodId) {
        return productMapper.getProductDetail(prodId);
    }

    @Override
    public ProductDTO getProductSummary(int prodId) {
        return productMapper.getProductSummary(prodId);
    }

    @Override
    public List<Map<String, Object>> getPriceHistory(int prodId) {
        return productMapper.getPriceHistory(prodId);
    }

    @Override
    public List<ProductDTO> listSearch(SearchCriteria cri) throws Exception {
        cri.calcPageRange();
        return productMapper.listSearch(cri);
    }

    @Override
    public int listSearchCount(SearchCriteria cri) throws Exception {
        return productMapper.listSearchCount(cri);
    }

    @Override
    public List<ProductDTO> findAllIntegratedList(SearchCriteria cri) throws Exception {
        cri.calcPageRange();
        return productMapper.findAllIntegratedList(
            cri.getSearchType(),
            cri.getKeyword(),
            cri.getPageStart(),
            cri.getPageEnd()
        );
    }

    @Override
    public int findAllIntegratedCount(SearchCriteria cri) throws Exception {
        return productMapper.findAllIntegratedCount(cri);
    }

    @Override
    public List<ProductDTO> findNewLowProducts() {
        return productMapper.findNewLowProducts();
    }

    @Override
    public List<ProductDTO> findDropProducts() {
        return productMapper.findDropProducts();
    }

    @Override
    public List<ProductDTO> findAllProducts() {
        return productMapper.findAllProducts();
    }
}