<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 관리자 권한 체크 --%>
<c:if test="${sessionScope.loginUser.memberType ne 'ADMIN'}">
	<script>
		alert("관리자만 접근 가능한 페이지입니다.");
		location.href = "${path}/";
	</script>
</c:if>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%-- 마이페이지 레이아웃 유지용 info.css와 관리자 전용 admin_main.css 연결 --%>
<link rel="stylesheet"
	href="${path}/resources/css/views/member/info.css">
<link rel="stylesheet" href="${path}/resources/css/admin/admin_main.css">

<div class="mypage-wrapper">
	<%-- 마이페이지 공통 탭 메뉴 --%>
	<div class="mypage-header">
		<h2 class="main-title">마이페이지</h2>
		<div class="tab-container">
			<a href="${path}/member/info" class="tab-item">내 정보 확인</a> <a
				href="${path}/member/notification" class="tab-item">알림 설정</a> <a
				href="${path}/admin/main" class="tab-item admin-tab active">관리자
				모드</a>
		</div>
	</div>

	<%-- 관리자 대시보드 컨텐츠 영역 --%>
	<div class="info-content-box">
		<div class="admin-wrapper">
			<div class="admin-header">
				<h3 class="settings-title">시스템 관리자 대시보드</h3>
			</div>

			<%-- 상단 현황판 --%>
			<div class="summary-container">
				<div class="summary-card">
					<h3>크롤링 상태</h3>
					<p class="count">정상 작동 중</p>
				</div>
				<div class="summary-card">
					<h3>미처리 오류</h3>
					<p class="count" style="color: #dc3545;">5건</p>
				</div>
				<div class="summary-card">
					<h3>신규 Q&A</h3>
					<p class="count">2건</p>
				</div>
			</div>

			<%-- 메뉴 그리드 --%>
			<div class="admin-menu-grid">
				<div class="menu-item"
					onclick="location.href='${path}/admin/error_logs'">
					<h4>오류 로그 관리</h4>
					<p>Selenium 크롤링 중 발생한 오류 및 조치 내역을 확인합니다.</p>
				</div>
				<div class="menu-item"
					onclick="location.href='${path}/admin/crawling_manage'">
					<h4>크롤링 정책 관리</h4>
					<p>사이트별 크롤링 주기 및 자동 대응 규칙을 설정합니다.</p>
				</div>
				<div class="menu-item"
					onclick="location.href='${path}/admin/notice_manage'">
					<h4>공지사항 관리</h4>
					<p>사용자에게 보여질 공지사항을 작성하고 관리합니다.</p>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>