<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 헤더 포함: 여기에 JSTL 선언과 path 설정이 들어있어야 합니다 --%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/index.css">

<div class="main-content">
    <h2>검색 결과 목록 (최대 10개)</h2>
    
    <c:choose>
        <c:when test="${empty searchResults}">
            <p>검색된 결과가 없습니다.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="item" items="${searchResults}">
                <div class="product-item" style="border: 1px solid #ddd; padding: 15px; margin-bottom: 10px; border-radius: 8px; text-align: left;">
                    <span class="label" style="background: #e74c3c; color: white; padding: 2px 5px; border-radius: 3px; font-size: 12px;">급락/갱신</span>
                    <div class="info" style="margin: 10px 0;">
                        <strong style="font-size: 16px;">${item.name}</strong>
                        <p style="color: #4a90e2; font-weight: bold;">현재 최저가: ${item.price}원</p>
                    </div>
                    
                    <form action="${path}/dashboard/addForm" method="post">
                        <input type="hidden" name="prodCode" value="${item.prodCode}">
                        <input type="hidden" name="name" value="${item.name}">
                        <input type="hidden" name="price" value="${item.price}">
                        <button type="submit" class="start-btn" style="padding: 8px 20px; font-size: 14px;">이 상품 추적하기</button>
                    </form>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>