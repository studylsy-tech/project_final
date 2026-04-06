<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%-- 스타일시트 연결 --%>
<link rel="stylesheet" href="${path}/resources/css/stock/stock_list.css">

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
    <div class="stock-list-container">
        <c:choose>
            <c:when test="${empty stockList}">
                <div style="text-align: center; padding: 50px; color: #999;">조회된 최저가 데이터가 없습니다.</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="s" items="${stockList}">
                    <%-- 상세 페이지 경로 설정 --%>
                    <c:set var="detailUrl" value="${path}/dashboard/detail?prodId=${s.prodId}" />

                    <div class="stock-card" onclick="location.href='${detailUrl}'" 
                         style="display: flex; align-items: center; padding: 15px; border-bottom: 1px solid #eee; cursor: pointer;">
                        
                        <div class="prod-img-wrapper" style="margin-right: 20px;">
                            <img src="${not empty s.imageUrl ? s.imageUrl : path.concat('/resources/images/no-image.png')}" 
                                 alt="${s.name}" class="prod-img"
                                 style="width:100px; height:100px; object-fit:cover; border-radius: 8px;"
                                 onerror="this.src='${path}/resources/images/no-image.png';">
                        </div>

                        <div class="prod-info-wrapper">
                            <%-- 최저가 뱃지 고정 --%>
                            <div class="badge bg-blue" style="display:inline-block; padding: 3px 8px; background-color: #3498db; color: white; border-radius: 4px; font-size: 0.8em;">최저가</div>

                            <div class="prod-info" style="margin-top: 8px;">
                                <div class="prod-main-text" style="font-weight: bold; font-size: 1.1em;">
                                    ${s.name} — <span class="price-highlight" style="color: #e74c3c;">₩<fmt:formatNumber value="${s.price}" pattern="#,###" /></span>
                                </div>
                                <div class="prod-sub-text" style="color: #888; font-size: 0.9em; margin-top: 4px;">
                                    <fmt:formatDate value="${s.regDate}" pattern="yyyy.MM.dd HH:mm" /> | ${s.source}
                                </div>
                            </div>
                        </div>
                    </div>
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