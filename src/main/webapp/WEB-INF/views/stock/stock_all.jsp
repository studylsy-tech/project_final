<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%-- 통합된 스톡 전용 CSS --%>
<link rel="stylesheet" href="${path}/resources/css/stock/stock_common.css">

<%-- 현재 접속 경로 저장 --%>
<c:set var="currentUri" value="${requestScope['javax.servlet.forward.request_uri']}" />

<div class="board-wrapper">
    <h2>전체 상품</h2>

    <%-- 1. 통합 검색 영역: search-area 클래스 적용 --%>
    <div class="search-area">
        <form action="${pageContext.request.contextPath}/stock/all" method="get">
            <select name="searchType" id="searchType">
                <option value="title" ${scri.searchType eq 'title' ? 'selected' : ''}>제목</option>
                <option value="url" ${scri.searchType eq 'url' ? 'selected' : ''}>URL</option>
                <option value="content" ${scri.searchType eq 'content' ? 'selected' : ''}>내용</option>
            </select>
            <input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" placeholder="검색어 입력" />
            <button type="button" id="searchBtn">검색</button>
        </form>
    </div>

    <%-- 2. 상품 리스트 영역: stock-list-container 내부 카드 구조 통일 --%>
    <div class="stock-list-container">
        <c:choose>
            <c:when test="${empty stockList}">
                <div class="empty-msg">조회된 데이터가 없습니다.</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="s" items="${stockList}">
                    <%-- 상세 페이지 URL 분기 처리 --%>
                    <c:url var="detailUrl" value="${s.boardType eq 'HOT' ? '/hotdeal/detail' : '/dashboard/detail'}">
                        <c:param name="${s.boardType eq 'HOT' ? 'dealId' : 'prodId'}" value="${s.prodId}" />
                    </c:url>

                    <div class="stock-card" onclick="location.href='${detailUrl}'">
                        <%-- 이미지 영역: CSS 규격 적용 --%>
                        <div class="prod-img-wrapper">
                            <img src="${not empty s.imageUrl ? s.imageUrl : path.concat('/resources/images/no-image.png')}" 
                                 alt="${s.name}" 
                                 onerror="this.src='${path}/resources/images/no-image.png';">
                        </div>

                        <%-- 정보 영역: 계층 구조 정렬 --%>
                        <div class="prod-info-wrapper">
                            <div class="prod-title-row">
                                <c:set var="badgeClass" value="${s.boardType eq 'DROP' ? 'bg-red' : (s.boardType eq 'HOT' ? 'bg-orange' : 'bg-green')}" />
                                <c:set var="badgeText" value="${s.boardType eq 'DROP' ? '급락' : (s.boardType eq 'HOT' ? '핫딜' : '최저가')}" />
                                <span class="badge ${badgeClass}">${badgeText}</span>
                                
                                <span class="prod-main-text">
                                    ${s.name} &mdash; 
                                    <span class="price-highlight">&#8361;<fmt:formatNumber value="${s.price}" pattern="#,###" /></span>
                                </span>
                            </div>
                            <div class="prod-sub-text">
                                <fmt:formatDate value="${s.regDate}" pattern="yyyy.MM.dd HH:mm" /> | ${s.source}
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- 3. 페이징 처리 영역: paging-area 클래스로 통일 --%>
    <div class="paging-area">
        <c:if test="${pageMaker.prev}">
            <a href="${currentUri}${pageMaker.makeSearch(pageMaker.startPage - 1)}">[이전]</a>
        </c:if>

        <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            <a href="${currentUri}${pageMaker.makeSearch(idx)}">
                <c:choose>
                    <c:when test="${pageMaker.criteria.page == idx}">
                        <span class="current-page">${idx}</span>
                    </c:when>
                    <c:otherwise>
                        <span>${idx}</span>
                    </c:otherwise>
                </c:choose>
            </a>
        </c:forEach>

        <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
            <a href="${currentUri}${pageMaker.makeSearch(pageMaker.endPage + 1)}">[다음]</a>
        </c:if>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(function() {
        // 검색 실행 함수
        function executeSearch() {
            const uri = "${currentUri}";
            const keyword = $('#keywordInput').val();
            const searchType = $("#searchType").val();
            
            location.href = uri + "?page=1" 
                          + "&perPageNum=${pageMaker.criteria.perPageNum}"
                          + "&searchType=" + searchType
                          + "&keyword=" + encodeURIComponent(keyword);
        }

        // 검색 버튼 클릭 이벤트
        $('#searchBtn').on("click", function(event) {
            event.preventDefault();
            executeSearch();
        });

        // 엔터키 지원
        $('#keywordInput').on("keydown", function(e) {
            if(e.keyCode == 13) {
                e.preventDefault();
                executeSearch();
            }
        });
    });
</script>