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
    <span class="badge-ok">API 연결됨</span>
  </div>
  <div class="stat-grid">
    <div class="stat-card"><div class="stat-label">총 수집 건수</div><div class="stat-val" id="totalCount">-</div></div>
    <div class="stat-card"><div class="stat-label">마지막 수집</div><div class="stat-val sm" id="lastTime">-</div></div>
    <div class="stat-card"><div class="stat-label">수집 상태</div><div class="stat-val sm" id="collectStatus">대기중</div></div>
  </div>
  <div class="panel-card">
    <h3>실시간 수집 실행</h3>
    <p>hotdeal.zip API에서 최신 핫딜 20건을 수집해 DB에 저장합니다.</p>
    <div class="btn-row">
      <button class="btn-primary" onclick="startCrawling()">수집 시작</button>
      <button class="btn-default" onclick="location.href='${pageContext.request.contextPath}/stock/analysis'">분석 페이지로 이동</button>
    </div>
    <div id="status" class="status-bar"></div>
  </div>
</div>
<script>
function startCrawling() {
    $("#status").show().text("수집 중... 잠시만 기다려주세요.");
    $.ajax({
        url: "${path}/admin/fetchDeals.do",
        success: function(res) {
            if(res.status === "success") {
                // 신규 추가된 개수와 전체 개수를 각각 출력
                $("#status").text("✓ 작업 완료: 신규 " + res.newlyAdded + "건 추가");
                $("#totalCount").text(res.totalCount + "건"); 
                $("#lastTime").text(res.lastTime);
                $("#collectStatus").text("대기중");
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