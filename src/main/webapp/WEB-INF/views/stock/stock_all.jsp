<!-- webapp/WEB-INF/views/stock/stock_all.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%-- 스타일시트 연결 --%>
<link rel="stylesheet" href="${path}/resources/css/stock/stock_list.css">

<div class="board-wrapper">
    <h2>${boardTitle}</h2>

    <%-- 상단 통합 검색 영역 (필요 시 사용) --%>
    <div style="margin-bottom: 20px; text-align: right;">
        <form action="${path}/board/list" method="get">
            <select name="searchType" style="padding: 5px;">
                <option value="name" ${pageMaker.criteria.searchType eq 'name' ? 'selected' : ''}>상품명</option>
                <option value="drop" ${pageMaker.criteria.searchType eq 'drop' ? 'selected' : ''}>급락상품</option>
                <option value="low" ${pageMaker.criteria.searchType eq 'low' ? 'selected' : ''}>최저가</option>
            </select>
            <input type="text" name="keyword" value="${pageMaker.criteria.keyword}" style="padding: 5px; width: 200px;">
            <button type="submit" style="padding: 5px 15px;">검색</button>
        </form>
    </div><%-- 상품 리스트 영역 --%>
<div class="stock-list-container">
    <c:forEach var="s" items="${stockList}">
        <div class="stock-card" onclick="location.href='${path}/dashboard/detail?prodId=${s.prodId}'" 
             style="display: flex; align-items: center; padding: 15px; border-bottom: 1px solid #eee; cursor: pointer;">
            
            <%-- 이미지 영역: 작성하신 로직 그대로 유지 --%>
            <div class="prod-img-wrapper">
    <c:choose>
        <%-- 이미지 경로가 있는 경우 --%>
        <c:when test="${not empty s.imageUrl}">
            <img src="${s.imageUrl}" 
                 alt="${s.name}" 
                 class="prod-img"
                 onerror="this.onerror=null; this.src='${path}/resources/images/no-image.png';">
        </c:when>
        
        <%-- 이미지가 없는 경우 --%>
        <c:otherwise>
            <img src="${path}/resources/images/no-image.png" 
                 alt="No Image"
                 class="prod-img">
        </c:otherwise>
    </c:choose>
</div>

            <div class="prod-info-wrapper">
                <%-- [추가] 배지 영역: 전체 탭이므로 구분이 필요함 --%>
                <c:set var="badgeClass" value="bg-blue" />
                <c:set var="badgeText" value="최저가" />
                <c:choose>
                    <c:when test="${s.boardType eq 'DROP'}">
                        <c:set var="badgeClass" value="bg-red" />
                        <c:set var="badgeText" value="급락" />
                    </c:when>
                    <c:when test="${s.boardType eq 'HOT'}">
                        <c:set var="badgeClass" value="bg-orange" />
                        <c:set var="badgeText" value="핫딜" />
                    </c:when>
                </c:choose>
                <div class="badge ${badgeClass}">${badgeText}</div>

                <div class="prod-info" style="margin-top: 8px;">
                    <div class="prod-main-text" style="font-weight: bold; font-size: 1.1em;">
                        ${s.name} — <span class="price-highlight" style="color: #e74c3c;">₩<fmt:formatNumber value="${s.price}" pattern="#,###" /></span>
                    </div>
                    <%-- 등록일이나 출처 정보도 추가하면 더 좋습니다 --%>
                    <div class="prod-sub-text" style="color: #888; font-size: 0.9em; margin-top: 4px;">
                        <fmt:formatDate value="${s.regDate}" pattern="yyyy.MM.dd HH:mm" /> | ${s.source}
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<%-- 페이징 처리 영역 --%>
<div style="text-align: center; margin: 30px 0; font-size: 16px;">
    <c:if test="${pageMaker.prev}">
        <a href="list${pageMaker.query(pageMaker.startPage - 1)}" style="text-decoration:none; color:#333;">[이전]</a>
    </c:if>

    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
        <a href="list${pageMaker.query(idx)}" style="text-decoration:none; margin: 0 5px;">
            <c:choose>
                <c:when test="${pageMaker.criteria.page == idx}">
                    <span style="color: red; font-weight: bold;">${idx}</span>
                </c:when>
                <c:otherwise>
                    <span style="color: #666;">${idx}</span>
                </c:otherwise>
            </c:choose>
        </a>
    </c:forEach>

    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
        <a href="list${pageMaker.query(pageMaker.endPage + 1)}" style="text-decoration:none; color:#333;">[다음]</a>
    </c:if>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(function() {
        // 하단 검색 버튼 클릭 이벤트 (기존 유지)
        $('#searchBtn').on("click", function(event) {
            self.location = "list"
                + '${pageMaker.query(1)}' 
                + "&searchType=" + $("#searchType option:selected").val()
                + "&keyword=" + encodeURIComponent($('#keywordInput').val());
        });
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>