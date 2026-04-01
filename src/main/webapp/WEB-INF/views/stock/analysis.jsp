<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<link rel="stylesheet" href="${path}/resources/css/stock/stock_list.css">
<div class="board-wrapper">
    <h2>실시간 핫딜 자동분석</h2>

    <div class="analysis-container">
        <div class="card">
            <h3>🔥 역대 최저가 경신 상품</h3>
            <table border="1">
    <thead>
        <tr>
            <th>이미지</th> <th>상품명</th>
            <th>현재가</th>
            <th>출처</th>
            <th>링크</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="hotdeal" items="${hotDealList}">
    <tr>
        <%-- 이미지 출력 부분 추가 --%>
        <td style="text-align:center; width: 100px;">
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
        
        <td style="font-size:15px; font-weight: 600; color:#2c3e50;"><c:out value="${hotdeal.title}" /></td>
        <td style="color:red; font-weight:bold;">
            <fmt:formatNumber value="${hotdeal.currentPrice}" pattern="#,###" />원
        </td>
        <td style="width: 80px; color: #1a2a44; "><c:out value="${hotdeal.communityName}" /></td>
        <td>
            <a href="${hotdeal.originUrl}" target="_blank" class="start-btn" 
               style="padding: 5px 10px; font-size: 12px; text-decoration: none; white-space:nowrap;">원문보기</a>
        </td>
    </tr>
</c:forEach>
    </tbody>
<%-- analysis.jsp 하단 --%>
</table>
<div class="search-bar" style="text-align: center; margin-bottom: 20px;">
    <select id="searchType" name="searchType" style="padding: 5px;">
        <option value="title">상품명</option>
    </select>
    <input type="text" id="keywordInput" name="keyword" value="" style="padding: 5px; width: 200px;">
    <button id="searchBtn" style="padding: 5px 15px;">검색</button>
</div>
<%-- analysis.jsp 페이징 번호 부분 --%>
<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
    <a href="analysis${pageMaker.query(idx)}">${idx}</a> 
</c:forEach>
<%-- analysis.jsp 스크립트 부분 --%>
<script>
    $(function() {
        $('#searchBtn').on("click", function(event) {
            self.location = "analysis"
                + '${pageMaker.query(1)}' // makeQuery 대신 query 사용
                + "&searchType=" + $("select option:selected").val()
                + "&keyword=" + encodeURIComponent($('#keywordInput').val());
        });
    });
</script>
<div class="pagination-area" style="text-align: center; margin-top: 20px;">
    <ul class="pagination" style="display: inline-flex; list-style: none; padding: 0;">
        <%-- 이전 버튼 --%>
        <c:if test="${pageMaker.prev}">
            <li style="margin: 0 5px;">
                <a href="${path}/stock/analysis${pageMaker.query(pageMaker.startPage - 1)}">이전</a>
            </li>
        </c:if>

        

        <%-- 다음 버튼 --%>
        <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
            <li style="margin: 0 5px;">
                <a href="${path}/stock/analysis${pageMaker.query(pageMaker.endPage + 1)}">다음</a>
            </li>
        </c:if>
    </ul>
</div>


        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>