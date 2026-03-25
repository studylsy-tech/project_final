<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 공통 헤더 포함 --%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<style>
    .detail-container { max-width: 1000px; margin: 50px auto; padding: 20px; font-family: 'Pretendard', sans-serif; }
    .info-section { border: 1px solid #e1e4e8; padding: 20px; border-radius: 8px; margin-bottom: 30px; background-color: #f8f9fa; }
    .info-section h2 { margin: 0 0 10px 0; color: #1a2a44; font-size: 20px; }
    .price-summary { color: #666; font-size: 14px; }
    .chart-section { border: 1px solid #e1e4e8; padding: 20px; border-radius: 8px; margin-bottom: 30px; height: 450px; }
    .table-section { width: 100%; border-collapse: collapse; margin-top: 20px; }
    .table-section th, .table-section td { border-bottom: 1px solid #eee; padding: 15px; text-align: left; }
    .table-section th { background-color: #fcfcfc; color: #333; }
    .price-up { color: #e74c3c; font-weight: bold; }
    .price-down { color: #4a90e2; font-weight: bold; }
</style>

<div class="detail-container">
    <%-- ① 상단 상품 정보 요약 --%>
    <div class="info-section">
        <h2>① ${product.name} | 현재가: ₩<fmt:formatNumber value="${product.price}" pattern="#,###"/> | 목표가: ₩<fmt:formatNumber value="${product.targetPrice}" pattern="#,###"/></h2>
        <div class="price-summary">
            최저가: ₩2,050,000 (2025.12.15) | 최고가: ₩2,690,000 (2025.08.01)
        </div>
    </div>

    <%-- ② 가격 변동 타임라인 (그래프) --%>
    <div class="chart-section">
        <h3>② 가격 변동 타임라인 (라인 차트)</h3>
        <canvas id="priceChart"></canvas>
    </div>

    <%-- ③ 가격 이력 테이블 --%>
    <div class="info-section" style="background: white;">
        <h3>③ 가격 이력 테이블</h3>
        <table class="table-section">
            <thead>
                <tr>
                    <th>날짜</th>
                    <th>가격</th>
                    <th>변동</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="h" items="${history}">
                    <tr>
                        <td>${h.REG_DATE}</td>
                        <td><strong>₩<fmt:formatNumber value="${h.PRICE}" pattern="#,###"/></strong></td>
                        <td>- 0.0%</td> <%-- 변동률 로직은 추후 추가 가능 --%>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<%-- Chart.js 라이브러리 로드 --%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    const ctx = document.getElementById('priceChart').getContext('2d');
    
    // JSP에서 넘겨받은 history 데이터를 JS 배열로 변환
    const labels = [];
    const prices = [];
    
    <c:forEach var="h" items="${history}">
        labels.push('${h.REG_DATE}');
        prices.push(${h.PRICE});
    </c:forEach>

    const targetPrice = ${product.targetPrice};

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: '수집 가격',
                data: prices,
                borderColor: '#26a69a', // 와이어프레임의 초록색 계열
                backgroundColor: 'rgba(38, 166, 154, 0.1)',
                borderWidth: 3,
                pointRadius: 4,
                tension: 0.3,
                fill: true
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: false,
                    grid: { color: '#f0f0f0' }
                }
            },
            plugins: {
                // 목표가 점선 표시를 위해 annotation 플러그인을 사용할 수 있으나, 
                // 기본 기능을 위해 범례 설정을 추가함
                legend: { display: false }
            }
        }
    });
</script>

<%-- 공통 푸터 포함 --%>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>