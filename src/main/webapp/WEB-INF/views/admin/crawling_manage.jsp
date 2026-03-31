<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>핫딜 수집 관리</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/views/common/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/crawling_manage.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="admin-wrapper">
 <div class="admin-top">
    <span class="admin-title">핫딜 데이터 수집</span>
    <c:choose>
        <c:when test="${isDbConnected}">
            <span class="badge-ok" id="dbBadge">DB 연결됨</span>
        </c:when>
        <c:otherwise>
            <span class="badge-error" id="dbBadge" style="background-color: #ff4d4d;">연결 해제</span>
        </c:otherwise>
    </c:choose>
</div>

<div class="stat-grid">
    <div class="stat-card">
        <div class="stat-label">총 수집 건수</div>
        <div class="stat-val" id="totalCount">${totalCount}건</div>
    </div>
    <div class="stat-card">
        <div class="stat-label">마지막 수집</div>
        <div class="stat-val sm" id="lastTime">${lastTime}</div>
    </div>
    <div class="stat-card">
        <div class="stat-label">수집 상태</div>
        <div class="stat-val sm" id="collectStatus">대기중</div>
    </div>
</div>

<div class="panel-card">
    <h3>연결 상태 확인 및 실행</h3>
    <div class="btn-row">
        <button class="btn-default" onclick="checkDbStatus()">상태 새로고침</button>
        <button class="btn-primary" onclick="startCrawling()">수집 시작</button>
    </div>
</div>
</div>
<script>
// 페이지가 로드될 때 자동으로 DB 상태를 한 번 확인합니다.
$(document).ready(function() {
    checkDbStatus(); 
});

// DB 상태(연결 여부, 건수, 시간)를 가져와서 화면에 반영하는 함수
function checkDbStatus() {
    $.ajax({
        url: "${pageContext.request.contextPath}/admin/getDbStatus.do", 
        method: "GET",
        success: function(res) {
            // 스토리보드의 통계 카드 id들에 데이터 바인딩
            $("#totalCount").text(res.totalCount + "건");
            $("#lastTime").text(res.lastTime);
            
            // 상단 배지 상태 업데이트
            if(res.connected) {
                $("#dbBadge").text("DB 연결됨").css("background-color", "#2ecc71");
            } else {
                $("#dbBadge").text("연결 해제").css("background-color", "#ff4d4d");
            }
        },
        error: function() {
            $("#dbBadge").text("연결 오류").css("background-color", "#ff4d4d");
        }
    });
}

// 기존에 있던 수집 시작 함수
function startCrawling() {
    $("#status").show().text("수집 중... 잠시만 기다려주세요.");
    $.ajax({
        url: "${path}/admin/fetchDeals.do",
        success: function(res) {
            if(res.status === "success") {
                $("#status").text("✓ 작업 완료: 신규 " + res.newlyAdded + "건 추가");
                // 수집 완료 후 최신 상태로 수치 갱신
                checkDbStatus(); 
            } else {
                $("#status").text("오류 발생: " + res.message);
            }
        }
    });
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>