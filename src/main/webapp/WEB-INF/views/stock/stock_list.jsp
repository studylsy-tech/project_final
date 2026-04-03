<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${path}/resources/css/stock/stock_list.css">

<div class="board-wrapper">
    <h2>${boardTitle}</h2>

    <%-- 검색 영역 --%>
    <div style="margin-bottom: 20px; text-align: right;">
	    <%-- onsubmit을 막아서 중복 전송 방지 --%>
	    <form action="${path}/stock/list" method="get" onsubmit="return false;">
	        <select id="searchTypeSelect" name="searchType" style="padding: 5px;">
	            <option value="name" ${pageMaker.criteria.searchType eq 'name' ? 'selected' : ''}>상품명</option>
	            <option value="drop" ${pageMaker.criteria.searchType eq 'drop' ? 'selected' : ''}>급락상품</option>
	            <option value="low" ${pageMaker.criteria.searchType eq 'low' ? 'selected' : ''}>최저가</option>
	        </select>
	        <%-- id="keywordInput" 추가 --%>
	        <input type="text" id="keywordInput" name="keyword" value="${pageMaker.criteria.keyword}" style="padding: 5px; width: 200px;">
	        <%-- id="searchBtn" 추가 --%>
	        <button type="button" id="searchBtn" style="padding: 5px 15px;">검색</button>
	    </form>
	</div>

    <div class="stock-list-container">
        <c:choose>
            <c:when test="${empty stockList}">
                <div style="text-align: center; padding: 50px; color: #999;">조회된 데이터가 없습니다.</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="s" items="${stockList}">
                    <div class="stock-card" onclick="location.href='${path}/dashboard/detail?prodId=${s.prodId}'" 
                         style="display: flex; align-items: center; padding: 15px; border-bottom: 1px solid #eee; cursor: pointer;">
                        
                        <%-- 이미지 처리 영역 --%>
                        <div class="prod-img-wrapper" style="margin-right: 20px;">
                            <img src="${not empty s.imageUrl ? s.imageUrl : path.concat('/resources/images/no-image.png')}" 
                                 alt="${s.name}" 
                                 style="width:100px; height:100px; object-fit:cover; border-radius: 8px;"
                                 onerror="this.onerror=null; this.src='${path}/resources/images/no-image.png';">
                        </div>

                        <div class="prod-info-wrapper">
                            <%-- 급락/최저가 배지 구분 --%>
                            <c:set var="badgeClass" value="${s.boardType eq 'DROP' ? 'bg-red' : 'bg-blue'}" />
                            <c:set var="badgeText" value="${s.boardType eq 'DROP' ? '급락' : '최저가'}" />
                            <div class="badge ${badgeClass}">${badgeText}</div>

                            <div class="prod-info" style="margin-top: 8px;">
                                <div class="prod-main-text" style="font-weight: bold; font-size: 1.1em;">
                                    ${s.name} — <span class="price-highlight" style="color: #e74c3c;">₩<fmt:formatNumber value="${s.price}" pattern="#,###" /></span>
                                </div>
                                <div class="prod-sub-text" style="color: #888; font-size: 0.9em; margin-top: 4px;">
                                    <fmt:formatDate value="${s.regDate}" pattern="yyyy.MM.dd HH:mm" /> | ${s.source}
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

<%-- 페이징 처리 영역 --%>
<div style="text-align: center; margin: 30px 0; font-size: 16px;">
    <c:if test="${pageMaker.prev}">
        <a href="list${pageMaker.query(pageMaker.startPage - 1)}" style="text-decoration:none; color:#333;">[이전]</a>
    </c:if>

    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
        <a href="list${pageMaker.query(idx)}" style="text-decoration:none; margin: 0 5px;">
            <c:choose>
                <c:when test="${pageMaker.criteria.page == idx}">
                    <span style="color: red; font-weight: bold;">${idx}</span>
                </c:when>
                <c:otherwise>
                    <span style="color: #666;">${idx}</span>
                </c:otherwise>
            </c:choose>
        </a>
    </c:forEach>

    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
        <a href="list${pageMaker.query(pageMaker.endPage + 1)}" style="text-decoration:none; color:#333;">[다음]</a>
    </c:if>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(function() {
        $('#searchBtn').on("click", function(event) {
            // 선택한 검색 타입과 키워드 가져오기
            var sType = $("#searchTypeSelect").val();
            var sKeyword = $('#keywordInput').val();
            
            // self.location을 통해 정확한 파라미터 구성
            self.location = "${path}/search/list"
                + "?page=1" // 검색 시 무조건 1페이지로 이동
                + "&perPageNum=${pageMaker.criteria.perPageNum}"
                + "&searchType=" + $("#searchTypeSelect").val()
                + "&keyword=" + encodeURIComponent($('#keywordInput').val());
        });

        // 엔터키 지원 (입력창에서 엔터 눌러도 검색되게)
        $("#keywordInput").on("keypress", function(e) {
            if (e.keyCode == 13) {
                $('#searchBtn').click();
            }
        });
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>