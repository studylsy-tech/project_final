<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>


<%-- 1. 데이터 소스 통합 로직 (타입별 필드명 고정) --%>
<c:choose>
    <c:when test="${not empty product}">
        <%-- 일반 상품(com.project.model.ProductDTO) 케이스 --%>
        <c:set var="title" value="${product.name}" />
        <c:set var="currP" value="${product.price}" />
        <c:set var="targP" value="${product.targetPrice}" />
        <c:set var="mall" value="${product.communityName}" />
        <c:set var="uDate" value="${product.regDate}" />
        <c:set var="link" value="${product.originUrl}" />
        <c:set var="isProduct" value="true" />
    </c:when>
    
    <c:when test="${not empty deal}">
        <%-- 핫딜 상품(com.project.model.HotDealDTO) 케이스 --%>
        <%-- HotDealDTO에는 title과 currentPrice 필드가 확실히 있으므로 이것만 사용 --%>
        <c:set var="title" value="${deal.title}" />
        <c:set var="currP" value="${deal.currentPrice}" />
        <c:set var="targP" value="0" /> 
        <c:set var="mall" value="${deal.mallName}" />
        <c:set var="uDate" value="${deal.lastUpdateDate}" />
        <c:set var="link" value="${deal.originUrl}" />
        <c:set var="isProduct" value="false" />
    </c:when>
    
    <c:otherwise>
        <%-- 예외 상황 처리 --%>
        <c:set var="title" value="데이터를 불러올 수 없습니다." />
        <c:set var="currP" value="0" />
        <c:set var="targP" value="0" />
    </c:otherwise>
</c:choose>

<link rel="stylesheet" href="${path}/resources/css/views/dashboard/history_detail.css">

<div class="detail-container" style="width:80%; max-width:1200px; margin:50px auto;">

    <%-- 상품 정보 섹션 --%>
    <div class="info-section">
        <h1 class="detail-title">
            <c:out value="${not empty title ? title : '상품 상세 정보'}" />
        </h1>

        <div class="price-container">
            <div class="price-box">
                <span class="price-label">현재가</span>
                <span class="price-value current-p">
                    ₩<fmt:formatNumber value="${currP}" pattern="#,###" />
                </span>
            </div>

            <div class="divider"></div>

            <div class="price-box">
                <span class="price-label">목표가</span>
                <span class="price-value target-p">
                    ₩<fmt:formatNumber value="${targP}" pattern="#,###" />
                </span>
            </div>
        </div>

        <div class="info-footer">
            <span>출처: ${mall}</span>
            <span class="separator">|</span>
            <span>최종 업데이트: 
    <c:choose>
        <c:when test="${not empty product}">
            <%-- 일반 상품은 Date 객체이므로 포맷팅 필요 --%>
            <fmt:formatDate value="${uDate}" pattern="yyyy.MM.dd HH:mm" />
        </c:when>
        <c:otherwise>
            <%-- 핫딜은 이미 String이면 바로 출력, Date면 포맷팅 추가 --%>
            ${uDate}
        </c:otherwise>
    </c:choose>
</span>
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
        <td>
            <c:choose>
                <c:when test="${isProduct == true}">
                    <%-- 일반 상품: DTO 필드명 혹은 Map의 키값에 맞춰 포맷팅 --%>
                    <fmt:formatDate value="${h.REGDATE}" pattern="yyyy-MM-dd HH:mm" />
                </c:when>
                <c:otherwise>
                    <%-- 핫딜 상품: 콘솔 확인 결과 키값이 [REG_DATE] 임 --%>
                    ${h.REG_DATE}
                </c:otherwise>
            </c:choose>
        </td>
        <td>
            <strong>₩<fmt:formatNumber value="${h.PRICE}" pattern="#,###" /></strong>
        </td>
        <td class="change-cell">-</td>
    </tr>
</c:forEach>
</tbody>
    </table>
</div>

    <div class="detail-footer">
        <div class="btn-group-left">
            <a href="javascript:history.back();" class="btn-detail btn-list">목록으로</a>
            <c:if test="${not empty link}">
                <a href="${link}" target="_blank" class="btn-detail btn-go">원문 바로가기</a>
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
                date: "${h.REGDATE}",
                price: ${h.PRICE != null ? h.PRICE : 0}
            });
        </c:forEach>

        const ctx = document.getElementById('priceChart').getContext('2d');
        
        // 데이터가 없을 경우 처리
        if (historyData.length === 0) {
            historyData.push({ date: '데이터 없음', price: 0 });
        }

        // 날짜와 가격 배열 생성 (최신순에서 과거순으로 오므로 reverse로 그래프 방향 정렬)
        const labels = historyData.map(item => item.date);
        const prices = historyData.map(item => item.price);
        
        // 목표가 변수 (상단 c:set에서 정의한 targP 사용)
        const targetPriceValue = ${not empty targP ? targP : 0};

        // 데이터셋 구성
        const datasets = [{
            label: '수집 가격 (₩)',
            data: prices,
            borderColor: '#26a69a',
            backgroundColor: 'rgba(38, 166, 154, 0.05)',
            borderWidth: 3,
            tension: 0.2,
            fill: true,
            pointRadius: 4,
            zIndex: 1
        }];

        // [핵심 추가] 목표가가 존재할 경우 (일반 상품) 가로 점선 데이터셋 추가
        if (targetPriceValue > 0) {
            datasets.push({
                label: '목표 가격 (₩)',
                // 모든 날짜 지점에 동일한 목표가 값을 채워 가로선 생성
                data: new Array(labels.length).fill(targetPriceValue),
                borderColor: '#e53935', // 붉은색 계열
                borderWidth: 2,
                borderDash: [5, 5], // 점선 효과 [선길이, 간격]
                pointRadius: 0, // 점은 안 보이게
                fill: false,
                zIndex: 0
            });
        }

        new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: datasets
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                interaction: {
                    mode: 'index',
                    intersect: false
                },
                scales: {
                    y: {
                        beginAtZero: false,
                        ticks: {
                            callback: function(value) { return '₩' + value.toLocaleString(); }
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    }
                }
            }
        });
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>