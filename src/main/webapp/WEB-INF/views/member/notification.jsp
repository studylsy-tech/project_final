<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<c:if test="${empty sessionScope.loginUser}">
    <script>
        alert("로그인이 필요한 페이지입니다.");
        location.href = "${path}/member/login";
    </script>
</c:if>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/member/info.css">
<link rel="stylesheet" href="${path}/resources/css/views/member/notification.css">

<div class="mypage-outer-container">
<div class="mypage-wrapper">
    <div class="mypage-header">
        <h2 class="main-title">마이페이지</h2>
        <div class="tab-container">
            <a href="${path}/member/info" class="tab-item">내 정보 확인</a>
            <a href="${path}/member/notification" class="tab-item active">알림 설정</a>
            <%-- 관리자 권한(0) 확인 --%>
            <c:if test="${sessionScope.loginUser.memberType == 0}">
                <a href="${path}/admin/main" class="tab-item admin-tab">관리자 모드</a>
            </c:if>
        </div>
    </div>

    <div class="info-content-box">
        <div class="settings-container">
            <h2 class="settings-title">알림 설정</h2>

            <div class="slot-info-box">
                알림 잔여 슬롯 : 7 / 10 (쿠폰 사용 시 추가 가능)
            </div>

            <form action="${path}/member/updateNotification" method="post">
                <div class="setting-section">
                    <label class="section-label">수신 이메일 주소</label>
                    <div class="email-input-group">
                        <input type="email" name="email" value="<c:out value='${sessionScope.loginUser.email}'/>" placeholder="user@example.com" readonly>
                        <button type="button" class="btn-change" onclick="location.href='${path}/member/update'">변경 이동</button>
                    </div>
                </div>

                <div class="setting-section">
                    <label class="section-label">알림 유형 선택</label>
                    
                    <%-- 이메일 알림 설정 (DTO 필드: email_alarm) --%>
                    <div class="noti-item">
                        <span>이메일 알림 수신</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="email_alarm" value="Y" ${sessionScope.loginUser.email_alarm eq 'Y' ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>

                    <%-- 웹 푸시 알림 설정 (DTO 필드: web_alarm) --%>
                    <div class="noti-item">
                        <span>웹 푸시 알림 수신</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="web_alarm" value="Y" ${sessionScope.loginUser.web_alarm eq 'Y' ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>

                    <%-- 야간 알림 제한 설정 (DTO 필드: night_alarm) --%>
                    <div class="noti-item">
                        <span>야간 알림 제한 (21시~08시)</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="night_alarm" value="Y" ${sessionScope.loginUser.night_alarm eq 'Y' ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>

                <div class="btn-area">
                    <button type="submit" class="btn-submit-all">설정 저장</button>
                </div>
            </form>
        </div>
    </div>
</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>