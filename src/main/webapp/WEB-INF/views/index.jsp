<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 헤더 불러오기 --%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<link rel="stylesheet" href="${path}/resources/css/views/index.css">

<div class="main-content">
    <c:choose>
        <c:when test="${not empty sessionScope.loginUser}">
            <h2>
                <c:out value="${not empty loginUser.nickname ? loginUser.nickname : loginUser.name}" />님, 
                가격 추적 플랫폼에 오신 것을 환영합니다!
            </h2>
        </c:when>
        <c:otherwise>
            <h2>가격 추적 플랫폼에 오신 것을 환영합니다!</h2>
        </c:otherwise>
    </c:choose>
    
    <p>(배너 / 최저가 알림 / 오늘의 급락 상품)</p>

    <%-- 상품번호 입력란 제거 및 검색창 정렬 --%>
    <form action="${path}/dashboard/search" method="get" style="text-align: center; margin-bottom: 50px;">
        <input type="text" name="query" class="search-bar" 
               style="width: 60%; padding: 15px; border: 2px solid #ff9800; border-radius: 30px; outline: none;" 
               placeholder="관심 상품 URL 또는 상품명 검색" required>
        <br><br>
        <button type="submit" class="start-btn" 
                style="padding: 12px 30px; background: #ff9800; color: white; border: none; border-radius: 25px; cursor: pointer; font-weight: bold;">
            지금 가격 추적 시작하기 →
        </button>
    </form>
</div>

<%-- 메인 핫딜 & 급락 섹션 --%>
<section class="main-top-integrated-section" style="display: flex; gap: 20px; margin-bottom: 40px; align-items: flex-start; padding: 0 20px;">
    
    <%-- 좌측: 핫딜 그리드 (5x2) --%>
    <div class="hotdeal-grid-container" style="flex: 7.5; background: #fff; padding: 20px; border-radius: 12px; border: 1px solid #eee;">
        <div class="section-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h3 style="color: #ff9800; margin: 0;">✨ 실시간 인기 핫딜</h3>
            <div class="hotdeal-pagination">
                <button class="btn-pager prev" style="background: none; border: 1px solid #ccc; border-radius: 50%; cursor: pointer; width: 30px; height: 30px;">&lt;</button>
                <span class="page-info" style="margin: 0 10px; font-size: 0.9em; color: #666;">1 / 5</span>
                <button class="btn-pager next" style="background: none; border: 1px solid #ccc; border-radius: 50%; cursor: pointer; width: 30px; height: 30px;">&gt;</button>
            </div>
        </div>

        <div class="hotdeal-grid" style="display: grid; grid-template-columns: repeat(5, 1fr); gap: 15px;">
            <c:forEach var="h" items="${hotDealList}" varStatus="status">
                <c:if test="${status.index < 10}">
                    <div class="hotdeal-item" onclick="location.href='${path}/detail?id=${h.id}'" style="cursor: pointer; text-align: center;">
                        <div class="img-wrapper" style="width: 100%; padding-top: 100%; position: relative; background: #f9f9f9; border-radius: 8px; overflow: hidden; margin-bottom: 10px;">
                            <img src="${h.imageUrl}" alt="${h.title}" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); max-width: 90%; max-height: 90%;">
                        </div>
                        <p class="item-title" style="font-size: 0.85em; color: #333; margin: 0 0 5px; height: 3.2em; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; line-height: 1.6;">
                            <c:out value="${h.title}" />
                        </p>
                        <p class="item-price" style="font-weight: bold; font-size: 1em; color: #e74c3c;">
                            <fmt:formatNumber value="${h.price}" pattern="#,###"/>원
                        </p>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>

    <%-- 우측: 급락 순위 (슬림) --%>
    <div class="drop-rank-container" style="flex: 2.5; background: #fdfdfd; padding: 20px; border-radius: 12px; border: 1px solid #eee; position: sticky; top: 20px;">
        <h3 style="margin-bottom: 20px; border-bottom: 2px solid #ff4d4d; padding-bottom: 10px; text-align: center; color: #ff4d4d; margin-top: 0;">📉 급락 순위</h3>
        <ul class="rank-list" style="list-style: none; padding: 0; margin: 0; font-size: 0.9em;">
            <li style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 18px;">
                <span style="width: 25px; font-weight: bold; color: #ff4d4d; text-align: center;">1</span>
                <span class="item-name" style="flex: 1; margin: 0 10px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: #333;">NVIDIA RTX 5090</span>
                <span class="item-drop" style="color: #ff4d4d; font-weight: bold; min-width: 40px; text-align: right;">-21%</span>
            </li>
            <li style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 18px;">
                <span style="width: 25px; font-weight: bold; color: #ff4d4d; text-align: center;">2</span>
                <span class="item-name" style="flex: 1; margin: 0 10px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: #333;">iPhone 17 Pro</span>
                <span class="item-drop" style="color: #ff4d4d; font-weight: bold; min-width: 40px; text-align: right;">-15%</span>
            </li>
            <c:forEach var="i" begin="3" end="10">
                <li style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 18px;">
                    <span style="width: 25px; font-weight: bold; color: #666; text-align: center;">${i}</span>
                    <span class="item-name" style="flex: 1; margin: 0 10px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: #666;">테스트 상품명 ${i}</span>
                    <span class="item-drop" style="color: #666; font-weight: bold; min-width: 40px; text-align: right;">-8%</span>
                </li>
            </c:forEach>
        </ul>
        <div style="text-align: center; margin-top: 15px;">
            <button class="btn-start" style="padding: 10px 15px; background: #ff4d4d; border: none; color: white; border-radius: 5px; cursor: pointer; font-size: 0.9em; width: 100%;">지금 가격 추적 시작하기</button>
        </div>
    </div>
</section>

<%-- 실시간 최저가 갱신 티커 섹션 --%>
<section class="low-price-ticker-section" style="margin: 0 20px 40px 20px; background: #fff; padding: 20px; border-radius: 12px; border: 1px solid #eee;">
    <div style="display: flex; align-items: center; margin-bottom: 15px;">
        <h3 style="margin: 0; color: #2196f3; display: flex; align-items: center;">
            <span id="liveDot" style="display: inline-block; width: 10px; height: 10px; background: #2196f3; border-radius: 50%; margin-right: 10px;"></span>
            실시간 최저가 갱신 현황
        </h3>
    </div>
    <div class="ticker-container" style="height: 50px; overflow: hidden; background: #f8f9fa; border-radius: 8px; padding: 0 20px;">
        <ul id="tickerList" style="list-style: none; padding: 0; margin: 0;">
            <li style="height: 50px; display: flex; align-items: center; justify-content: space-between;">
                <span><strong>[신규 최저가]</strong> 소니 WH-1000XM5 — <span style="color: #e74c3c; font-weight: bold;">325,000원</span> (-12%)</span>
                <span style="color: #999; font-size: 0.85em;">방금 전</span>
            </li>
            <li style="height: 50px; display: flex; align-items: center; justify-content: space-between;">
                <span><strong>[가격 갱신]</strong> 삼성 갤럭시 S24 울트라 — <span style="color: #e74c3c; font-weight: bold;">1,180,000원</span></span>
                <span style="color: #999; font-size: 0.85em;">2분 전</span>
            </li>
            <li style="height: 50px; display: flex; align-items: center; justify-content: space-between;">
                <span><strong>[역대 최저]</strong> LG 그램 Pro 16인치 — <span style="color: #e74c3c; font-weight: bold;">1,540,000원</span></span>
                <span style="color: #999; font-size: 0.85em;">5분 전</span>
            </li>
        </ul>
    </div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function() {
    // 1. 라이브 도트 깜빡임 애니메이션
    setInterval(function() {
        $('#liveDot').fadeOut(500).fadeIn(500);
    }, 1000);

    // 2. 실시간 티커 롤링 기능
    var ticker = $('#tickerList');
    var tickerHeight = 50; 

    function moveTicker() {
        ticker.animate({ marginTop: -tickerHeight }, 600, function() {
            ticker.find('li:first').appendTo(ticker);
            ticker.css('margin-top', 0);
        });
    }

    var tickerInterval = setInterval(moveTicker, 3000);

    // 마우스 올리면 정지, 떼면 다시 시작
    $('.ticker-container').hover(function(){
        clearInterval(tickerInterval);
    }, function(){
        tickerInterval = setInterval(moveTicker, 3000);
    });
});
</script>

<%-- 푸터 불러오기 --%>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>