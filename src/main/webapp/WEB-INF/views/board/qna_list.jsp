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
    <div class="search-area" style="margin-bottom: 20px; text-align: right;">
        <select id="searchType" class="search-select">
            <option value="t" ${pageMaker.cri.searchType eq 't' ? 'selected' : ''}>제목</option>
            <option value="c" ${pageMaker.cri.searchType eq 'c' ? 'selected' : ''}>내용</option>
            <option value="w" ${pageMaker.cri.searchType eq 'w' ? 'selected' : ''}>작성자</option>
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
                                <%-- 답변 글인 경우 들여쓰기 표시 --%>
                                <c:if test="${board.is_reply == 1}">
                                    <span class="reply-indent" style="margin-left:20px;">└ [답변] </span>
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
                                                <span class="badge-status bg-success" style="color: blue;">답변완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-status bg-danger" style="color: red;">미답변</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${board.indate}" pattern="yyyy-MM-dd