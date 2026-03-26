<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%-- 전용 CSS 링크 --%>
<link rel="stylesheet" href="${path}/resources/css/views/stock/stock_list.css">

<div class="board-wrapper">
    <h2>${boardTitle}</h2>
    
    <div class="stock-grid">
        <c:choose>
            <c:when test="${empty stockList}">
                <%-- 데이터가 없을 때 --%>
                <div class="no-data">
                    <i class="fas fa-exclamation-circle fa-2x"></i>
                    <p>현재 조회 가능한 상품 데이터가 없습니다.</p>
                </div>
            </c:when>
            <c:otherwise>
                <%-- 데이터가 있을 때 반복문 --%>
                <c:forEach var="s" items="${stockList}">
                    <%-- 카드 전체에 상세페이지 링크 걸기 --%>
                    <div class="stock-card" onclick="location.href='${path}/dashboard/detail?prodId=${s.prodId}'">
                        
                        <div class="card-header">
                            <span class="prod-code">${s.prodCode}</span>
                            <%-- 조건별 배지 표시 --%>
                            <c:choose>
                                <c:when test="${boardTitle eq '오늘의 급락 상품'}">
                                    <span class="badge bg-red">DOWN</span>
                                </c:when>
                                <c:when test="${boardTitle eq '최저가 갱신'}">
                                    <span class="badge bg-blue">NEW LOW</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-blue">STOCK</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <div class="prod-name">
                            ${s.name}
                        </div>
                        
                        <div class="card-footer">
                            <div>
                                <div class="price-label">현재 최저가</div>
                                <div class="price-value">
                                    ₩<fmt:formatNumber value="${s.price}" pattern="#,###"/>
                                </div>
                            </div>
                            <%-- 필요시 우측 하단에 미니 차트 아이콘 등을 넣을 수 있음 --%>
                            <i class="fas fa-chart-line" style="color: #333;"></i>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>