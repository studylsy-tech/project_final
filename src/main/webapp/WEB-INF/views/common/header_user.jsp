<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 상위 header.jsp의 path 변수와 세션의 loginUser 정보를 사용한다고 가정합니다 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class="user-header">
    <%-- 1. 홈: 메인 페이지 이동 [cite: 75, 83] --%>
    <a href="${path}/" class="nav-item">홈</a>

    <%-- 2. 사용자 환영 메시지: 로그인한 사용자 이름 출력 [cite: 75] --%>
    <span class="user-welcome"><strong>${not empty loginUser.name ? loginUser.name : loginUser.phone}</strong>님 반갑습니다.</span>

    <div class="menu-group">
        <%-- 3. 내 정보: 회원 정보 페이지 이동 및 알림 배지(3개 예시) 표시 [cite: 76, 88] --%>
        <a href="${path}/member/info" class="nav-item info-link">
            내 정보
            <span class="notification-badge">3</span>
        </a>

        <%-- 4. 로그아웃: 세션 정보 제거 및 로그아웃 처리 [cite: 77, 89] --%>
        <a href="${path}/member/logout" class="nav-item">로그아웃</a>

        <%-- 5. 공지: 공지사항 게시판 이동 [cite: 78, 86] --%>
        <a href="${path}/board/notice" class="nav-item">공지</a>

        <%-- 6. QNA: 질문과 답변 게시판 이동 [cite: 79, 87] --%>
        <a href="${path}/board/qna" class="nav-item">QNA</a>
    </div>
</div>

<style>
    .user-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        background-color: #1a2a3a; /* 스토리보드 네이비 테마 */
        padding: 10px 20px;
        color: #ffffff;
    }

    .nav-item {
        color: #ffffff;
        text-decoration: none;
        margin-right: 15px;
        font-size: 14px;
    }

    .user-welcome {
        font-size: 14px;
        color: #ffeb3b; /* 강조색 */
        margin-left: 10px;
    }

    .info-link {
        position: relative;
    }

    /* 알림 배지 스타일 (스토리보드 Screen 2의 빨간 숫자 3 반영)  */
    .notification-badge {
        position: absolute;
        top: -8px;
        right: -12px;
        background-color: #f44336; /* 빨간색 배지 */
        color: white;
        border-radius: 50%;
        padding: 2px 6px;
        font-size: 10px;
        font-weight: bold;
    }
</style>