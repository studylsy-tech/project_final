<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
 
<%@ include file="/WEB-INF/views/common/header.jsp"%>
 
<link rel="stylesheet" href="${path}/resources/css/stock/stock_drop.css">
 
<c:set var="targetUri" value="${path}/stock/drop" />
 
<div class="board-wrapper">
 
    <h2>
        <img class="title-icon"
             src="${path}/resources/images/icon_drop.png"
             onerror="this.style.display='none'" alt="">
        ${boardTitle}
    </h2>
 
    <%-- 1. 검색 영역 --%>
    <div class="search-area">
        <form action="${targetUri}" method="get" id="searchForm">
            <select name="searchType">
                <option value="name" ${pageMaker.criteria.searchType eq 'name' ? 'selected' : ''}>상품명</option>
                <option value="drop" ${pageMaker.criteria.searchType eq 'drop' ? 'selected' : ''} selected>급락상품</option>
                <option value="low"  ${pageMaker.criteria.searchType eq 'low'  ? 'selected' : ''}>최저가</option>
            </select>
            <input type="text" name="keyword" id="keywordInput"
                   value="${pageMaker.criteria.keyword}" placeholder="검색어">
            <button type="submit" id="searchBtn">검색</button>
        </form>
    </div>
 
    <%-- 2. 상품 리스트 영역 --%>
    <div class="stock-list-container">
        <c:choose>
            <c:when test="${empty stockList}">
                <div class="empty-msg">조회된 급락 데이터가 없습니다.</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="s" items="${stockList}">
                    <c:set var="detailUrl" value="${path}/dashboard/detail?prodId=${s.prodId}" />
 
                    <div class="stock-card" onclick="location.href='${detailUrl}'">
 
                        <div class="prod-img-wrapper">
                            <c:choose>
                                <c:when test="${not empty s.imageUrl}">
                                    <img src="${s.imageUrl}" alt="${s.name}"
                                         onerror="this.src='${path}/resources/images/no-image.png'">
                                </c:when>
                                <c:otherwise>
                                    <img src="${path}/resources/images/no-image.png" alt="이미지없음">
                                </c:otherwise>
                            </c:choose>
                        </div>
 
                        <div class="prod-info-wrapper">
                            <div class="prod-title-row">
                                <span class="badge bg-red">급락</span>
                                <span class="prod-main-text">
                                    ${s.name} &mdash;
                                    <span class="price-highlight">&#8361;<fmt:formatNumber value="${s.price}" pattern="#,###" /></span>
                                </span>
                            </div>
                            <div class="prod-sub-text">
                                <fmt:formatDate value="${s.regDate}" pattern="yyyy.MM.dd HH:mm" />
                                <c:if test="${not empty s.source}"> | ${s.source}</c:if>
                            </div>
                        </div>
 
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
 
    <%-- 3. 페이징 --%>
    <div class="paging-area">
        <c:if test="${pageMaker.prev}">
            <a href="${targetUri}${pageMaker.makeSearch(pageMaker.startPage - 1)}">[이전]</a>
        </c:if>
 
        <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            <a href="${targetUri}${pageMaker.makeSearch(idx)}">
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
            <a href="${targetUri}${pageMaker.makeSearch(pageMaker.endPage + 1)}">[다음]</a>
        </c:if>
    </div>
 
</div>
 
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(function() {
        $('#searchBtn').on("click", function(event) {
            event.preventDefault();
            var url = "${targetUri}" + "?page=1&perPageNum=${pageMaker.criteria.perPageNum}"
                    + "&searchType=" + $("select[name='searchType']").val()
                    + "&keyword=" + encodeURIComponent($('#keywordInput').val());
            location.href = url;
        });
    });
</script>
 
<%@ include file="/WEB-INF/views/common/footer.jsp"%>