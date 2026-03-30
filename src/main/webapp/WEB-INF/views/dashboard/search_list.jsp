<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 헤더 포함 --%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%-- 외부 CSS 연결 (팀원이 작업할 파일) --%>
<link rel="stylesheet" href="${path}/resources/css/views/dashboard/search_list.css">

<div class="main-content">
    <h2 class="search-title">검색 결과 목록</h2>
    
    <c:choose>
        <%-- 1. 검색 결과가 없을 때 --%>
        <c:when test="${empty searchResults}">
            <div class="no-result-container">
                <div class="no-result-icon">
                    <img src="${path}/resources/images/common/no-search.png" alt="검색 결과 없음" class="no-result-img" onerror="this.src='https://via.placeholder.com/120?text=No+Image'">
                </div>
                <h3 class="no-result-title">찾으시는 상품이 없습니다.</h3>
                <p class="no-result-text">
                    입력하신 단어의 철자가 정확한지 확인해 보세요.<br>
                    또는 더 일반적인 키워드로 검색해 보시는 것은 어떨까요?
                </p>
                <div class="no-result-actions">
                    <a href="${path}/index.jsp" class="start-btn">메인으로 돌아가기</a>
                </div>
            </div>
        </c:when>

        <%-- 2. 검색 결과가 있을 때 --%>
        <c:otherwise>
            <div class="product-list">
                <c:forEach var="item" items="${searchResults}">
                    <div class="product-item">
                        <span class="label">최저가 정보</span>
                        <div class="info">
                            <strong class="prod-name">${item.name}</strong>
                            <p class="prod-price">현재 최저가: ${item.price}원</p>
                        </div>
                        
                        <form action="${path}/dashboard/addForm" method="post">
                            <input type="hidden" name="prodCode" value="${item.prodCode}">
                            <input type="hidden" name="name" value="${item.name}">
                            <input type="hidden" name="price" value="${item.price}">
                            <button type="submit" class="start-btn tracking-btn">이 상품 추적하기</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>