<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 헤더 불러오기 --%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%-- 에러 전용 외부 CSS 연결 --%>
<link rel="stylesheet" href="${path}/resources/css/views/error/error.css">

<div class="main-content error-page">
    <div class="error-icon">🔍</div>
    <h1 class="error-code">404</h1>
    <h2 class="error-title">페이지를 찾을 수 없습니다</h2>
    <p class="error-message">
        입력하신 주소가 잘못되었거나, 페이지가 삭제되어 찾을 수 없습니다.<br>
        입력하신 주소를 다시 한번 확인해 주세요.
    </p>
    <div class="btn-group">
        <a href="javascript:history.go(-1)" class="start-btn secondary" style="text-decoration: none; margin-right: 10px;">이전으로</a>
<a href="${path}/" class="start-btn" style="text-decoration: none;">메인으로 돌아가기</a>    </div>
</div>

<%-- 푸터 불러오기 --%>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>