<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/board/qna_list.css">

<div class="board-wrapper">
    <div class="board-title-area">
        <h2>Q&A</h2>
        <p>궁금하신 점을 남겨주시면 답변해 드립니다.</p>
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
    <a href="javascript:void(0);" class="sort-link" data-sort="default" 
   style="${empty pageMaker.cri.sortType or pageMaker.cri.sortType eq 'default' ? 'font-weight:bold; color:#000;' : 'color:#999;'}">기본순</a>
    <span style="margin: 0 5px; color: #ddd;">|</span>
    
    <a href="javascript:void(0);" class="sort-link" data-sort="latest" 
       style="${pageMaker.cri.sortType == 'latest' ? 'font-weight:bold; color:#000;' : 'color:#999;'}">최신순</a>
    <span style="margin: 0 5px; color: #ddd;">|</span>
    
    <a href="javascript:void(0);" class="sort-link" data-sort="count" 
       style="${pageMaker.cri.sortType == 'count' ? 'font-weight:bold; color:#000;' : 'color:#999;'}">조회순</a>
</div>
	
    <table class="board-table">
        <thead>
            <tr>
                <th class="col-no">번호</th>
                <th class="col-title">제목</th>
                <th class="col-writer">작성자</th>
                <th class="col-status">상태</th>
                <th class="col-date">날짜</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty list}">
                    <c:forEach items="${list}" var="board">
                        <tr>
                            <td>${board.notice_no}</td>
                            <td class="title-cell text-left">
                                <%-- 답변글(자식글)일 경우에만 들여쓰기 표시 --%>
<c:if test="${board.parent_no > 0}">
    <span class="reply-indent" style="margin-left: 15px;">└ </span>
</c:if>
                                <a href="${path}/board/detail?notice_no=${board.notice_no}">
                                    <c:out value="${board.title}" />
                                </a>
                            </td>
                            <td>${board.writer}</td>
                            <td>
                                <c:choose>
    <c:when test="${board.parent_no > 0}">
        <%-- 부모 번호가 있다면 이건 답글 자체임 --%>
        <span class="badge-status bg-gray">답변글</span>
    </c:when>
    <c:when test="${board.is_reply == 1}">
        <%-- 부모 번호가 0인데 is_reply가 1이라면 답변이 달린 원문임 --%>
        <span class="badge-status bg-success" style="color: green;">답변완료</span>
    </c:when>
    <c:otherwise>
        <%-- 그 외에는 아직 답변이 없는 원문 --%>
        <span class="badge-status bg-danger" style="color: red;">미답변</span>
    </c:otherwise>
</c:choose>
                            </td>
                            <td>${board.indate}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="5" class="empty-row" style="text-align:center; padding: 20px;">등록된 문의사항이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <%-- 페이징 처리 영역 --%>
    <div class="pagination-container" style="text-align: center; margin-top: 30px;">
        <ul class="pagination" style="display: inline-flex; list-style: none; padding: 0;">
            <c:if test="${pageMaker.prev}">
                <li style="margin: 0 5px;">
                    <a href="${path}/board/qna${pageMaker.makeSearch(pageMaker.startPage - 1)}&sortType=${pageMaker.cri.sortType}">이전</a>
                </li>
            </c:if>

            <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			    <li style="margin: 0 5px;">
			        <a href="${path}/board/qna${pageMaker.makeSearch(idx)}&sortType=${pageMaker.cri.sortType}" 
			           class="${pageMaker.cri.page == idx ? 'active' : ''}"
			           style="${pageMaker.cri.page == idx ? 'font-weight: bold; color: blue;' : ''}">
			             ${idx}
			        </a>
			    </li>
			</c:forEach>

            <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
                <li style="margin: 0 5px;">
                    <a href="${path}/board/qna${pageMaker.makeSearch(pageMaker.endPage + 1)}&sortType=${pageMaker.cri.sortType}">다음</a>
                </li>
            </c:if>
        </ul>
    </div>

    <%-- 버튼 영역 --%>
    <div class="board-footer" style="text-align: right; margin-top: 20px;">
        <a href="${path}/board/qnaWrite" class="btn-dark">질문하기</a>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // 1. 정렬 링크(기본순, 최신순, 조회순) 클릭 이벤트
    $(document).on("click", ".sort-link", function(e) {
        e.preventDefault();
        
        const sortType = $(this).data("sort"); // "" 또는 "latest" 또는 "count"
        const searchType = $("#searchType").val();
        const keyword = $('#keywordInput').val();
        const contextPath = "${path}";

        let url = contextPath + "/board/qna"
                + "?page=1"
                + "&perPageNum=${pageMaker.cri.perPageNum}"
                + "&searchType=" + searchType
                + "&keyword=" + encodeURIComponent(keyword)
                + "&sortType=" + sortType;

        location.href = url;
    });

    // 2. 검색 버튼 클릭 이벤트
    $(document).on("click", "#searchBtn", function(e) {
        e.preventDefault();
        
        const sortType = "${pageMaker.cri.sortType}"; // 현재 정렬 유지
        const keyword = $('#keywordInput').val();
        const searchType = $("#searchType").val();
        const contextPath = "${path}";

        let url = contextPath + "/board/qna"
                + "?page=1"
                + "&perPageNum=${pageMaker.cri.perPageNum}"
                + "&searchType=" + searchType
                + "&keyword=" + encodeURIComponent(keyword)
                + "&sortType=" + sortType;

        location.href = url;
    });

    // 3. 엔터키 지원
    $(document).on("keydown", "#keywordInput", function(e) {
        if (e.keyCode === 13) {
            $("#searchBtn").click();
        }
    });
}); // document.ready 종료
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>