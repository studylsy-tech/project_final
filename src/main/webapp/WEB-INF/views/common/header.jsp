<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${path}/resources/css/views/common/header.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<header class="main-header">
    <div class="header-logo dropdown-container">
        <a href="${path}/">STOCK ALARM</a>
        <ul class="dropdown-menu">
            <li><a href="${path}/stock/list">전체</a></li>
            <li><a href="${path}/stock/list?searchType=drop">오늘의 급락</a></li>
            <li><a href="${path}/stock/analysis">자동분석</a></li>
            <li><a href="${path}/stock/list?searchType=low">최저가 갱신</a></li>
        </ul>
    </div>
    <nav class="nav-group">
        <a href="${path}/board/notice" class="nav-item">공지사항</a>
        <a href="${path}/board/qna" class="nav-item">Q&A</a>
        <c:choose>
            <c:when test="${not empty sessionScope.loginUser}">
                <span class="user-info">
                    <span class="user-name">
                        <c:out value="${sessionScope.loginUser.nickname}" />
                    </span>님 반갑습니다.
                </span>
                <a href="${path}/member/info" class="nav-item info-link">내 정보</a>
                <a href="${path}/member/logout" class="nav-item">로그아웃</a>
            </c:when>
            <c:otherwise>
                <a href="${path}/member/login" class="nav-item btn-login">로그인</a>
                <a href="${path}/member/join" class="nav-item">회원가입</a>
            </c:otherwise>
        </c:choose>
    </nav>
</header>