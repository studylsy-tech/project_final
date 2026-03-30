<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 헤더 불러오기 --%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%-- 에러 전용 외부 CSS 연결 --%>
<link rel="stylesheet" href="${path}/resources/css/views/error/error.css">

<div class="main-content error-page">
    <div class="error-icon">⚠️</div>
    <h1 class="error-code">500</h1>
    <h2 class="error-title">서버 오류가 발생했습니다</h2>
    <p class="error-message">
        시스템 이용에 불편을 드려 죄송합니다.<br>
        일시적인 오류일 수 있으니 잠시 후 다시 시도해 주세요.<br>
        문제가 지속될 경우 관리자에게 문의 바랍니다.
    </p>
    <div class="btn-group">
        <a href="${path}/index.jsp" class="start-btn" style="text-decoration: none;">메인으로 돌아가기</a>
    </div>
</div>

<%-- 푸터 불러오기 --%>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>