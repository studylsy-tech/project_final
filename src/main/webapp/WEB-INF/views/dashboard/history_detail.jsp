<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
 
<%@ include file="/WEB-INF/views/common/header.jsp"%>
 
<link rel="stylesheet" href="${path}/resources/css/views/dashboard/history_detail.css">
 
<%-- [수정] detail-container에 style로 width 80% 강제 적용 (헤더CSS 충돌 방지) --%>
<div class="detail-container" style="width:80%; max-width:1200px; margin:50px auto;">
 
    <%-- 상품 정보 섹션 --%>
    <div class="info-section">
        <%-- [수정] 제목 표시 확인용 - 데이터 없으면 기본 텍스트 --%>
        <h1 class="detail-title">
            <c:choose>
                <c:when test="${not empty hotDeal.title}">${hotDeal.title}</c:when>
                <c:otherwise>상품 상세 정보</c:otherwise>
            </c:choose>
        </h1>
 
        <div class="price-container">
            <div class="price-box">
                <span class="price-label">현재가</span>
                <span class="price-value current-p">
                    ₩<fmt:formatNumber value="${hotDeal.currentPrice}" pattern="#,###" />
                </span>
            </div>
 
            <div class="divider"></div>
 
            <div class="price-box">
                <span class="price-label">목표가(시작가)</span>
                <span class="price-value target-p">
                    ₩<fmt:formatNumber value="${hotDeal.startPrice}" pattern="#,###" />
                </span>
            </div>
        </div>
 
        <div class="info-footer">
            <span>출처: ${hotDeal.mallName}</span>
            <span class="separator">|</span>
            <span>최종 업데이트: ${hotDeal.lastUpdateDate}</span>
        </div>
    </div>
 
    <%-- 차트 섹션 --%>
    <div class="chart-section">
        <h3 class="section-title">가격 변동 추이</h3>
        <div class="chart-wrapper">
            <canvas id="priceChart"></canvas>
        </div>
    </div>
 
    <%-- 테이블 섹션 --%>
    <%-- [수정] info-section + table-wrapper 클래스 통합, table border="1" 제거 --%>
    <div class="info-section table-wrapper">
        <h3 class="section-title">상세 가격 이력</h3>
        <table class="table-section">
            <thead>
                <tr>
                    <th>수집 날짜</th>
                    <th>가격</th>
                    <th>비고</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="h" items="${history}">
                    <tr>
                        <td>${h.REG_DATE}</td>
                        <td><strong>₩<fmt:formatNumber value="${h.PRICE}" pattern="#,###" /></strong></td>
                        <td class="change-cell">-</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty history}">
                    <tr>
                        <td colspan="3" style="text-align:center; padding:40px; color:#999;">
                            수집된 가격 데이터가 없습니다.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
 
</div>
 
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const historyData = [];
        <c:forEach var="h" items="${history}">
            historyData.push({
                date: "${h.REG_DATE}",
                price: ${h.PRICE != null ? h.PRICE : 0}
            });
        </c:forEach>
 
        const ctx = document.getElementById('priceChart').getContext('2d');
 
        if (historyData.length === 0) {
            historyData.push({ date: '데이터 없음', price: 0 });
        }
 
        const labels = historyData.map(item => item.date);
        const prices = historyData.map(item => item.price);
 
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: '수집 가격 (₩)',
                    data: prices,
                    borderColor: '#26a69a',
                    backgroundColor: 'rgba(38, 166, 154, 0.05)',
                    borderWidth: 3,
                    pointBackgroundColor: '#fff',
                    pointBorderColor: '#26a69a',
                    pointRadius: 4,
                    pointHoverRadius: 6,
                    tension: 0.2,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: {
                        beginAtZero: false,
                        grid: { color: '#f0f0f0' },
                        ticks: {
                            callback: function(value) {
                                return '₩' + value.toLocaleString();
                            }
                        }
                    },
                    x: { grid: { display: false } }
                }
            }
        });
    });
</script>
 
<%@ include file="/WEB-INF/views/common/footer.jsp"%>