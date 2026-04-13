<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%-- 외부 CSS 파일 연결 --%>
<link rel="stylesheet" href="${path}/resources/css/views/index.css">

<div class="main-content">
	<h2>득템 헌터에 오신 것을 환영합니다!</h2>
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
        <c:forEach var="low" items="${lowestList}">
            <%-- 로그 확인 결과: 모두 소문자(id, type, title, price)로 들어옴 --%>
            <c:set var="lowId" value="${low.id}" />
            <c:set var="lowType" value="${low.type}" />
            <c:set var="lowTitle" value="${low.title}" />
            <c:set var="lowPrice" value="${low.price}" />

            <%-- [핵심 수정] lowType이 소문자 'HOT'인지 체크하도록 수정 --%>
            <li onclick="location.href='${path}/dashboard/detail?${lowType == 'HOT' ? 'dealId' : 'prodId'}=${lowId}'" 
                style="cursor: pointer;">
                <span class="live-tag">[최저가경신]</span> 
                <c:out value="${lowTitle}" /> - 
                <span style="color: #e74c3c; font-weight: bold;">
                    역대 최저가 ₩<fmt:formatNumber value="${lowPrice}" pattern="#,###" />
                </span>
            </li>
        </c:forEach>
    </ul>
</div>
	</div>
</div>

<%-- 메인 핫딜 & 급락 섹션 --%>
<section class="main-top-integrated-section">

	<%-- 헤더 행: 제목 2칸 나란히 --%>
	<div class="section-header-row">
		<div class="hotdeal-header">
			<h3>✨✨  실시간 인기 핫딜  ✨✨</h3>
		</div>
		<div class="drop-rank-header">
			
			<h3>📉 급락순위</h3>
		</div>
	</div>

	<%-- 바디 행: 내용 2칸 나란히 (높이 동일) --%>
	<div class="section-body-row">

		<%-- 좌측: 핫딜 상품 그리드 --%>
		<div class="hotdeal-body">
			<div class="hotdeal-grid">
				<c:forEach var="deal" items="${hotDealList}" varStatus="status">
					<c:if test="${status.index < 10}">
						<div class="hotdeal-item"
							onclick="location.href='${path}/dashboard/detail?dealId=${deal.dealId}'"
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
							<p class="item-title">
								<c:out value="${deal.title}" />
							</p>
							<p class="item-price">
								<fmt:formatNumber value="${deal.currentPrice}" pattern="#,###" />원
							</p>
							<p style="font-size: 11px; color: #999; margin-top: 4px; text-align: center;">
								${deal.communityName}
							</p>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>

		<%-- 우측: 급락순위 리스트 (index.jsp 소스 중간쯤) --%>
<div class="drop-rank-list">
    <c:forEach var="drop" items="${dropList}" varStatus="status">
        <%-- 1. ID 값 추출 (대문자 ID 또는 소문자 id 중 존재하는 것 선택) --%>
        <c:set var="targetId" value="${not empty drop.ID ? drop.ID : drop.id}" />
        
        <%-- 2. TYPE 값 추출 (대문자 TYPE 또는 소문자 type) --%>
        <c:set var="targetType" value="${not empty drop.TYPE ? drop.TYPE : drop.type}" />
        
        <%-- 3. 나머지 필드도 동일하게 처리 --%>
        <c:set var="targetTitle" value="${not empty drop.TITLE ? drop.TITLE : drop.title}" />
        <c:set var="targetDropRate" value="${not empty drop.DROPRATE ? drop.DROPRATE : (not empty drop.dropRate ? drop.dropRate : 0)}" />

        <div class="rank-list-item" 
             onclick="location.href='${path}/dashboard/detail?${targetType == 'HOT' ? 'dealId' : 'prodId'}=${targetId}'"
             style="cursor:pointer;">
            
            <span class="rank-num">${status.count}</span>
            <span class="rank-name"><c:out value="${targetTitle}" /></span>
            <span class="rank-drop">${targetDropRate}% ↓</span>
            
        </div>
    </c:forEach>
    
    <c:if test="${empty dropList}">
        <div style="padding: 20px; text-align: center; color: #999;">급락 상품 데이터가 없습니다.</div>
    </c:if>
</div>

	</div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
const labels = [];
const prices = [];

<c:forEach var="h" items="${history}">
    labels.push('${h.REG_DATE}');
    prices.push(${h.PRICE != null ? h.PRICE : 0});
</c:forEach>

if (labels.length === 0) {
    labels.push('데이터 없음');
    prices.push(0);
}

const targetPrice = ${product.targetPrice != null ? product.targetPrice : 0};

const ctx = document.getElementById('priceChart') ? document.getElementById('priceChart').getContext('2d') : null;
if (ctx) {
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: '수집 가격',
                data: prices,
                borderColor: '#26a69a',
                backgroundColor: 'rgba(38, 166, 154, 0.1)',
                borderWidth: 3,
                fill: true
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false
        }
    });
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
