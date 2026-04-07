<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/admin/hotdeal_engine.css">

<div class="mypage-wrapper">
    <div class="mypage-header">
        <h2 class="main-title">핫딜 엔진 제어 시스템</h2>
    </div>

    <div class="info-content-box">
        <div class="admin-wrapper">
            <div class="section-header">
                <h3>📊 실시간 수집 현황</h3>
                <div class="status-panel">
                    <span>연결 상태: <strong id="db-status">연결 확인 중...</strong></span>
                    
                     <span style="margin-left: 20px;">누적 핫딜 수: <strong id="count-hotdeal">0</strong>개</span> 
                    <button class="btn-refresh" onclick="updateHotDealStatus()"><strong>현황 갱신</strong></button>
                </div>
            </div>
<%-- 수집 카드 섹션 수정 --%>
<div class="engine-card">
    <div class="card-info">
       <h4><span class="site-name">핫딜 트래커</span></h4>
       <h4><span class="site-name">HotDeal Tracker</span></h4>
        <p><strong>TB_HOTDEAL_TRACKER 테이블로</strong></p>
        <p><strong> 데이터를 10개씩 </strong></p>
        <p><strong> 크롤링하여 동기화합니다.</strong></p>
    </div>
    <div class="card-actions">
        <button id="engine-btn" class="btn-engine start" onclick="toggleHotDealEngine()"><h3>수집 실행</h3></button>
        <button class="btn-engine delete" onclick="deleteAllDeals()"><h3>데이터 초기화</h3></button>
    </div>
</div>

<script>
function deleteAllDeals() {
    if (!confirm("모든 핫딜 데이터를 삭제하시겠습니까?")) return;

    $.ajax({
        url: "${path}/admin/deleteAllDeals.do",
        type: "POST",
        dataType: "json",
        success: function(res) {
            if (res.status === "success") {
                alert("데이터가 성공적으로 초기화되었습니다.");
                updateHotDealStatus(); // 개수 0으로 갱신
            }
        },
        error: function() {
            alert("서버 통신 중 오류가 발생했습니다.");
        }
    });
}
$(document).ready(function() {
    // 페이지 로드 시 즉시 실행하여 '연결 확인 중...' 상태를 업데이트함
    updateHotDealStatus();
});

// 1. 상태 및 개수 실시간 조회
function updateHotDealStatus() {
    $.ajax({
        url: "${path}/admin/getHotDealStatus.do",
        type: "GET",
        dataType: "json", // 응답 형식을 명시
        success: function(res) {
            // AdminMapper.xml의 getDashboardStats 결과(HOTDEALCOUNT)와 
            // 일반 카운트 응답(count)을 모두 체크함
            const count = res.HOTDEALCOUNT !== undefined ? res.HOTDEALCOUNT : (res.count || 0);
            $("#count-hotdeal").text(count);
            $("#db-status").text("정상(CONNECTED)").css("color", "green");
        },
        error: function() {
            $("#db-status").text("연결 끊김(DISCONNECTED)").css("color", "red");
        }
    });
}
let isCrawling = false;

let statusInterval = null; // 숫자를 주기적으로 체크할 타이머 변수

function toggleHotDealEngine() {
    const btn = $("#engine-btn");

    if (!isCrawling) {
        if(!confirm("핫딜 수집을 실행하시겠습니까?")) return;
        
        isCrawling = true;
        btn.removeClass("start").addClass("stop").text("정지하기");

        $.ajax({
            url: "${path}/admin/runHotDealEngine.do",
            type: "POST",
            success: function(res) {
                if(res.status === "success") {
                    // 수집 시작 성공 시 2초마다 상태 갱신 함수 호출
                    statusInterval = setInterval(updateHotDealStatus, 2000);
                }
            },
            error: function() {
                alert("수집 시작 중 오류 발생");
                isCrawling = false;
                btn.removeClass("stop").addClass("start").text("수집 실행");
            }
        });
    } else {
        if(!confirm("진행 중인 수집을 정지하시겠습니까?")) return;
        
        $.ajax({
            url: "${path}/admin/stopHotDealEngine.do",
            type: "POST",
            success: function(res) {
                alert("정지 신호를 보냈습니다.");
                isCrawling = false;
                btn.removeClass("stop").addClass("start").text("수집 실행");
                
                // 정지 시 타이머 해제
                if(statusInterval) {
                    clearInterval(statusInterval);
                    statusInterval = null;
                }
                updateHotDealStatus(); // 최종 상태 확인
            }
        });
    }
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>