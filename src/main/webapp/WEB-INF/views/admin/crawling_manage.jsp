<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<button id="btnFetch" onclick="startCrawling()">핫딜 50개 불러오기</button>
<div id="status"></div>

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
        }
    });
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>