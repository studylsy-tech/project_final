<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/board/qna_list.css">

<div class="board-wrapper">
    <div class="board-title-area">
        <h2>Q&A</h2>
        <p>궁금하신 점을 남겨주시면 답변해 드립니다.</p>
    </div>

    <%-- 검색 영역 --%>
<<<<<<< HEAD
    <div class="search-area">
=======
    <div class="search-area" style="margin-bottom: 20px; text-align: right;">
>>>>>>> branch 'develop' of https://github.com/studylsy-tech/project_final.git
        <select id="searchType" class="search-select">
<<<<<<< HEAD
            <option value="title" ${pageMaker.cri.searchType eq 'title' ? 'selected' : ''}>제목</option>
            <option value="content" ${pageMaker.cri.searchType eq 'content' ? 'selected' : ''}>내용</option>
            <option value="writer" ${pageMaker.cri.searchType eq 'writer' ? 'selected' : ''}>작성자</option>
=======
            <option value="t" ${pageMaker.cri.searchType eq 't' ? 'selected' : ''}>제목</option>
            <option value="c" ${pageMaker.cri.searchType eq 'c' ? 'selected' : ''}>내용</option>
            <option value="w" ${pageMaker.cri.searchType eq 'w' ? 'selected' : ''}>작성자</option>
            <option value="tc" ${pageMaker.cri.searchType eq 'tc' ? 'selected' : ''}>제목+내용</option>
>>>>>>> branch 'develop' of https://github.com/studylsy-tech/project_final.git
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
                <th class="col-status">상태</th>
                <th class="col-date">날짜</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty list}">
                    <c:forEach items="${list}" var="board">
                        <tr>
                            <td>${board.notice_no}</td>
                            <td class="title-cell text-left">
<<<<<<< HEAD
                                <%-- 답변글일 경우 들여쓰기 표시 --%>
=======
                                <%-- 답변 글인 경우 들여쓰기 표시 --%>
>>>>>>> branch 'develop' of https://github.com/studylsy-tech/project_final.git
                                <c:if test="${board.is_reply == 1}">
<<<<<<< HEAD
                                    <span class="reply-indent" style="margin-left: 15px;">└ [답변] </span>
=======
                                    <span class="reply-indent" style="margin-left:20px;">└ [답변] </span>
>>>>>>> branch 'develop' of https://github.com/studylsy-tech/project_final.git
                                </c:if>
                                <a href="${path}/board/detail?notice_no=${board.notice_no}">
                                    <c:out value="${board.title}" />
                                </a>
                            </td>
                            <td>${board.writer}</td>
                            <td>
                                <c:choose>
                                    <%-- 답변글 자체일 때 --%>
                                    <c:when test="${board.is_reply == 1}">
                                        <span class="badge-status bg-gray">답변글</span>
                                    </c:when>
                                    <%-- 원본 질문글일 때 답변 여부 확인 --%>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${board.reply_count > 0}">
<<<<<<< HEAD
                                                <span class="badge-status bg-success" style="color: green;">답변완료</span>
=======
                                                <span class="badge-status bg-success" style="color: blue;">답변완료</span>
>>>>>>> branch 'develop' of https://github.com/studylsy-tech/project_final.git
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-status bg-danger" style="color: red;">미답변</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </td>
<<<<<<< HEAD
                            <td>${board.indate}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="5" class="empty-row" style="text-align:center; padding: 20px;">등록된 문의사항이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <%-- 페이징 처리 영역 --%>
    <div class="pagination-container" style="text-align: center; margin-top: 30px;">
        <ul class="pagination" style="display: inline-flex; list-style: none; padding: 0;">
            <c:if test="${pageMaker.prev}">
                <li style="margin: 0 5px;">
                    <a href="${path}/search/list${pageMaker.makeSearch(pageMaker.startPage - 1)}&boardType=QNA">이전</a>
                </li>
            </c:if>

            <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
                <li style="margin: 0 5px;">
                    <a href="${path}/search/list${pageMaker.makeSearch(idx)}&boardType=QNA" 
                       class="${pageMaker.cri.page == idx ? 'active' : ''}"
                       style="${pageMaker.cri.page == idx ? 'font-weight: bold; color: blue;' : ''}">
                        ${idx}
                    </a>
                </li>
            </c:forEach>

            <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
                <li style="margin: 0 5px;">
                    <a href="${path}/search/list${pageMaker.makeSearch(pageMaker.endPage + 1)}&boardType=QNA">다음</a>
                </li>
            </c:if>
        </ul>
    </div>

    <%-- 버튼 영역 --%>
    <div class="board-footer" style="text-align: right; margin-top: 20px;">
        <a href="${path}/board/qnaWrite" class="btn-dark">질문하기</a>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // 검색 버튼 클릭 이벤트
    $(document).on("click", "#searchBtn", function(e) {
        e.preventDefault();
        
        const keyword = $('#keywordInput').val();
        const searchType = $("#searchType").val();
        const perPageNum = "${pageMaker.cri.perPageNum}";
        const contextPath = "${path}";

        // 검색 시 1페이지로 리셋 및 QNA 타입 유지
        let url = contextPath + "/search/list"
                + "?page=1"
                + "&perPageNum=" + (perPageNum || 10)
                + "&boardType=QNA"
                + "&searchType=" + searchType
                + "&keyword=" + encodeURIComponent(keyword);

        location.href = url;
    });

    // 엔터키 지원
    $(document).on("keydown", "#keywordInput", function(e) {
        if (e.keyCode === 13) {
            $("#searchBtn").click();
        }
    });
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
=======
                            <td><fmt:formatDate value="${board.indate}" pattern="yyyy-MM-dd
>>>>>>> branch 'develop' of https://github.com/studylsy-tech/project_final.git
