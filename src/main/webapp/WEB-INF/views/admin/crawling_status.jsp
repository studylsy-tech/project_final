<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<link rel="stylesheet" href="${path}/resources/css/views/admin/crawling_status.css">

<div class="admin-container">
    <h2 class="admin-title"><i class="fas fa-chart-line"></i> 실시간 가격 추적 및 시세 관리</h2>
    
    <div class="status-card master-card">
        <div class="card-header">
            <div class="header-left">
                <h3 class="section-title"><i class="fas fa-database"></i> 전체 시세 데이터 현황</h3>
                <div class="interval-container">
                    <span class="interval-label">전체 자동 기록 주기 설정</span>
                    <div class="btn-group-mini">
                        <button type="button" class="btn-int" onclick="setSchedule('ALL', '1h')">1h</button>
                        <button type="button" class="btn-int" onclick="setSchedule('ALL', '6h')">6h</button>
                        <button type="button" class="btn-int" onclick="setSchedule('ALL', '12h')">12h</button>
                        <button type="button" class="btn-int" onclick="setSchedule('ALL', '1d')">1d</button>
                        <button type="button" class="btn-int btn-stop-all" onclick="setSchedule('ALL', 'stop')">Stop</button>
                    </div>
                </div>
            </div>
            <div class="action-group">
                <button type="button" id="btn-save-ALL" class="btn-main-save" onclick="handleUpdateClick('ALL')">
                    <i class="fas fa-save"></i> 전체 가격 기록
                </button>
                <button type="button" class="btn-main-refresh" onclick="refreshStats('ALL')">
                    <i class="fas fa-sync-alt"></i> 수치 새로고침
                </button>
            </div>
        </div>
        <div class="card-footer">
            <div class="status-item"><b>총 등록 상품</b> <span id="totalCount">${totalCount}</span> 건</div>
            <div class="status-item"><b>최종 기록 시각</b> <span id="lastTime">${totalLastSync}</span></div>
        </div>
    </div>

    <div class="status-grid">
        <div class="status-card grid-item hotdeal-card">
            <div class="card-header">
                <h3 class="grid-title"><i class="fas fa-fire"></i> 핫딜 시세 관리</h3>
                <div class="grid-actions">
                    <button type="button" id="btn-save-HOT" class="btn-grid-save" onclick="handleUpdateClick('HOT')">
                        <i class="fas fa-save"></i> 가격 기록
                    </button>
                    <button type="button" class="btn-grid-refresh" onclick="refreshStats('HOT')">
                        <i class="fas fa-sync-alt"></i> 새로고침
                    </button>
                </div>
            </div>
            <div class="grid-body">
                <div class="status-item"><b class="label-width">상품 수</b> <span id="hotdealCount">${hotdealCount}</span> 건</div>
                <div class="status-item last-record"><b class="label-width">최근 기록</b> <span id="hotdealTime">${hotdealLastSync}</span></div>
                <div class="interval-box hotdeal-interval">
                    <span class="box-label">핫딜 자동 주기</span>
                    <div class="btn-group-mini">
                        <button type="button" class="btn-int" onclick="setSchedule('HOT', '1h')">1h</button>
                        <button type="button" class="btn-int" onclick="setSchedule('HOT', '6h')">6h</button>
                        <button type="button" class="btn-int" onclick="setSchedule('HOT', '12h')">12h</button>
                        <button type="button" class="btn-int" onclick="setSchedule('HOT', '1d')">1d</button>
                        <button type="button" class="btn-int btn-stop-hot" onclick="setSchedule('HOT', 'stop')">Stop</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="status-card grid-item normal-card">
            <div class="card-header">
                <h3 class="grid-title"><i class="fas fa-tags"></i> 일반 시세 관리</h3>
                <div class="grid-actions">
                    <button type="button" id="btn-save-NORMAL" class="btn-grid-save" onclick="handleUpdateClick('NORMAL')">
                        <i class="fas fa-save"></i> 가격 기록
                    </button>
                    <button type="button" class="btn-grid-refresh" onclick="refreshStats('NORMAL')">
                        <i class="fas fa-sync-alt"></i> 새로고침
                    </button>
                </div>
            </div>
            <div class="grid-body">
                <div class="status-item"><b class="label-width">상품 수</b> <span id="commonCount">${normalCount}</span> 건</div>
                <div class="status-item last-record"><b class="label-width">최근 기록</b> <span id="commonTime">${normalLastSync}</span></div>
                <div class="interval-box normal-interval">
                    <span class="box-label">일반 자동 주기</span>
                    <div class="btn-group-mini">
                        <button type="button" class="btn-int" onclick="setSchedule('NORMAL', '1h')">1h</button>
                        <button type="button" class="btn-int" onclick="setSchedule('NORMAL', '6h')">6h</button>
                        <button type="button" class="btn-int" onclick="setSchedule('NORMAL', '12h')">12h</button>
                        <button type="button" class="btn-int" onclick="setSchedule('NORMAL', '1d')">1d</button>
                        <button type="button" class="btn-int btn-stop-normal" onclick="setSchedule('NORMAL', 'stop')">Stop</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// 실시간 상태 추적 객체
const updateStatus = { ALL: false, HOT: false, NORMAL: false };

// [버튼 통합 컨트롤러]
function handleUpdateClick(type) {
    if (updateStatus[type]) {
        stopUpdate(type);
    } else {
        startUpdate(type);
    }
}

// [실행] 가격 기록 시작
function startUpdate(type) {
    const typeNm = type === 'ALL' ? '전체' : (type === 'HOT' ? '핫딜' : '일반');
    if(!confirm(typeNm + " 가격 기록을 시작하시겠습니까?")) return;
    
    toggleBtnUI(type, true); // UI 정지 상태로 전환

    $.ajax({
        url: "${path}/admin/startPriceUpdate.do",
        type: "POST",
        data: { target: type },
        success: function(res) {
            if(res.status === "success") {
                alert(typeNm + " 가격 기록 완료 (" + res.count + "건)");
            } else {
                alert("기록 실패: " + res.message);
            }
        },
        error: function() { alert("통신 중 오류가 발생했습니다."); },
        complete: function() {
            toggleBtnUI(type, false); // UI 복구
            refreshData(type);
        }
    });
}

// [정지] 가격 기록 중단
function stopUpdate(type) {
    const typeNm = type === 'ALL' ? '전체' : (type === 'HOT' ? '핫딜' : '일반');
    if(!confirm(typeNm + " 프로세스를 중지하시겠습니까?")) return;

    $.ajax({
        url: "${path}/admin/stopPriceUpdate.do", // 서버에 정지 신호 전송
        type: "POST",
        data: { target: type },
        success: function() {
            alert(typeNm + " 기록 작업이 중지되었습니다.");
            toggleBtnUI(type, false);
        }
    });
}

// [UI 변경] 버튼을 정지/기록 상태로 전환
function toggleBtnUI(type, isRunning) {
    updateStatus[type] = isRunning;
    const $btn = $("#btn-save-" + type);
    
    if (isRunning) {
        // 정지 버튼 모드
        $btn.html('<i class="fas fa-stop"></i> 정지하기');
        $btn.addClass('btn-is-running'); // CSS 효과 추가
    } else {
        // 기록 버튼 모드
        const originalText = (type === 'ALL') ? '전체 가격 기록' : '가격 기록';
        $btn.html('<i class="fas fa-save"></i> ' + originalText);
        $btn.removeClass('btn-is-running');
    }
}

// 기존 스케줄 설정 함수 (Stop 클릭 시 UI 연동 추가)
function setSchedule(target, interval) {
    $.ajax({
        url: "${path}/admin/updateSchedule.do",
        type: "POST",
        data: { target: target, interval: interval },
        success: function(res) {
            alert(target + " 주기 설정: " + interval);
            if(interval === 'stop') toggleBtnUI(target, false);
            $(event.target).addClass('active').siblings().removeClass('active');
        }
    });
}

// 수치 새로고침 Ajax
function refreshData(type) {
    $.ajax({
        url: "${path}/admin/refreshStats.do",
        type: "GET",
        success: function(data) {
            $("#totalCount").text(data.TOTALCOUNT);
            $("#lastTime").text(data.TOTALLASTSYNC);
            $("#hotdealCount").text(data.HOTDEALCOUNT);
            $("#hotdealTime").text(data.HOTDEALLASTSYNC);
            $("#commonCount").text(data.NORMALCOUNT);
            $("#commonTime").text(data.NORMALLASTSYNC);
        }
    });
}
function refreshData(type) {
    $.ajax({
        url: "${path}/admin/refreshStats.do",
        type: "GET",
        data: { type: type }, // 현재 클릭한 섹션 타입 전송
        success: function(data) {
            console.log("받은 데이터:", data); // 여기서 키 값을 확인하세요 (대문자인지 소문자인지)

            // 만약 MyBatis가 대문자로 준다면 아래와 같이 작성
            if (data.TOTALCOUNT !== undefined) {
                $("#totalCount").text(data.TOTALCOUNT);
                $("#lastTime").text(data.TOTALLASTSYNC);
                $("#hotdealCount").text(data.HOTDEALCOUNT);
                $("#hotdealTime").text(data.HOTDEALLASTSYNC);
                $("#commonCount").text(data.NORMALCOUNT);
                $("#commonTime").text(data.NORMALLASTSYNC);
            } else {
                // 소문자로 온다면 아래와 같이 작성
                $("#totalCount").text(data.totalCount);
                $("#lastTime").text(data.totalLastSync);
                $("#hotdealCount").text(data.hotdealCount);
                $("#hotdealTime").text(data.hotdealLastSync);
                $("#commonCount").text(data.normalCount);
                $("#commonTime").text(data.normalLastSync);
            }
            
            alert(type + " 데이터가 최신 상태로 갱신되었습니다.");
        },
        error: function() {
            alert("데이터를 가져오는 중 오류가 발생했습니다.");
        }
    });
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>