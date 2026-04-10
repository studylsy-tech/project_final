<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 공통 헤더 포함 --%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%-- 로그인 전용 CSS 연결 --%>
<link rel="stylesheet" href="${path}/resources/css/views/member/login.css">

<div class="login-wrapper">
    <div class="login-box">
        <h2>로그인</h2>

        <c:if test="${not empty loginError}">
            <p class="error-msg">${loginError}</p>
        </c:if>

        <form action="${path}/member/login" method="post">
            <div class="form-group">
                <label for="phone">휴대폰 번호</label>
                <input type="text" id="phone" name="phone" placeholder="휴대폰 번호를 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="pw">비밀번호</label>
                <input type="password" id="pw" name="pw" placeholder="비밀번호를 입력하세요" required>
            </div>
            <div class="remember-me-container">
			    <input type="checkbox" name="rememberMe" id="rememberMe">
			    <label for="rememberMe">로그인 상태 유지</label>
			</div>
            <button type="submit" class="login-btn">로그인</button>
            <div class="social-login-container" style="margin-top: 15px; text-align: center;">
			    <a href="https://kauth.kakao.com/oauth/authorize?client_id=3e0fb4323a817291be8ec169ce046597&redirect_uri=http://localhost:8080/fin_project/member/kakaoLogin&response_type=code">카카오 로그인</a>
			</div>
        </form>

        <div class="login-links">
        	<a href="${path}/member/find_pw">비밀번호 찾기</a>
            <a href="${path}/member/join">회원가입</a> |
            <a href="${path}/">홈으로</a>
        </div>
    </div>
</div>

<%-- 공통 푸터 포함 --%>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>