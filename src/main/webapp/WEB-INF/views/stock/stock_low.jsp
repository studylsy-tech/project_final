<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%-- 스타일시트 연결 --%>
<link rel="stylesheet" href="${path}/resources/css/stock/stock_drop.css">

<%-- 최저가 페이지 경로 고정 --%>
<c:set var="targetUri" value="${path}/stock/low" />

<div class="board-wrapper">
    <h2>${boardTitle}</h2>

    <%-- 1. 통합 검색 영역 (제목, URL, 내용 기준으로 수정) --%>
    <div style="margin-bottom: 20px; text-align: right;">
        <form action="${targetUri}" method="get" id="searchForm">
            <select name="searchType" id="searchType" style="padding: 5px;">
                <option value="title" ${pageMaker.criteria.searchType eq 'title' ? 'selected' : ''}>제목</option>
                <option value="url" ${pageMaker.criteria.searchType eq 'url' ? 'selected' : ''}>URL</option>
                <option value="content" ${pageMaker.criteria.searchType eq 'content' ? 'selected' : ''}>내용</option>
            </select>
            <input type="text" name="keyword" id="keywordInput" value="${pageMaker.criteria.keyword}" style="padding: 5px; width: 200px;" placeholder="검색어">
            <button type="button" id="searchBtn" style="padding: 5px 15px;">검색</button>
        </form>
    </div>

    <%-- 2. 상품 리스트 영역 --%>
    <%-- 2. 상품 리스트 영역 --%>
<div class="stock-list-container">
    <c:choose>
        <c:when test="${empty stockList}">
            <div style="text-align: center; padding: 50px; color: #999;">조회된 최저가 데이터가 없습니다.</div>
        </c:when>
        <c:otherwise>
            <c:forEach var="s" items="${stockList}">
                <c:set var="detailUrl" value="${path}/dashboard/detail?prodId=${s.prodId}" />
                
                <div class="stock-card" onclick="location.href='${detailUrl}'">
                    <%-- 이미지 영역 --%>
                    <div class="prod-img-wrapper">
                        <c:choose>
                            <c:when test="${not empty s.imageUrl}">
                                <img src="${s.imageUrl}" alt="${s.name}" class="prod-img"
                                     onerror="this.src='${path}/resources/images/no-image.png'">
                            </c:when>
                            <c:otherwise>
                                <img src="${path}/resources/images/no-image.png" alt="이미지없음" class="prod-img">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <%-- 정보 영역 --%>
                    <div class="prod-info-wrapper">
                        <div class="prod-title-row">
                            <span class="badge bg-blue">최저가</span>
                            <span class="prod-main-text">${s.name}</span>
                        </div>
                        <div class="prod-sub-text">
                            현재가: <span class="price-highlight"><fmt:formatNumber value="${s.price}" pattern="#,###"/>원</span>
                        </div>
                    </div>
                </div> <%-- .stock-card END --%>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

    <%-- 3. 페이징 처리 영역 --%>
    <div style="text-align: center; margin: 30px 0; font-size: 16px;">
        <c:if test="${pageMaker.prev}">
            <a href="${targetUri}${pageMaker.makeSearch(pageMaker.startPage - 1)}" style="text-decoration:none; color:#333;">[이전]</a>
        </c:if>

        <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            <a href="${targetUri}${pageMaker.makeSearch(idx)}" style="text-decoration:none; margin: 0 5px;">
                <c:choose>
                    <c:when test="${pageMaker.criteria.page == idx}">
                        <span style="color: red; font-weight: bold; border-bottom: 2px solid red; padding-bottom: 2px;">${idx}</span>
                    </c:when>
                    <c:otherwise>
                        <span style="color: #666;">${idx}</span>
                    </c:otherwise>
                </c:choose>
            </a>
        </c:forEach>

        <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
            <a href="${targetUri}${pageMaker.makeSearch(pageMaker.endPage + 1)}" style="text-decoration:none; color:#333;">[다음]</a>
        </c:if>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(function() {
        $('#searchBtn').on("click", function(event) {
            event.preventDefault();
            // 검색 시 항상 1페이지로 리셋
            var url = "${targetUri}" + "?page=1&perPageNum=${pageMaker.criteria.perPageNum}"
                    + "&searchType=" + $("#searchType").val()
                    + "&keyword=" + encodeURIComponent($('#keywordInput').val());
            location.href = url;
        });

        // 엔터키 검색 지원
        $('#keywordInput').on("keydown", function(e) {
            if(e.keyCode == 13) {
                e.preventDefault();
                $('#searchBtn').click();
            }
        });
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>