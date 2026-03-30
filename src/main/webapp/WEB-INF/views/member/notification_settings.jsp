<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<link rel="stylesheet" href="${path}/resources/css/views/member/notification.css">

<div class="main-content">
    <div class="settings-container">
        <h2 class="settings-title">알림 설정</h2>

        <%-- ① 알림 잔여 슬롯 --%>
        <div class="slot-info-box">
            ① 알림 잔여 슬롯 : 7 / 10 (쿠폰 사용 시 추가 가능)
        </div>

        <form action="${path}/member/updateNotification" method="post">
            <%-- ② 수신 이메일 주소 --%>
            <div class="setting-section">
                <label class="section-label">② 수신 이메일 주소</label>
                <div class="email-input-group">
                    <input type="email" name="email" value="${loginUser.email}" placeholder="user@example.com" readonly>
                    <button type="button" class="btn-change">변경 저장</button>
                </div>
            </div>

            <%-- ③ 알림 유형 선택 --%>
            <div class="setting-section">
                <label class="section-label">③ 알림 유형 선택</label>
                
                <div class="noti-item">
                    <span>목표가 도달 알림</span>
                    <label class="toggle-switch">
                        <input type="checkbox" name="goal_alarm" value="Y" checked>
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="noti-item">
                    <span>최저가 갱신 알림 (역대)</span>
                    <label class="toggle-switch">
                        <input type="checkbox" name="lowest_alarm" value="Y" checked>
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="noti-item">
                    <span>주간 가격 요약 리포트</span>
                    <label class="toggle-switch">
                        <input type="checkbox" name="weekly_report" value="Y">
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="noti-item">
                    <span>마케팅·이벤트 알림</span>
                    <label class="toggle-switch">
                        <input type="checkbox" name="marketing_alarm" value="Y">
                        <span class="slider"></span>
                    </label>
                </div>
            </div>

            <%-- ④ 설정 저장 버튼 --%>
            <div class="btn-area">
                <button type="submit" class="btn-submit-all">④ 설정 저장</button>
            </div>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>