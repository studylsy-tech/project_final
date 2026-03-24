<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 공통 헤더 포함 --%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- 해당 페이지 전용 CSS 연결 --%>
<link rel="stylesheet" href="${path}/resources/css/views/footer/terms.css">

<div class="terms-container">
    <div class="terms-title-area">
        <h1>서비스 이용약관</h1>
    </div>
    
    <div class="terms-box">
        <h2>제 1 조 (목적)</h2>
        <p>본 약관은 'Price Tracking Platform'팀이 제공하는 서비스 이용에 관한 사항을 규정합니다.</p>
        
        <%-- 추가 조항들 배치 가능 --%>
        
        <p class="terms-end-text">- 이상 -</p>
    </div>

    <div class="footer-btn">
        <a href="${path}/" class="btn-home">확인 및 메인으로</a>
    </div>
</div>

<%-- 공통 푸터 포함 --%>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />