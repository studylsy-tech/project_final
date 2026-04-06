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
            
            <%-- 1. 상단 현황판 --%>
            <div class="summary-container">
                <div class="summary-card" onclick="location.href='${path}/admin/crawling_status'">
                    <h3>크롤링 상태</h3>
                    <p class="count">정상</p>
                </div>
                
                <div class="summary-card" onclick="location.href='${path}/admin/members'">
                    <h3>전체 회원 수</h3>
                    <p class="count">${totalMemberCount}명</p>
                </div>
                
                <div class="summary-card" onclick="location.href='${path}/board/qna'">
                    <h3>미답변 Q&A</h3>
                    <p class="count">${unansweredCount}건</p>
                </div>
            </div>

            <%-- 2. 관리 메뉴 (중첩된 grid 태그를 하나로 통합) --%>
            <div class="admin-menu-grid">
                <%-- 오류 로그 관리 --%>
                <div class="menu-item" onclick="location.href='${path}/admin/error_logs'">
                    <h4>오류 로그 관리</h4>
                    <p>시스템에서 발생한 크롤링 및 서버 오류 내역을 확인하고 관리합니다.</p>
                </div>
                
                <%-- 핫딜 수집 엔진 설정 (개수 강조형) --%>
    <div class="menu-item engine-card" onclick="location.href='${path}/admin/hotdeal_engine'">
        <h4>🔥 핫딜 엔진 상태</h4>
        <div class="engine-status-box">
            <span class="status-label">현재 수집된 핫딜</span>
            <div class="main-count">
                <span id="menu-hotdeal-count">0</span><small>개</small>
            </div>
        </div>
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
<script>
$(document).ready(function() {
    // 대시보드 진입 시 즉시 개수 로드
    updateDashboardHotDealCount();
    
    // 필요 시 10초마다 자동 갱신 (선택 사항)
    // setInterval(updateDashboardHotDealCount, 10000);
});

function updateDashboardHotDealCount() {
    $.ajax({
        url: "${path}/admin/getHotDealStatus.do",
        type: "GET",
        dataType: "json",
        success: function(res) {
            // Controller 응답 키값(HOTDEALCOUNT)에 맞춰 매핑
            const count = res.HOTDEALCOUNT !== undefined ? res.HOTDEALCOUNT : (res.count || 0);
            $("#menu-hotdeal-count").text(count.toLocaleString());
        },
        error: function() {
            $("#menu-hotdeal-count").text("Error");
        }
    });
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>