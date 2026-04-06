<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${path}/resources/css/stock/stock_list.css">
<div class="board-wrapper">
	<h2>실시간 핫딜 자동분석</h2>

	<%-- 1. 검색 영역 (제목, URL, 내용 기준으로 수정) --%>
	<div style="margin-bottom: 20px; text-align: right;">
	    <select id="searchType" style="padding: 5px;">
	        <option value="title" ${scri.searchType eq 'title' ? 'selected' : ''}>제목</option>
	        <option value="url" ${scri.searchType eq 'url' ? 'selected' : ''}>URL</option>
	        <option value="content" ${scri.searchType eq 'content' ? 'selected' : ''}>내용</option>
	    </select>
	    <input type="text" id="keywordInput" 
	           value="${scri.keyword}" 
	           style="padding: 5px; width: 200px;" 
	           placeholder="검색어를 입력하세요">
	    <button type="button" id="searchBtn" style="padding: 5px 15px;">검색</button>
	</div>

	<div class="analysis-container">
		<div class="card">
			<h3>🔥 역대 최저가 경신 상품</h3>
			<table border="1">
				<thead>
					<tr>
						<th>이미지</th>
						<th>상품명</th>
						<th>현재가</th>
						<th>출처</th>
						<th>링크</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="hotdeal" items="${hotDealList}">
						<tr>
							<td style="text-align: center; width: 100px;">
								<c:choose>
									<c:when test="${not empty hotdeal.imageUrl}">
										<img src="${hotdeal.imageUrl}" alt="상품이미지"
											style="width: 80px; height: 80px; object-fit: cover; border-radius: 4px;"
											onerror="this.src='${path}/resources/images/no-image.png'">
									</c:when>
									<c:otherwise>
										<img src="${path}/resources/images/no-image.png"
											style="width: 80px; height: 80px;">
									</c:otherwise>
								</c:choose>
							</td>
							<td style="font-size: 15px; font-weight: 600; color: #2c3e50;">
								<c:out value="${hotdeal.title}" />
							</td>
							<td style="color: red; font-weight: bold; min-width:90px; white-space:nowrap;">
								<fmt:formatNumber value="${hotdeal.currentPrice}" pattern="#,###" />원
							</td>
							<td style="width: 80px; color: #1a2a44;">
								<c:out value="${hotdeal.communityName}" />
							</td>
							<td>
								<a href="${hotdeal.originUrl}" target="_blank" class="start-btn"
								   style="padding: 5px 10px; font-size: 12px; text-decoration: none; white-space: nowrap;">원문보기</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<%-- 페이징 번호 부분 --%>
			<div class="pagination-area" style="text-align: center; margin-top: 20px;">
				<ul class="pagination" style="display: inline-flex; list-style: none; padding: 0;">
					<c:if test="${pageMaker.prev}">
						<li style="margin: 0 5px;">
							<a href="${path}/stock/analysis${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a>
						</li>
					</c:if>

					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<li style="margin: 0 5px;">
							<a href="${path}/stock/analysis${pageMaker.makeSearch(idx)}"
							   style="text-decoration:none; ${pageMaker.criteria.page == idx ? 'color:red; font-weight:bold;' : 'color:#666;'}">
								${idx}
							</a>
						</li>
					</c:forEach>

					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<li style="margin: 0 5px;">
							<a href="${path}/stock/analysis${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a>
						</li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>

<script>
$(function() {
    // 검색 버튼 클릭 시
    $('#searchBtn').on("click", function(event) {
        var keyword = $('#keywordInput').val().trim();
        var searchType = $("#searchType option:selected").val();

        // StockController의 /analysis 경로를 사용하여 핫딜 분석 모드를 유지합니다.
        var url = "${path}/stock/analysis"
                + "?page=1"
                + "&perPageNum=${pageMaker.criteria.perPageNum}"
                + "&searchType=" + searchType
                + "&keyword=" + encodeURIComponent(keyword);
        
        self.location = url;
    });

    // 엔터키 입력 시 검색 실행
    $('#keywordInput').on("keypress", function(event) {
        if (event.keyCode === 13) {
            event.preventDefault();
            $('#searchBtn').click();
        }
    });
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>