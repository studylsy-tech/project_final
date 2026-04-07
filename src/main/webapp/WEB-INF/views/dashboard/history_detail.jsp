<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${path}/resources/css/views/dashboard/history_detail.css">

<div class="detail-container" style="width:80%; max-width:1200px; margin:50px auto;">

    <%-- 상품 정보 섹션 --%>
    <div class="info-section">
        <h1 class="detail-title">
            <c:choose>
                <%-- hotDeal -> deal 로 변경 --%>
                <c:when test="${not empty deal.title}">${deal.title}</c:when>
                <c:otherwise>상품 상세 정보</c:otherwise>
            </c:choose>
        </h1>

        <div class="price-container">
            <div class="price-box">
                <span class="price-label">현재가</span>
                <span class="price-value current-p">
                    ₩<fmt:formatNumber value="${deal.currentPrice}" pattern="#,###" />
                </span>
            </div>

            <div class="divider"></div>

            <div class="price-box">
                <span class="price-label">목표가(시작가)</span>
                <span class="price-value target-p">
                    ₩<fmt:formatNumber value="${deal.startPrice}" pattern="#,###" />
                </span>
            </div>
        </div>

        <div class="info-footer">
            <span>출처: ${deal.mallName}</span>
            <span class="separator">|</span>
            <span>최종 업데이트: ${deal.lastUpdateDate}</span>
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
                        <%-- DB 컬럼명이 대문자라면 그대로 유지, DTO 필드명이라면 소문자로 수정 필요 --%>
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

    <div class="detail-footer">
        <div class="btn-group-left">
            <a href="${path}/stock/analysis" class="btn-detail btn-list">목록으로</a>
            <c:if test="${not empty deal.originUrl}">
                <a href="${deal.originUrl}" target="_blank" class="btn-detail btn-go">원문 바로가기</a>
            </c:if>
        </div>
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
                    tension: 0.2,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: false,
                        ticks: {
                            callback: function(value) { return '₩' + value.toLocaleString(); }
                        }
                    }
                }
            }
        });
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>