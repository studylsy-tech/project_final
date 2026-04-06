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
<%-- 기존 스타일 시트 유지 --%>
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
            <%-- 상단 현황판 --%>
            <div class="summary-container" style="display: flex; gap: 20px; margin-bottom: 30px;">
                <div class="summary-card" onclick="location.href='${path}/admin/crawling_status'" style="flex: 1; padding: 20px; background: #f8f9fa; border-radius: 8px; cursor: pointer; text-align: center;">
                    <h3 style="font-size: 16px; color: #666;">크롤링 상태</h3>
                    <p class="count" style="font-size: 24px; font-weight: bold; color: #28a745;">정상 작동 중</p>
                </div>
                <div class="summary-card" onclick="location.href='${path}/admin/error_logs'" style="flex: 1; padding: 20px; background: #f8f9fa; border-radius: 8px; cursor: pointer; text-align: center;">
                    <h3 style="font-size: 16px; color: #666;">미처리 오류</h3>
                    <p class="count" style="font-size: 24px; font-weight: bold; color: #dc3545;">5건</p>
                </div>
                <div class="summary-card" style="flex: 1; padding: 20px; background: #f8f9fa; border-radius: 8px; text-align: center;">
                    <h3 style="font-size: 16px; color: #666;">신규 Q&A</h3>
                    <p class="count" style="font-size: 24px; font-weight: bold; color: #007bff;">2건</p>
                </div>
            </div>

            <%-- 관리 메뉴 --%>
            <div class="admin-menu-grid" style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px;">
                <div class="menu-item" onclick="location.href='${path}/admin/error_logs'" style="padding: 20px; border: 1px solid #ddd; border-radius: 8px; cursor: pointer;">
                    <h4 style="margin-bottom: 10px;">오류 로그 관리</h4>
                    <p style="font-size: 13px; color: #777;">크롤링 중 발생한 오류 내역을 확인합니다.</p>
                </div>
                <div class="menu-item" onclick="location.href='${path}/admin/crawling_manage'" style="padding: 20px; border: 1px solid #ddd; border-radius: 8px; cursor: pointer;">
                    <h4 style="margin-bottom: 10px;">크롤링 정책 관리</h4>
                    <p style="font-size: 13px; color: #777;">사이트별 수집 주기 및 규칙을 설정합니다.</p>
                </div>
                <div class="menu-item" onclick="location.href='${path}/admin/notice_manage'" style="padding: 20px; border: 1px solid #ddd; border-radius: 8px; cursor: pointer;">
                    <h4 style="margin-bottom: 10px;">공지사항 관리</h4>
                    <p style="font-size: 13px; color: #777;">사용자 공지사항을 작성하고 관리합니다.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>