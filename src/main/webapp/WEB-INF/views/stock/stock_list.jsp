<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%-- 절대 경로 대신 ${path}와 파일의 실제 물리 경로를 맞춥니다 --%>
<link rel="stylesheet" href="${path}/resources/css/stock/stock_list.css">
<div class="board-wrapper">
    <h2>${boardTitle}</h2>
    
    <div class="stock-list-container">
        <c:choose>
            <c:when test="${empty stockList}">
                <div style="text-align:center; padding:50px; color:#999;">
                    조회된 데이터가 없습니다.
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="s" items="${stockList}">
                    <div class="stock-card" onclick="location.href='${path}/dashboard/detail?prodId=${s.prodId}'">
                        <div class="badge ${boardTitle eq '오늘의 급락 상품' ? 'bg-red' : 'bg-blue'}">
                            ${boardTitle eq '오늘의 급락 상품' ? '급락' : '갱신'}
                        </div>
                        
                        <div class="prod-info">
                            <div class="prod-main-text">
                                ${s.name} — <span class="price-highlight">현재 최저가 ₩<fmt:formatNumber value="${s.price}" pattern="#,###"/></span>
                            </div>
                            <div class="prod-sub-text">
                                <fmt:formatDate value="${s.regDate}" pattern="yyyy.MM.dd HH:mm"/> | 조회수 123
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>