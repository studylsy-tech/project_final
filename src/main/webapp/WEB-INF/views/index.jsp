<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 헤더 불러오기: 절대 경로 사용 --%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<style>
    .main-content {
        text-align: center;
        padding: 100px 20px;
    }
    
    .search-bar {
        width: 50%;
        padding: 15px 25px;
        font-size: 16px;
        border: 2px solid #1a2a44;
        border-radius: 30px; /* 둥근 검색창 */
        margin-bottom: 20px;
        outline: none;
    }

    .start-btn {
        background-color: #1a2a44;
        color: white;
        padding: 12px 30px;
        border: none;
        border-radius: 5px;
        font-size: 18px;
        cursor: pointer;
        transition: 0.3s;
    }

    .start-btn:hover {
        background-color: #4a90e2;
    }
</style>
<div class="main-content">
    <h2>가격 추적 플랫폼에 오신 것을 환영합니다!</h2>
    <p>(배너 / 최저가 알림 / 오늘의 급락 상품)</p>

    <form action="${pageContext.request.contextPath}/dashboard/search" method="get">
        <input type="text" name="query" class="search-bar" placeholder="관심 상품 URL 또는 상품명 검색">
        <br>
        <button type="submit" class="start-btn">가격 추적 시작하기 →</button>
    </form>
</div>

<%-- 푸터 불러오기: 절대 경로 사용 --%>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>