<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>크롤링 관리자 패널</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${path}/resources/css/admin/crawling_manage.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="admin-wrapper">
    <div class="admin-card">
        <h2>실시간 데이터 수집</h2>
        <p>외부 사이트에서 최신 핫딜 정보를 수집합니다.<br>분석을 위해 테스트용 20건을 데이터베이스에 적재합니다.</p>
        
        <button id="btnFetch" onclick="startCrawling()" class="btn-fetch">
            핫딜 20개 수집 시작
        </button>
        
        <div id="status"></div>
    </div>
</div>

<script>
function startCrawling() {
    $("#status").text("크롤링 중... 잠시만 기다려주세요.");
    $.ajax({
        url: "${pageContext.request.contextPath}/admin/fetchDeals.do",
        success: function(res) {
            if(res === "success") {
                alert("50개의 핫딜을 성공적으로 불러와 분석 데이터로 저장했습니다.");
                location.href = "${pageContext.request.contextPath}/stock/analysis";
            } else {
                alert("크롤링 실패");
            }
        },
        error: function(xhr, status, error) {  // 추가
            $("#status").text("");
            alert("오류가 발생했습니다: " + status);
        }
    });
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>