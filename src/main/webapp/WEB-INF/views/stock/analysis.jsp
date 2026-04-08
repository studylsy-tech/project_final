<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%-- 통합된 공통 스톡 CSS 적용 --%>
<link rel="stylesheet" href="${path}/resources/css/stock/stock_common.css">

<div class="board-wrapper">
    <h2>실시간 핫딜 자동분석</h2>

    <%-- 1. 통합 검색 영역 --%>
    <div class="search-area">
        <select id="searchType">
            <option value="title" ${scri.searchType eq 'title' ? 'selected' : ''}>제목</option>
            <option value="url" ${scri.searchType eq 'url' ? 'selected' : ''}>URL</option>
            <option value="content" ${scri.searchType eq 'content' ? 'selected' : ''}>내용</option>
        </select>
        <input type="text" id="keywordInput" 
               value="${scri.keyword}" 
               placeholder="검색어를 입력하세요">
        <button type="button" id="searchBtn">검색</button>
    </div>

    <%-- 2. 분석 리스트 영역: 카드 구조로 변경 --%>
    <div class="stock-list-container">
        <c:choose>
            <c:when test="${empty hotDealList}">
                <div class="empty-msg">분석된 핫딜 데이터가 없습니다.</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="hotdeal" items="${hotDealList}">
                    <div class="stock-card" data-deal-id="${hotdeal.dealId}">
    <%-- 이미지 영역 --%>
    <div class="prod-img-wrapper">
        <c:choose>
            <c:when test="${not empty hotdeal.imageUrl}">
                <img src="${hotdeal.imageUrl}" alt="상품이미지" onerror="this.src='${path}/resources/images/no-image.png'">
            </c:when>
            <c:otherwise>
                <img src="${path}/resources/images/no-image.png" alt="이미지없음">
            </c:otherwise>
        </c:choose>
    </div>

    <%-- 정보 영역 --%>
    <div class="prod-info-wrapper">
        <div class="prod-title-row">
            <span class="badge bg-orange">핫딜</span>
            <span class="prod-main-text">
                <c:out value="${hotdeal.title}" /> — 
                <span class="price-highlight"><fmt:formatNumber value="${hotdeal.currentPrice}" pattern="#,###" />원</span>
            </span>
        </div>
        <div class="prod-sub-text">
            출처: ${hotdeal.communityName} | 
            <%-- 원문보기는 별도의 a 태그나 클래스로 분리 --%>
            <span class="view-origin" data-url="${hotdeal.originUrl}" style="cursor:pointer; color:blue; text-decoration:underline;">
                원문보기(클릭)
            </span>
        </div>
    </div>
</div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- 3. 페이징 처리 영역: paging-area 클래스로 통일 --%>
    <div class="paging-area">
        <c:if test="${pageMaker.prev}">
            <a href="${path}/stock/analysis${pageMaker.makeSearch(pageMaker.startPage - 1)}">[이전]</a>
        </c:if>

        <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            <a href="${path}/stock/analysis${pageMaker.makeSearch(idx)}">
                <c:choose>
                    <c:when test="${pageMaker.criteria.page == idx}">
                        <span class="current-page">${idx}</span>
                    </c:when>
                    <c:otherwise>
                        <span>${idx}</span>
                    </c:otherwise>
                </c:choose>
            </a>
        </c:forEach>

        <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
            <a href="${path}/stock/analysis${pageMaker.makeSearch(pageMaker.endPage + 1)}">[다음]</a>
        </c:if>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function() {
    // 1. 카드 클릭 시 (상세보기로 이동)
    $('.stock-card').on("click", function() {
        // 이전에 data-deal-id="${hotdeal.dealId}"로 수정하셨죠? 그 값을 가져옵니다.
        var dId = $(this).data('deal-id'); 
        
        if(dId) {
            // 요청하신 주소 형식으로 변경: /hotdeal/detail?dealId=숫자
            location.href = "${path}/hotdeal/detail?dealId=" + dId;
        }
    });

    // 2. 원문보기 클릭 시 (이건 그대로 유지)
    $('.view-origin').on("click", function(event) {
        event.stopPropagation(); 
        var originUrl = $(this).data('url');
        if(originUrl) {
            window.open(originUrl, '_blank');
        }
    });

    // --- 검색 관련 함수들 ---
    function executeSearch() {
        var keyword = $('#keywordInput').val().trim();
        var searchType = $("#searchType option:selected").val();

        var url = "${path}/stock/analysis"
                + "?page=1"
                + "&perPageNum=${pageMaker.criteria.perPageNum}"
                + "&searchType=" + searchType
                + "&keyword=" + encodeURIComponent(keyword);
        
        location.href = url;
    }

    $('#searchBtn').on("click", function(event) {
        event.preventDefault();
        executeSearch();
    });

    $('#keywordInput').on("keydown", function(event) {
        if (event.keyCode === 13) {
            event.preventDefault();
            executeSearch();
        }
    });
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>