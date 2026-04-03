<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%-- 외부 CSS 참조 --%>
<link rel="stylesheet" href="${path}/resources/css/views/dashboard/history_detail.css">

<div class="detail-container">
    <div class="info-section">
        <h1 class="detail-title">${hotDeal.title}</h1>
        
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

    <div class="chart-section">
        <h3 class="section-title">가격 변동 추이</h3>
        <div class="chart-wrapper">
            <canvas id="priceChart"></canvas>
        </div>
    </div>

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
                        <td colspan="3" style="text-align: center; padding: 40px; color: #999;">수집된 가격 데이터가 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 데이터 파싱
        const historyData = [];
        <c:forEach var="h" items="${history}">
            historyData.push({
                date: "${h.REG_DATE}",
                price: ${h.PRICE != null ? h.PRICE : 0}
            });
        </c:forEach>

        // 차트 렌더링 로직
        const ctx = document.getElementById('priceChart').getContext('2d');
        
        // 데이터 부재 시 처리
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
                    tension: 0.2, // 선을 약간 부드럽게
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false } // 레이블 중복 제거
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

<%@ include file="/WEB-INF/views/common/footer.jsp" %>