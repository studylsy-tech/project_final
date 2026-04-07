<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/css/views/board/notice_list.css">

<div class="board-wrapper">
    <%-- 상단 타이틀 --%>
    <div class="board-title-area">
        <h2>공지사항</h2>
        <p>플랫폼의 새로운 소식을 전해드립니다.</p>
    </div>

    <%-- 검색 영역 --%>
    <div class="search-area" style="margin-bottom: 20px; text-align: right;">
        <select id="searchType" class="search-select">
            <option value="t" ${pageMaker.cri.searchType eq 't' ? 'selected' : ''}>제목</option>
            <option value="c" ${pageMaker.cri.searchType eq 'c' ? 'selected' : ''}>내용</option>
            <option value="tc" ${pageMaker.cri.searchType eq 'tc' ? 'selected' : ''}>제목+내용</option>
        </select>
        <input type="text" id="keywordInput" value="${pageMaker.cri.keyword}" 
               class="search-input" placeholder="검색어를 입력하세요">
        <button type="button" id="searchBtn" class="btn-search">검색</button>
    </div>

    <%-- 게시글 테이블 --%>
    <table class="board-table">
        <thead>
            <tr>
                <th class="col-no">번호</th>
                <th class="col-title">제목</th>
                <th class="col-writer">작성자</th>
                <th class="col-date">날짜</th>
                <th class="col-count">조회수</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty list}">
                    <c:forEach var="board" items="${list}">
                        <tr>
                            <td>${board.notice_no}</td>
                            <td class="title-cell text-left">
                                <a href="${path}/board/detail?notice_no=${board.notice_no}"> 
                                    <c:if test="${board.board_type == 'NOTICE'}">
                                        <span class="badge-notice">공지</span>
                                    </c:if> 
                                    <c:out value="${board.title}" />
                                </a>
                            </td>
                            <td>${board.writer}</td>
                            <td><fmt:formatDate value="${board.indate}" pattern="yyyy-MM-dd"/></td>
                            <td>${board.count}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="5" class="empty-row">등록된 공지사항이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <%-- 페이징 영역 --%>
    <div class="pagination-container" style="text-align: center; margin-top: 30px;">
        <ul class="pagination" style="display: inline-flex; list-style: none; padding: 0;">
            <c:if test="${pageMaker.prev}">
                <li style="margin: 0 5px;">
                    <a href="${path}/board/notice${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a>
                </li>
            </c:if>

            <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
                <li style="margin: 0 5px;">
                    <a href="${path}/board/notice${pageMaker.makeSearch(idx)}" 
                       style="${pageMaker.cri.page == idx ? 'font-weight: bold; color: #ff0000;' : ''}">
                        ${idx}
                    </a>
                </li>
            </c:forEach>

            <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
                <li style="margin: 0 5px;">
                    <a href="${path}/board/notice${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a>
                </li>
            </c:if>
        </ul>
    </div>

    <%-- 관리자 버튼 영역 (memberType 0 = ADMIN) --%>
    <c:if test="${loginUser.memberType == 0}">
        <div class="board-footer" style="text-align: right; margin-top: 20px;">
            <a href="${path}/board/write?type=NOTICE" class="btn-dark">공지등록</a>
        </div>
    </c:if>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // 검색 로직 통합
    const searchHandler = function() {
        const keyword = $('#keywordInput').val();
        const searchType = $("#searchType").val();
        const perPageNum = "${pageMaker.cri.perPageNum}";
        
        let url = "${path}/board/notice"
                + "?page=1"
                + "&perPageNum=" + (perPageNum || 10)
                + "&searchType=" + searchType
                + "&keyword=" + encodeURIComponent(keyword);

        location.href = url;
    };

    // 버튼 클릭 시 검색
    $("#searchBtn").on("click", function(e) {
        e.preventDefault();
        searchHandler();
    });

    // 엔터키 입력 시 검색
    $("#keywordInput").on("keydown", function(e) {
        if (e.keyCode === 13) {
            searchHandler();
        }
    });
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>