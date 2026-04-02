<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/member/info.css">
<link rel="stylesheet" href="${path}/resources/css/admin/error_logs.css">

<div class="mypage-wrapper">
    <div class="mypage-header">
        <h2 class="main-title">마이페이지</h2>
        <div class="tab-container">
            <a href="${path}/member/info" class="tab-item">내 정보 확인</a>
            <a href="${path}/member/notification" class="tab-item">알림 설정</a>
            <a href="${path}/admin/main" class="tab-item admin-tab active">관리자 모드</a>
        </div>
    </div>

    <div class="info-content-box">
        <div class="admin-wrapper">
            <div class="admin-header">
                <h3 class="settings-title">오류 로그 관리</h3>
            </div>

            <div class="panel-card">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>발생 시각</th>
                            <th>대상 사이트</th>
                            <th>오류 유형</th>
                            <th>상태</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>2026-04-02 10:15</td>
                            <td>뽐뿌 게시판</td>
                            <td>TimeoutException</td>
                            <td><span class="badge-error">미처리</span></td>
                            <td><button class="btn-default">상세보기</button></td>
                        </tr>
                        <tr>
                            <td>2026-04-02 09:30</td>
                            <td>루리웹 핫딜</td>
                            <td>NoSuchElementException</td>
                            <td><span class="badge-ok">조치완료</span></td>
                            <td><button class="btn-default">로그확인</button></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>