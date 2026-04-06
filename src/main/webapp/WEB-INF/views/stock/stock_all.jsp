<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${path}/resources/css/stock/stock_drop.css">

<%-- 현재 접속 경로 저장 --%>
<c:set var="currentUri" value="${requestScope['javax.servlet.forward.request_uri']}" />

<div class="board-wrapper">
    <h2>${boardTitle}</h2>

    <%-- 1. 통합 검색 영역 --%>
    <div style="margin-bottom: 20px; text-align: right;">
        <form action="${currentUri}" method="get" id="searchForm">
            <select name="searchType" style="padding: 5px;">
                <option value="name" ${pageMaker.criteria.searchType eq 'name' ? 'selected' : ''}>상품명</option>
                <option value="drop" ${pageMaker.criteria.searchType eq 'drop' ? 'selected' : ''}>급락상품</option>
                <option value="low" ${pageMaker.criteria.searchType eq 'low' ? 'selected' : ''}>최저가</option>
            </select>
            <input type="text" name="keyword" id="keywordInput" value="${pageMaker.criteria.keyword}" style="padding: 5px; width: 200px;">
            <button type="submit" id="searchBtn" style="padding: 5px 15px;">검색</button>
        </form>
    </div>

    <%-- 2. 상품 리스트 영역 --%>
    <div class="stock-list-container">
        <c:choose>
            <c:when test="${empty stockList}">
                <div style="text-align: center; padding: 50px; color: #999;">조회된 데이터가 없습니다.</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="s" items="${stockList}">
                    <%-- 상세 페이지 URL 분기 처리 --%>
                    <c:url var="detailUrl" value="${s.boardType eq 'HOT' ? '/hotdeal/detail' : '/dashboard/detail'}">
                        <c:param name="${s.boardType eq 'HOT' ? 'dealId' : 'prodId'}" value="${s.prodId}" />
                    </c:url>

                    <div class="stock-card" onclick="location.href='${detailUrl}'" 
                         style="display: flex; align-items: center; padding: 15px; border-bottom: 1px solid #eee; cursor: pointer;">
                        
                        <%-- 이미지 영역 --%>
                        <div class="prod-img-wrapper" style="margin-right: 20px; flex-shrink: 0;">
                            <img src="${not empty s.imageUrl ? s.imageUrl : path.concat('/resources/images/no-image.png')}" 
                                 alt="${s.name}" class="prod-img"
                                 style="width:100px; height:100px; object-fit:cover; border-radius: 8px;"
                                 onerror="this.src='${path}/resources/images/no-image.png';">
                        </div>

                        <%-- 정보 영역 --%>
                        <div class="prod-info-wrapper">
   					 <div class="prod-title-row">
      					  <c:set var="badgeClass" value="${s.boardType eq 'DROP' ? 'bg-red' : (s.boardType eq 'HOT' ? 'bg-orange' : 'bg-green')}" />
       					 <c:set var="badgeText" value="${s.boardType eq 'DROP' ? '급락' : (s.boardType eq 'HOT' ? '핫딜' : '최저가')}" />
       					 <span class="badge ${badgeClass}">${badgeText}</span>
       					 <span class="prod-main-text">
         				   ${s.name} &mdash;
         				   <span class="price-highlight">&#8361;<fmt:formatNumber value="${s.price}" pattern="#,###" /></span>
       					 </span>
   					 </div>
   						 <div class="prod-sub-text">
       					 <fmt:formatDate value="${s.regDate}" pattern="yyyy.MM.dd HH:mm" /> | ${s.source}
   						 </div>
						</div>
					</div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- 3. 페이징 처리 영역 --%>
    <div style="text-align: center; margin: 30px 0; font-size: 16px;">
        <c:if test="${pageMaker.prev}">
            <a href="${currentUri}${pageMaker.makeSearch(pageMaker.startPage - 1)}" style="text-decoration:none; color:#333;">[이전]</a>
        </c:if>

        <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            <a href="${currentUri}${pageMaker.makeSearch(idx)}" style="text-decoration:none; margin: 0 5px;">
                <c:choose>
                    <c:when test="${pageMaker.criteria.page == idx}">
                        <span style="color: red; font-weight: bold; border-bottom: 2px solid red; padding-bottom: 2px;">${idx}</span>
                    </c:when>
                    <c:otherwise>
                        <span style="color: #666;">${idx}</span>
                    </c:otherwise>
                </c:choose>
            </a>
        </c:forEach>

        <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
            <a href="${currentUri}${pageMaker.makeSearch(pageMaker.endPage + 1)}" style="text-decoration:none; color:#333;">[다음]</a>
        </c:if>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(function() {
        $('#searchBtn').on("click", function(event) {
            event.preventDefault();
            const uri = "${currentUri}";
            const keyword = $('#keywordInput').val();
            const searchType = $("select[name='searchType']").val();
            
            // 검색 시 1페이지로 리셋하여 이동
            location.href = uri + "?page=1" 
                          + "&perPageNum=${pageMaker.criteria.perPageNum}"
                          + "&searchType=" + searchType
                          + "&keyword=" + encodeURIComponent(keyword);
        });