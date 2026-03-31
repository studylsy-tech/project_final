<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%-- 절대 경로 대신 ${path}와 파일의 실제 물리 경로를 맞춥니다 --%>
<link rel="stylesheet" href="${path}/resources/css/stock/stock_list.css">
<div class="board-wrapper">
	<h2>${boardTitle}</h2>

	<div class="stock-list-container">
		<c:choose>
			<c:when test="${empty stockList}">
				<div style="text-align: center; padding: 50px; color: #999;">
					조회된 데이터가 없습니다.</div>
			</c:when>
			<c:otherwise>
				<c:forEach var="s" items="${stockList}">
					<div class="stock-card"
						onclick="location.href='${path}/dashboard/detail?prodId=${s.prodId}'">
						<div
							class="badge ${boardTitle eq '오늘의 급락 상품' ? 'bg-red' : 'bg-blue'}">
							${boardTitle eq '오늘의 급락 상품' ? '급락' : '갱신'}</div>

						<div class="prod-info">
							<div class="prod-main-text">
								${s.name} — <span class="price-highlight">현재 최저가 ₩<fmt:formatNumber
										value="${s.price}" pattern="#,###" /></span>
							</div>
							<div class="prod-sub-text">
								<fmt:formatDate value="${s.regDate}" pattern="yyyy.MM.dd HH:mm" />
								| 조회수 123
							</div>
						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<!-- 검색기능 -->
<div class="search-bar" style="text-align: center; margin-bottom: 20px;">
	<select id="searchType" name="searchType" style="padding: 5px;">
		<option value="n"
			<c:out value="${pageMaker.criteria.searchType == null ? 'selected' : ''}"/>>---</option>
		<option value="name"
			<c:out value="${pageMaker.criteria.searchType eq 'name' ? 'selected' : ''}"/>>상품명</option>
		<option value="drop"
			<c:out value="${pageMaker.criteria.searchType eq 'drop' ? 'selected' : ''}"/>>급락상품</option>
		<option value="low"
			<c:out value="${pageMaker.criteria.searchType eq 'low' ? 'selected' : ''}"/>>최저가</option>
	</select> <input type="text" id="keywordInput" name="keyword"
		value="${pageMaker.criteria.keyword}"
		style="padding: 5px; width: 200px;">
	<button id="searchBtn" style="padding: 5px 15px;">검색</button>
</div>

<!-- 페이징 -->
<div style="text-align: center;">
	<c:if test="${pageMaker.prev}">
		<a href="list${pageMaker.query(pageMaker.startPage - 1)}">[이전]</a>
	</c:if>

	<div style="text-align: center; margin-top: 30px; font-size: 16px;">
    <c:if test="${pageMaker.prev}">
        <a href="list${pageMaker.query(pageMaker.startPage - 1)}" style="text-decoration:none; color:#333;">[이전]</a>
    </c:if>

    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
    <a href="list${pageMaker.query(idx)}"> <c:choose>
            <c:when test="${pageMaker.criteria.page == idx}">
                <span style="color: red; font-weight: bold;">${idx}</span>
            </c:when>
            <c:otherwise>
                ${idx}
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
        $('#searchBtn').on("click", function(event) {
            // makeQuery(1) -> query(1) 로 변경
            self.location = "list"
                + '${pageMaker.query(1)}' 
                + "&searchType=" + $("select option:selected").val()
                + "&keyword=" + encodeURIComponent($('#keywordInput').val());
        });
    });
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>