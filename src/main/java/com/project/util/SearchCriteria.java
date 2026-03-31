package com.project.util;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
public class SearchCriteria extends Criteria{

	private String searchType;			// 검색 column type
	private String keyword;				// 검색 단어
	private String boardType;			// 게시판 타입
	
	public SearchCriteria(int page, int perPageNum, String searchType, String keyword) {
		super(page, perPageNum);
		this.searchType = searchType;
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return super.toString()+" startRow : "+super.getStartRow()+"- SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
	}
	
	
}
