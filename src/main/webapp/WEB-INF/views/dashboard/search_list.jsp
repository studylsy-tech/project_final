<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/dashboard/search_list.css">

<div class="board-wrapper">
    <h2>
        
        검색 결과 목록
    </h2>
    
    <c:choose>
        <%-- 1. 검색 결과가 없을 때 --%>
        <c:when test="${empty searchResults}">
            <div class="empty-msg">
                <h3 class="no-result-title">찾으시는 상품이 없습니다.</h3>
                <p>입력하신 단어의 철자를 확인하거나 더 일반적인 키워드를 사용해 보세요.</p>
                <div style="margin-top:20px;">
                    <a href="${path}/index.jsp" class="tracking-btn" style="text-decoration:none;">메인으로 돌아가기</a>
                </div>
            </div>
        </c:when>

        <%-- 2. 검색 결과가 있을 때 --%>
        <c:otherwise>
            <div class="stock-list-container">
                <c:forEach var="item" items="${searchResults}">
                    <%-- 클릭 시 상세 페이지 이동을 원하면 onclick 추가 가능 --%>
                    <div class="stock-card">
                        <div class="prod-img-wrapper">
                            <img src="${item.imageUrl}" onerror="this.src='https://via.placeholder.com/90?text=No+Image'" alt="상품이미지">
                        </div>

                        <div class="prod-info-wrapper">
                            <div class="prod-title-row">
                                <span class="badge bg-blue">최저가</span>
                                <strong class="prod-main-text">${item.name}</strong>
                            </div>
                            <div class="prod-sub-text">
                                현재 가격: <span class="price-highlight">${item.price}원</span>
                            </div>
                            
                            <form action="${path}/dashboard/addForm" method="post" style="margin:0;">
                                <input type="hidden" name="prodCode" value="${item.prodCode}">
                                <input type="hidden" name="name" value="${item.name}">
                                <input type="hidden" name="price" value="${item.price}">
                                <input type="hidden" name="imageUrl" value="${item.imageUrl}">
                                <button type="submit" class="tracking-btn">이 상품 추적하기</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>