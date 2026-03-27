package com.project.util;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@NoArgsConstructor
public class SearchPageMaker extends PageMaker{
	
	public SearchPageMaker(Criteria criteria,  int totalCount, int displayPageNum){
		super(criteria, totalCount, displayPageNum);
	}

	@Override
	public String query(int page) {
		SearchCriteria sCri = (SearchCriteria)criteria;
		UriComponents uriComponentsents = 
				UriComponentsBuilder.newInstance()
				.query(super.query(page))   // 부모가 만든 기존 쿼리 추가 이후 검색 쿼리 추가
//				.queryParam("page", page)
//				.queryParam("perPageNum", criteria.getPerPageNum())
				.queryParam("searchType", sCri.getSearchType())
				.queryParam("keyword",sCri.getKeyword())
				.build();
		String query = uriComponentsents.toUriString();
		return query;
	}
	
	public String makeQueryBno(int bno) {
		SearchCriteria sCri = (SearchCriteria)criteria;
		UriComponents uriComponentsents = 
				UriComponentsBuilder.newInstance()
				.queryParam("page", criteria.getPage())
				.queryParam("perPageNum", criteria.getPerPageNum())
				.queryParam("searchType", sCri.getSearchType())
				.queryParam("keyword",sCri.getKeyword())
				.queryParam("bno", bno)
				.build();
		String query = uriComponentsents.toUriString();
		return query;
	}
	
	

}






