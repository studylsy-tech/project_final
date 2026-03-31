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
        <c:forEach var="deal" items="${hotDealList}">
            <tr>
                <%-- 이미지 출력 부분 추가 --%>
                <td style="text-align:center; width: 100px;">
                    <c:choose>
                        <c:when test="${not empty deal.imageUrl}">
                            <img src="${deal.imageUrl}" alt="상품이미지" 
                                 style="width: 80px; height: 80px; object-fit: cover; border-radius: 4px;"
                                 onerror="this.src='${path}/resources/images/no-image.png'">
                        </c:when>
                        <c:otherwise>
                            <img src="${path}/resources/images/no-image.png" 
                                 style="width: 80px; height: 80px;">
                        </c:otherwise>
                    </c:choose>
                </td>
                
                <td style="font-size:15px; font-weight: 600; color:#2c3e50;"><c:out value="${deal.title}" /></td>
                <td style="color:red; font-weight:bold;">
                    <fmt:formatNumber value="${deal.currentPrice}" pattern="#,###" />원
                </td>
                <td style="width: 80px; color: #1a2a44; "><c:out value="${deal.communityName}" /></td>
                <td>
                    <a href="${deal.originUrl}" target="_blank" class="start-btn" 
                       style="padding: 5px 10px; font-size: 12px; text-decoration: none; white-space:nowrap;">원문보기</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>