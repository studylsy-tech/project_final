package com.project.util;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@Getter
@AllArgsConstructor
@ToString
public class Criteria {
	
	private int page;		// 요청 한 페이지
	private int perPageNum;	// 한페이지에 보여줄 게시글 수
	
	public Criteria() {
		this(1,10);
	}
	
	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	
	public void setPerPageNum(int perPageNum) {
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	// 게시글 SELECT시에 OFFSET을 활용
	// OFFSET #{시작 인덱스} ROWS FETCH NEXT #{게시물 수} ROWS ONLY           
	// OFFSET #{startRow} ROWS FETCH NEXT #{perPageNum} ROWS ONLY
	public int getStartRow() {
		return (this.page - 1) * perPageNum;
	}
	
}
