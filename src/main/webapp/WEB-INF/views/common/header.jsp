<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${path}/resources/css/views/common/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<header class="main-header">
<%-- 로고 및 드롭다운 영역 --%>
    <div class="header-logo dropdown-container">
        <a href="${path}/">STOCK ALARM</a>
<%-- 호버 시 나타날 메뉴 --%>
        <ul class="dropdown-menu">
            <li><a href="${path}/stock/list">전체</a></li>
            <li><a href="${path}/stock/list?searchType=drop">오늘의 급락</a></li>
            <li><a href="${path}/stock/analysis">자동분석</a></li>
            <li><a href="${path}/stock/list?searchType=low">최저가 갱신</a></li>
        </ul>
    </div>
    <%-- 
    이전에 사용했던 경로 잠시 주석처리
    <ul class="dropdown-menu">
            <li><a href="${path}/stock/all">전체</a></li>
            <li><a href="${path}/stock/drop">오늘의 급락</a></li>
            <li><a href="${path}/stock/analysis">자동분석</a></li>
            <li><a href="${path}/stock/new-low">최저가 갱신</a></li>
        </ul>
    </div> --%>
    <nav class="nav-group">
    <%-- 게시판 메뉴 추가 --%>
    <a href="${path}/board/notice" class="nav-item">공지사항</a>
    <a href="${path}/board/qna" class="nav-item">Q&A</a>
    
    <c:choose>
        <c:when test="${not empty sessionScope.loginUser}">
            <%-- 기존 로그인 사용자 정보 영역 --%>
            <span class="user-info">
                <span class="user-name">
                    ${not empty sessionScope.loginUser.name ? sessionScope.loginUser.name : sessionScope.loginUser.phone}
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