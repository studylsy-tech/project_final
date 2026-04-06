<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 관리자 권한 체크 (0: 관리자) --%>
<c:if test="${sessionScope.loginUser.memberType != 0}">
    <script>
        alert("관리자만 접근 가능한 페이지입니다.");
        location.href = "${path}/";
    </script>
</c:if>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/member/info.css">
<link rel="stylesheet" href="${path}/resources/css/admin/admin_main.css">

<div class="mypage-wrapper">
    <div class="mypage-header">
        <h2 class="main-title">마이페이지</h2>
        <div class="tab-container">
            <a href="${path}/member/info" class="tab-item">내 정보 확인</a>
            <a href="${path}/member/notification" class="tab-item">알림 설정</a>
            <a href="${path}/admin/main" class="tab-item admin-tab active">관리자 대시보드</a>
        </div>
    </div>

    <div class="info-content-box">
        <div class="admin-wrapper">
            
            <%-- 1. 상단 현황판 (CSS의 summary-container 클래스 사용) --%>
            <div class="summary-container">
                <%-- 크롤링 상태 --%>
                <div class="summary-card" onclick="location.href='${path}/admin/crawling_status'">
                    <h3>크롤링 상태</h3>
                    <p class="count">정상</p>
                </div>
                
                <%-- 전체 회원 수 (CSS 순서상 2번째인 빨간색 강조 적용됨) --%>
                <div class="summary-card" onclick="location.href='${path}/admin/members'">
                    <h3>전체 회원 수</h3>
                    <p class="count">${totalMemberCount}명</p>
                </div>
                
                <%-- 미답변 Q&A (CSS 순서상 3번째인 파란색 강조 적용됨) --%>
                <div class="summary-card" onclick="location.href='${path}/board/qna'">
                    <h3>미답변 Q&A</h3>
                    <p class="count">${unansweredCount}건</p>
                </div>
            </div>

            <%-- 2. 관리 메뉴 (CSS의 admin-menu-grid 및 menu-item 클래스 사용) --%>
            <div class="admin-menu-grid">
                <%-- 오류 로그 관리 --%>
                <div class="menu-item" onclick="location.href='${path}/admin/error_logs'">
                    <h4>오류 로그 관리</h4>
                    <p>시스템에서 발생한 크롤링 및 서버 오류 내역을 확인하고 관리합니다.</p>
                </div>
                
                <%-- 크롤링 정책 관리 --%>
                <div class="menu-item" onclick="location.href='${path}/admin/crawling_manage'">
                    <h4>크롤링 정책 관리</h4>
                    <p>사이트별 데이터 수집 주기, 수집 규칙 및 대상 URL을 설정합니다.</p>
                </div>
                
                <%-- 공지사항 관리 --%>
                <div class="menu-item" onclick="location.href='${path}/admin/notice_manage'">
                    <h4>공지사항 관리</h4>
                    <p>전체 사용자에게 노출되는 공지사항을 작성, 수정 및 삭제합니다.</p>
                </div>
            </div>

        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>