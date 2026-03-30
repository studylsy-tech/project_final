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
                        <th>상품명</th>
                        <th>현재가</th>
                        <th>출처</th>
                        <th>링크</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="deal" items="${lowPriceList}">
                        <tr>
                            <%-- ProductDTO의 필드명에 맞춰 title -> name 등으로 수정 --%>
                            <td><c:out value="${deal.name}" /></td>
                            <td style="color:red; font-weight:bold;">
                                <fmt:formatNumber value="${deal.price}" pattern="#,###" />원
                            </td>
                            <td><c:out value="${deal.prodCode}" /></td>
                            <td><a href="${path}/dashboard/search?query=${deal.name}" class="start-btn" style="padding: 5px 10px; font-size: 12px; text-decoration: none;">상세보기</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>