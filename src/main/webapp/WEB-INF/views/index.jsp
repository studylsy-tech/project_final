<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 헤더 불러오기 --%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%-- 1. index 전용 CSS 연결 (기존 <style> 태그 대체) --%>
<link rel="stylesheet" href="${path}/resources/css/views/index.css">

<div class="main-content">
    <h2>가격 추적 플랫폼에 오신 것을 환영합니다!</h2>
    <p>(배너 / 최저가 알림 / 오늘의 급락 상품)</p>

    <%-- 2. 상품번호(prodCode) 입력란이 포함된 폼 --%>
    <form action="${path}/dashboard/search" method="get">
        <input type="text" name="query" class="search-bar" placeholder="관심 상품 URL 또는 상품명 검색" required>
        <input type="text" name="prodCode" class="search-bar-small" placeholder="상품번호(선택)">
        <br>
        <button type="submit" class="start-btn">가격 추적 시작하기 →</button>
    </form>
</div>

<%-- 푸터 불러오기 --%>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>