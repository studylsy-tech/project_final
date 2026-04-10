<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/css/views/board/notice_list.css">

<div class="board-wrapper">
    <div class="board-title-area">
        <h2>공지사항</h2>
        <p>플랫폼의 새로운 소식을 전해드립니다.</p>
    </div>

    <%-- 검색 영역 --%>
    <div class="search-area">
        <select id="searchType" class="search-select">
            <option value="title" ${pageMaker.cri.searchType eq 'title' ? 'selected' : ''}>제목</option>
            <option value="content" ${pageMaker.cri.searchType eq 'content' ? 'selected' : ''}>내용</option>
            <option value="writer" ${pageMaker.cri.searchType eq 'writer' ? 'selected' : ''}>작성자</option>
        </select>
        <input type="text" id="keywordInput" value="${pageMaker.cri.keyword}" 
               class="search-input" placeholder="검색어를 입력하세요">
        <button type="button" id="searchBtn" class="btn-search">검색</button>
    </div>
    
    <!-- 시간순/조회순 영역 -->
    <div class="sort-area">
	    <a href="javascript:void(0);" class="sort-link" data-sort="latest" 
	       style="${pageMaker.cri.sortType == 'latest' || empty pageMaker.cri.sortType ? 'font-weight:bold; color:#000;' : 'color:#999;'}">최신순</a>
	    <span style="margin: 0 5px; color: #ddd;">|</span>
	    <a href="javascript:void(0);" class="sort-link" data-sort="count" 
	       style="${pageMaker.cri.sortType == 'count' ? 'font-weight:bold; color:#000;' : 'color:#999;'}">조회순</a>
	</div>

    <%-- 게시판 목록 --%>
    <table class="board-table">
        <thead>
            <tr>
                <th class="col-no">번호</th>
                <th class="col-title">제목</th>
                <th class="col-writer">작성자</th>
                <th class="col-date">날짜</th>
                <th class="col-count">조회수</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty list}">
                    <c:forEach var="board" items="${list}">
                        <tr>
                            <td>${board.notice_no}</td>
                            <td class="title-cell text-left">
                                <a href="${path}/board/detail?notice_no=${board.notice_no}"> 
                                    <c:if test="${board.board_type == 'NOTICE'}">
                                        <span class="badge-notice">공지</span>
                                    </c:if> 
                                    <c:out value="${board.title}" />
                                </a>
                            </td>
                            <td>${board.writer}</td>
                            <td>${board.indate}</td>
                            <td>${board.count}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="5" class="empty-row">등록된 공지사항이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <%-- 페이징 영역 --%>
    <div class="pagination-container">
        <ul class="pagination">
            <c:if test="${pageMaker.prev}">
                <li>
                    <a href="${path}/board/notice${pageMaker.makeSearch(pageMaker.startPage - 1)}&sortType=${pageMaker.cri.sortType}">이전</a>
                </li>
            </c:if>

            <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			    <li>
			        <a href="${path}/board/notice${pageMaker.makeSearch(idx)}&sortType=${pageMaker.cri.sortType}" 
			           class="${pageMaker.cri.page == idx ? 'active' : ''}">
			            ${idx}
			        </a>
			    </li>
			</c:forEach>

            <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
                <li>
                    <a href="${path}/board/notice${pageMaker.makeSearch(pageMaker.endPage + 1)}&sortType=${pageMaker.cri.sortType}">다음</a>
                </li>
            </c:if>
        </ul>
    </div>

    <%-- 관리자 권한 확인 및 등록 버튼 --%>
	<c:if test="${loginUser.memberType == 0}">        
			<div class="board-footer" style="text-align: right; margin-top: 20px;">
	            <a href="${path}/board/write?type=NOTICE" class="btn-dark">공지등록</a>
	        </div>
	    </c:if>
	</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // 검색 버튼 클릭 이벤트
    $(document).on("click", "#searchBtn", function(e) {
        e.preventDefault();
        
        const keyword = $('#keywordInput').val();
        const searchType = $("#searchType").val();
        const perPageNum = "${pageMaker.cri.perPageNum}";
        const contextPath = "${path}";

        let url = contextPath + "/board/notice"
                + "?page=1"
                + "&perPageNum=" + (perPageNum || 10)
                + "&searchType=" + searchType
                + "&keyword=" + encodeURIComponent(keyword);

        location.href = url;
    });

    // 엔터키 지원
    $(document).on("keydown", "#keywordInput", function(e) {
        if (e.keyCode === 13) {
            $("#searchBtn").click();
        }
    });
    
 // 정렬 링크 클릭 이벤트 추가
    $(document).on("click", ".sort-link", function(e) {
        e.preventDefault();
        
        const sortType = $(this).data("sort"); // 'latest' 또는 'count'
        const searchType = "${pageMaker.cri.searchType}";
        const keyword = "${pageMaker.cri.keyword}";
        const perPageNum = "${pageMaker.cri.perPageNum}";
        const contextPath = "${path}";

        // URL 조립 (정렬 타입 추가)
        let url = contextPath + "/board/notice"
                + "?page=1" // 정렬 변경 시 1페이지로 이동
                + "&perPageNum=" + (perPageNum || 10)
                + "&searchType=" + searchType
                + "&keyword=" + encodeURIComponent(keyword)
                + "&sortType=" + sortType; // 추가된 부분

        location.href = url;
    });

    // 검색 버튼 클릭 시에도 현재 정렬 유지하도록 수정 (선택사항)
    $(document).on("click", "#searchBtn", function(e) {
        e.preventDefault();
        const keyword = $('#keywordInput').val();
        const searchType = $("#searchType").val();
        const sortType = "${pageMaker.cri.sortType}"; // 현재 정렬 기준 가져오기

        location.href = "${path}/board/notice"
                + "?page=1"
                + "&perPageNum=${pageMaker.cri.perPageNum}"
                + "&searchType=" + searchType
                + "&keyword=" + encodeURIComponent(keyword)
                + "&sortType=" + sortType;
    });
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>