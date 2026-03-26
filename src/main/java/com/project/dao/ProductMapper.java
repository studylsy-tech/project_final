package com.project.dao;

import java.util.List;
import java.util.Map;
import com.project.model.ProductDTO;
import org.apache.ibatis.annotations.Mapper;

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
}