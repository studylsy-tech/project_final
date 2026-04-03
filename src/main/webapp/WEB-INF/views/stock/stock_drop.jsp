<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${path}/resources/css/stock/stock_drop.css">

<%-- 고정 경로 설정 (중요: ?? 방지 및 경로 고정) --%>
<c:set var="targetUri" value="${path}/stock/drop" />

<div class="board-wrapper">
    <h2>${boardTitle}</h2>

    <%-- 1. 검색 영역 (고정 경로로 전송) --%>
    <div style="margin-bottom: 20px; text-align: right;">
        <form action="${targetUri}" method="get" id="searchForm">
            <select name="searchType" style="padding: 5px;">
                <option value="name" ${pageMaker.criteria.searchType eq 'name' ? 'selected' : ''}>상품명</option>
                <option value="drop" ${pageMaker.criteria.searchType eq 'drop' ? 'selected' : ''} selected>급락상품</option>
                <option value="low" ${pageMaker.criteria.searchType eq 'low' ? 'selected' : ''}>최저가</option>
            </select>
            <input type="text" name="keyword" id="keywordInput" value="${pageMaker.criteria.keyword}" style="padding: 5px; width: 200px;">
            <button type="submit" id="searchBtn" style="padding: 5px 15px;">검색</button>
        </form>
    </div>

    <%-- 2. 상품 리스트 영역 --%>
    <div class="stock-list-container">
        <c:choose>
            <c:when test="${empty stockList}">
                <div style="text-align: center; padding: 50px; color: #999;">조회된 급락 데이터가 없습니다.</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="s" items="${stockList}">
                    <%-- 급락 페이지는 기본적으로 dashboard 상세로 이동 --%>
                    <c:set var="detailUrl" value="${path}/dashboard/detail?prodId=${s.prodId}" />

                    <div class="stock-card" onclick="location.href='${detailUrl}'" 
                         style="display: flex; align-items: center; padding: 15px; border-bottom: 1px solid #eee; cursor: pointer;">
                        
                        <div class="prod-img-wrapper" style="margin-right: 20px;">
                            <img src="${not empty s.imageUrl ? s.imageUrl : path.concat('/resources/images/no-image.png')}" 
                                 style="width:100px; height:100px; object-fit:cover; border-radius: 8px;"
                                 onerror="this.src='${path}/resources/images/no-image.png';">
                        </div>

                        <div class="prod-info-wrapper">
                            <div class="badge bg-red">급락</div>
                            <div class="prod-info" style="margin-top: 8px;">
                                <div class="prod-main-text" style="font-weight: bold; font-size: 1.1em;">
                                    ${s.name} — <span style="color: #e74c3c;">₩<fmt:formatNumber value="${s.price}" pattern="#,###" /></span>
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

    <%-- 3. 페이징 영역 (? 중복 제거) --%>
    <div style="text-align: center; margin: 30px 0; font-size: 16px;">
        <c:if test="${pageMaker.prev}">
            <a href="${targetUri}${pageMaker.makeSearch(pageMaker.startPage - 1)}" style="text-decoration:none; color:#333;">[이전]</a>
        </c:if>

        <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            <a href="${targetUri}${pageMaker.makeSearch(idx)}" style="text-decoration:none; margin: 0 5px;">
                <c:choose>
                    <c:when test="${pageMaker.criteria.page == idx}">
                        <span style="color: red; font-weight: bold; border-bottom: 2px solid red;">${idx}</span>
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
            var url = "${targetUri}" + "?page=1&perPageNum=${pageMaker.criteria.perPageNum}"
                    + "&searchType=" + $("select[name='searchType']").val()
                    + "&keyword=" + encodeURIComponent($('#keywordInput').val());
            location.href = url;
        });
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>