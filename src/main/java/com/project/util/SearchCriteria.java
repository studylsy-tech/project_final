package com.project.util;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
public class SearchCriteria extends Criteria {

    private String searchType;    // 검색 타입 (name, drop, low 등)
    private String keyword;       // 검색어
    private String boardType;     // 게시판 타입
    private String status;        // (게시 상태: 'Y' 등)
    
    // MyBatis rownum 범위를 위한 필드 추가
    private int pageStart;        // 시작 행 번호
    private int pageEnd;          // 끝 행 번호
    
    private String sortType = "latest"; 		  // 정렬 타입을 위한 필드
    
    public SearchCriteria(int page, int perPageNum, String searchType, String keyword) {
        super(page, perPageNum);
        this.searchType = searchType;
        this.keyword = keyword;
    }

    // Service에서 호출할 때 실제 값을 계산하여 저장하는 로직
    public void calcPageRange() {
        // 예: 1페이지고 perPageNum이 10이면 1~10, 2페이지면 11~20
        this.pageStart = (super.getPage() - 1) * super.getPerPageNum() + 1;
        this.pageEnd = super.getPage() * super.getPerPageNum();
    }

    @Override
    public String toString() {
    	return super.toString() + " Range: " + pageStart + "~" + pageEnd + 
                " [searchType=" + searchType + ", keyword=" + keyword + ", sortType=" + sortType + "]";
    }
    
    public int getPageStart() {
        // MyBatis가 #{pageStart}를 호출할 때 실시간으로 계산해서 반환
        return (super.getPage() - 1) * super.getPerPageNum() + 1;
    }

    public int getPageEnd() {
        // MyBatis가 #{pageEnd}를 호출할 때 실시간으로 계산해서 반환
        return super.getPage() * super.getPerPageNum();
    }
}