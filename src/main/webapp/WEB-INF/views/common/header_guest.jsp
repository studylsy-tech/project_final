<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 비로그인 사용자 헤더 (스토리보드 Screen 2 국문 명칭 반영) --%>
<div class="header-nav">
    <div class="menu-group">
        <a href="${path}/" class="menu-item">홈</a>
        <a href="${path}/member/login" class="menu-item">로그인</a>
        <a href="${path}/member/join" class="menu-item join-highlight">회원가입</a>
        <a href="${path}/board/notice" class="menu-item">공지</a>
        <a href="${path}/board/qna" class="menu-item">QNA</a>
    </div>
</div>

<style>
    .header-nav {
        background-color: #1a2a3a; /* 스토리보드 상단 바 배경색 */
        padding: 12px 24px;
        display: flex;
        justify-content: flex-end; /* 오른쪽 정렬 */
    }

    .menu-group {
        display: flex;
        align-items: center;
        gap: 25px; /* 메뉴 간 간격 */
    }

    .menu-item {
        color: #ffffff;
        text-decoration: none;
        font-size: 15px;
        font-weight: 500;
        transition: color 0.2s ease;
    }

    .menu-item:hover {
        color: #26a69a; /* 호버 시 포인트 색상 */
    }

    /* 회원가입 버튼 강조 스타일 (스토리보드 참고) */
    .join-highlight {
        background-color: #00897b; 
        padding: 6px 16px;
        border-radius: 4px;
        font-weight: bold;
    }

    .join-highlight:hover {
        background-color: #00695c;
        color: #ffffff;
    }
</style>