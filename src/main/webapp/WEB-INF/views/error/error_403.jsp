<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 헤더 불러오기 --%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%-- 에러 전용 외부 CSS 연결 --%>
<link rel="stylesheet" href="${path}/resources/css/views/error/error.css">

<div class="main-content error-page">
    <div class="error-icon">🚫</div>
    <h1 class="error-code">403</h1>
    <h2 class="error-title">접근 권한이 없습니다</h2>
    <p class="error-message">
        요청하신 페이지에 접근할 수 있는 권한이 없습니다.<br>
        관리자에게 문의하시거나 메인 페이지로 이동해 주세요.
    </p>
    <div class="btn-group">
<a href="${path}/" class="start-btn" style="text-decoration: none;">메인으로 돌아가기</a>    </div>
</div>

<%-- 푸터 불러오기 --%>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>