<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 헤더 불러오기 --%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<link rel="stylesheet" href="${path}/resources/css/views/index.css">

<div class="main-content">
    <c:choose>
        <%-- 로그인 상태일 때 --%>
        <c:when test="${not empty sessionScope.loginUser}">
            <h2>
                <c:out value="${not empty loginUser.nickname ? loginUser.nickname : loginUser.name}" />님, 
                가격 추적 플랫폼에 오신 것을 환영합니다!
            </h2>
        </c:when>
        <%-- 비로그인 상태일 때 --%>
        <c:otherwise>
            <h2>가격 추적 플랫폼에 오신 것을 환영합니다!</h2>
        </c:otherwise>
    </c:choose>
    
    <p>(배너 / 최저가 알림 / 오늘의 급락 상품)</p>

    <form action="${path}/dashboard/search" method="get">
        <input type="text" name="query" class="search-bar" placeholder="관심 상품 URL 또는 상품명 검색" required>
        <input type="text" name="prodCode" class="search-bar-small" placeholder="상품번호(선택)">
        <br>
        <button type="submit" class="start-btn">가격 추적 시작하기 →</button>
    </form>
</div>

<%-- 푸터 불러오기 --%>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>