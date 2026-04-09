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
                            <th>대상 상품군</th>
                            <th>오류 유형 및 데이터</th>
                            <th>상태</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>2026-04-08 11:45</td>
                            <td>고성능 게이밍 노트북</td>
                            <td>정상가 누락 (Price: 0)</td>
                            <td><span class="badge-error">미처리</span></td>
                            <td><button class="btn-default">상세보기</button></td>
                        </tr>
                        
                        <tr>
                            <td>2026-04-08 10:20</td>
                            <td>RTX 4080 Super</td>
                            <td>급격한 가격 상승 (기존가 대비 +85%)</td>
                            <td><span class="badge-error">미처리</span></td>
                            <td><button class="btn-default">상세보기</button></td>
                        </tr>
                        
                        <tr>
                            <td>2026-04-08 09:05</td>
                            <td>프리미엄 스테이크 세트</td>
                            <td>판매 페이지 경로 유실 (404 Not Found)</td>
                            <td><span class="badge-error">미처리</span></td>
                            <td><button class="btn-default">상세보기</button></td>
                        </tr>
                        
                        <tr>
                            <td>2026-04-08 08:30</td>
                            <td>32인치 4K 모니터</td>
                            <td>급격한 가격 하락 (기존가 대비 -62%)</td>
                            <td><span class="badge-ok">조치완료</span></td>
                            <td><button class="btn-default">로그확인</button></td>
                        </tr>

                        <tr>
                            <td>2026-04-07 23:15</td>
                            <td>닭가슴살 팩 묶음</td>
                            <td>상품명/이미지 매칭 실패</td>
                            <td><span class="badge-ok">조치완료</span></td>
                            <td><button class="btn-default">로그확인</button></td>
                        </tr>
                        
                        <tr>
                            <td>2026-04-07 21:00</td>
                            <td>AMD 라이젠 9 7950X</td>
                            <td>비정상 데이터 수집 (Price: 0)</td>
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