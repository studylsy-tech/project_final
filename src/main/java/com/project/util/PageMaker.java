package com.project.util;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageMaker {
	
	private int totalCount;			// 전체 게시물 수
	private int startPage;			// 화면에 보여질 시작 페이지 번호
	private int endPage;			// 화면에 보여질 마지막 페이지 번호
	private int maxPage;			// 전체 페이지에 마지막 페이지 번호
	private int displayPageNum;		// 한 번에 보여줄 페이지 번호 개수
	private boolean first;			// 첫 페이지 이동 가능 여부
	private boolean last;			// 마지막 페이지 이동 가능 여부
	private boolean prev;			// 이전 페이지 블럭 존재 여부
	private boolean next;			// 마지막 페이지 블럭 존재 여부
	
	protected Criteria criteria;		// 요청 페이지 , 한번에 보여줄 게시물 수
	
	public PageMaker() {
		this(new Criteria(),0, 10);
	}
	
	public PageMaker(Criteria criteria, int totalCount, int displayPageNum) {
		setCriteria(criteria);
		setTotalCount(totalCount);
		setDisplayPageNum(displayPageNum);
		calcPaging();
	}
	
	private void calcPaging() {
		endPage = (int)Math.ceil(criteria.getPage() / (double)displayPageNum)*displayPageNum;
		
		startPage = (endPage - displayPageNum) + 1;
		
		maxPage = (int)Math.ceil(totalCount / (double)criteria.getPerPageNum());
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		first = (criteria.getPage() != 1) ? true : false;
		last = (criteria.getPage() != maxPage) ? true : false;
		prev = (startPage != 1) ? true : false;
		next = (endPage == maxPage) ? false : true;
	}
	
	public void setCriteria(Criteria criteria) {
		this.criteria = criteria;
		calcPaging();
	}
	
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
		calcPaging();
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcPaging();
	}
	
	/**
	 * 
	 * @param page 이동할 페이지 번호
	 * @return 완성된 queryString : ?page=1&perPageNum=2
	 * @apiNote UriComponents : get 방식의 queryString 생성 API class
	 */
	public String query(int page) {
		UriComponents uriComponents 
			= UriComponentsBuilder.newInstance()
			  .queryParam("page",page)
			  .queryParam("perPageNum", criteria.getPerPageNum())
			  .build();
		String query = uriComponents.toUriString();
		return query;
	}
	public Criteria getCri() {
	    return criteria;
	}
	public String makeSearch(int page) {
	    UriComponents uriComponents = UriComponentsBuilder.newInstance()
	            .queryParam("page", page)
	            .queryParam("perPageNum", criteria.getPerPageNum())
	            .queryParam("searchType", ((SearchCriteria)criteria).getSearchType())
	            .queryParam("keyword", ((SearchCriteria)criteria).getKeyword())
	            .build();
	    return uriComponents.toUriString();
	}
	public void setCri(Criteria cri) {
	    this.criteria = cri;
	    calcPaging();
	}
}
