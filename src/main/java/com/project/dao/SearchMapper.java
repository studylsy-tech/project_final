package com.project.dao;

import java.util.List;
import com.project.model.ProductDTO; // 본인의 ProductDTO 경로 확인
import com.project.util.SearchCriteria;

public interface SearchMapper {

    // 1. 검색 결과 리스트 가져오기
    public List<ProductDTO> getSearchList(SearchCriteria scri) throws Exception;

    // 2. 검색 결과 전체 개수 가져오기 (페이징 계산용)
    public int getSearchCount(SearchCriteria scri) throws Exception;
    
}