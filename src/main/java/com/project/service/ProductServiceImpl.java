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
        Integer existingId = productMapper.findIdByCode(product.getProdCode());
        if (existingId != null) {
            product.setProdId(existingId);
            return;
        }
        productMapper.insertProduct(product);
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