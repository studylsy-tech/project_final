<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%-- 외부 CSS 파일 연결 --%>
<link rel="stylesheet" href="${path}/resources/css/views/index.css">

<div class="main-content">
	<h2>가격 추적 플랫폼에 오신 것을 환영합니다!</h2>
<div class="search-ticker-wrapper">
		<form action="${path}/dashboard/search" method="get"
			style="flex: 6; display: flex; align-items: center;">
			<input type="text" name="query" placeholder="관심 상품 URL 또는 상품명 검색"
				required>
			<button type="submit">
				<i class="fas fa-search"></i> →
			</button>
		</form>

		<div class="v-line"></div>

		<div class="ticker-box">
			<ul id="mainTicker">
				<li><span class="live-tag">[LIVE]</span> 소니 WH-1000XM5 최저가
					₩325,000</li>
				<li><span class="live-tag">[LIVE]</span> 갤럭시 S24 울트라 가격 하락!</li>
				<li><span class="live-tag">[LIVE]</span> LG 그램 Pro 16 역대 최저가 경신</li>
			</ul>
		</div>
	</div>
</div>

<%-- 메인 핫딜 & 급락 섹션 --%>
<section class="main-top-integrated-section">
	<%-- 실시간 인기 핫딜 섹션 --%>
	<div class="hotdeal-grid-container">
		<h3 style="color: #2196f3; margin-top: 0;">✨ 실시간 인기 핫딜</h3>
		<div class="hotdeal-grid">
			<%-- analysis.jsp와 동일한 items 명칭인 hotDealList 사용 --%>
			<c:forEach var="deal" items="${hotDealList}" varStatus="status">
				<%-- 메인 페이지이므로 상위 10개만 깔끔하게 노출 --%>
				<c:if test="${status.index < 10}">
					<div class="hotdeal-item"
						onclick="location.href='${deal.originUrl}'"
						style="cursor: pointer;">
						<div class="img-wrapper">
							<c:choose>
								<c:when test="${not empty deal.imageUrl}">
									<img src="${deal.imageUrl}" alt="상품이미지"
										onerror="this.src='${path}/resources/images/no-image.png'">
								</c:when>
								<c:otherwise>
									<img src="${path}/resources/images/no-image.png" alt="이미지없음">
								</c:otherwise>
							</c:choose>
						</div>

						<%-- 제목 2줄 제한 --%>
						<p class="item-title">
							<c:out value="${deal.title}" />
						</p>
						<%-- 가격 강조 (파란색 유지) --%>
						<p class="item-price">
							<fmt:formatNumber value="${deal.currentPrice}" pattern="#,###" />
							원
							<%-- price를 currentPrice로 변경 --%>
						</p>

						<%-- 출처 소규모 표시 --%>
						<p
							style="font-size: 11px; color: #999; margin-top: 4px; text-align: center;">
							${deal.communityName}</p>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>

	<%-- 우측: 급락 순위 --%>
	<div class="drop-rank-container">
		<h3
			style="margin-bottom: 20px; border-bottom: 2px solid #2196f3; padding-bottom: 10px; text-align: center; color: #2196f3; margin-top: 0;">📉
			급락 순위</h3>
		<ul style="list-style: none; padding: 0; margin: 0;">
			<c:forEach var="i" begin="1" end="10">
				<li class="rank-list-item"><span class="rank-num">${i}</span> <span
					style="flex: 1; margin: 0 10px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">테스트
						상품명 ${i}</span> <span style="color: #ff4d4d; font-weight: bold;">-15%</span>
				</li>
			</c:forEach>
		</ul>
		<button class="start-btn"
			style="width: 100%; padding: 10px; background: #2196f3; color: white; border: none; border-radius: 5px; cursor: pointer; margin-top: 10px;">
			지금 가격 추적 시작하기</button>
	</div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function() {
		var ticker = $('#mainTicker');
		var tickerHeight = 40;

		function moveTicker() {
			ticker.animate({
				marginTop : -tickerHeight
			}, 600, function() {
				ticker.find('li:first').appendTo(ticker);
				ticker.css('margin-top', 0);
			});
		}
		setInterval(moveTicker, 3500);
	});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>