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
    </div>

    <%-- 상품 리스트 영역 --%>
    <div class="stock-list-container">
        <c:choose>
            <c:when test="${empty stockList}">
                <div style="text-align: center; padding: 50px; color: #999;">
                    조회된 데이터가 없습니다.
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="s" items="${stockList}">
                    <div class="stock-card" onclick="location.href='${path}/dashboard/detail?prodId=${s.prodId}'">
                        <div class="badge ${boardTitle eq '오늘의 급락 상품' ? 'bg-red' : 'bg-blue'}">
                            ${boardTitle eq '오늘의 급락 상품' ? '급락' : '갱신'}
                        </div>

                        <div class="prod-info">
                            <div class="prod-main-text">
                                ${s.name} — <span class="price-highlight">현재 최저가 ₩<fmt:formatNumber value="${s.price}" pattern="#,###" /></span>
                            </div>
                            <div class="prod-sub-text">
                                <fmt:formatDate value="${s.regDate}" pattern="yyyy.MM.dd HH:mm" /> | 조회수 123
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
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