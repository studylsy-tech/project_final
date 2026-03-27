<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%-- 절대 경로 대신 ${path}와 파일의 실제 물리 경로를 맞춥니다 --%>
<link rel="stylesheet" href="${path}/resources/css/stock/stock_list.css">
<div class="board-wrapper">
<h2>실시간 핫딜 자동분석</h2>

<div class="analysis-container">
    <div class="card">
        <h3>🔥 역대 최저가 경신 상품</h3>
        <table border="1">
            <tr>
                <th>상품명</th>
                <th>현재가</th>
                <th>출처</th>
                <th>링크</th>
            </tr>
            <c:forEach var="deal" items="${lowPriceList}">
                <tr>
                    <td>${deal.title}</td>
                    <td style="color:red; font-weight:bold;">${deal.currentPrice}원</td>
                    <td>${deal.mallName}</td>
                    <td><a href="${deal.originUrl}" target="_blank">이동</a></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>