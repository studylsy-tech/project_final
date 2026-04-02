<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%-- 마이페이지 레이아웃 유지용 info.css와 관리자 전용 admin_main.css 연결 --%>
<link rel="stylesheet" href="${path}/resources/css/views/member/info.css">
<link rel="stylesheet" href="${path}/resources/css/admin/notice_manage.css">

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
            <div class="admin-header" style="display: flex; justify-content: space-between; align-items: center;">
                <h3 class="settings-title">공지사항 관리</h3>
                <button class="btn-primary" onclick="location.href='${path}/board/write'">신규 등록</button>
            </div>

            <div class="panel-card">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>등록일</th>
                            <th>조회수</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>시스템 정기 점검 안내</td>
                            <td>2026-04-01</td>
                            <td>152</td>
                            <td>게시중</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>크롤링 정책 변경 공지</td>
                            <td>2026-03-28</td>
                            <td>89</td>
                            <td>숨김</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>