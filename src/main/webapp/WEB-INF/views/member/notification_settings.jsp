<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/member/info.css">
<link rel="stylesheet" href="${path}/resources/css/views/member/notification.css">

<div class="mypage-wrapper">
    <div class="mypage-header">
        <h2 class="main-title">마이페이지</h2>
        <div class="tab-container">
            <a href="${path}/member/info" class="tab-item">내 정보 확인</a>
            <a href="${path}/member/notification" class="tab-item active">알림 설정</a>
        </div>
    </div>

    <div class="notif-content-box">
        <%-- ① 상단 요약 카드 영역 --%>
        <div class="summary-section">
            <div class="summary-card tracking">
                <div class="card-title">① 추적중인 상품</div>
                <div class="card-value">12</div>
            </div>
            <div class="summary-card goal">
                <div class="card-title">목표가 도달</div>
                <div class="card-value">3</div>
            </div>
            <div class="summary-card lowest">
                <div class="card-title">이번 달 최저가</div>
                <div class="card-value">5</div>
            </div>
        </div>

        <%-- ② 관심 상품 목록 영역 --%>
        <div class="list-section">
            <div class="section-header">
                <h3>② 관심 상품 목록</h3>
                <button class="btn-add-item">+ 상품 추가</button>
            </div>
            <div class="product-list">
                <div class="product-item">
                    <div class="item-info">Apple MacBook Pro M4</div>
                    <div class="item-prices">
                        <span>현재 ₩2,290,000</span>
                        <span>목표 ₩2,100,000</span>
                        <span class="price-down">▼ 2.1%</span>
                    </div>
                    <div class="item-status"><span class="badge tracking">추적중</span></div>
                </div>
                </div>
        </div>

        <%-- ③ 최근 알림 내역 영역 --%>
        <div class="notification-section">
            <div class="section-header-box">
                <h3>③ 최근 알림 내역</h3>
            </div>
            <div class="notif-list">
                <div class="notif-item">
                    <span class="notif-text">MacBook Pro M4 – 목표가 ₩2,100,000 도달! (2026.03.22 14:30)</span>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>