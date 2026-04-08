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
	            .query(super.query(page))   // page, perPageNum 포함
	            .queryParam("boardType", sCri.getBoardType()) // ★ 추가: 게시판 타입 유지
	            .queryParam("searchType", sCri.getSearchType())
	            .queryParam("keyword", sCri.getKeyword())
	            .build();
	    return uriComponentsents.toUriString();
	}
	// 만약 JSP에서 makeSearch()를 사용 중이라면 이 메서드도 확인/추가 필요
	public String makeSearch(int page) {
	    SearchCriteria sCri = (SearchCriteria)criteria;
	    return UriComponentsBuilder.newInstance()
	            .queryParam("page", page)
	            .queryParam("perPageNum", sCri.getPerPageNum())
	            .queryParam("boardType", sCri.getBoardType()) // ★ 추가
	            .queryParam("searchType", sCri.getSearchType())
	            .queryParam("keyword", sCri.getKeyword())
	            .build().toUriString();
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
