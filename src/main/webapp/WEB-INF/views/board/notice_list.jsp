<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/board/board.css">

<div class="board-wrapper">
    <div class="board-title-area">
        <h2>공지사항</h2>
        <p>플랫폼의 새로운 소식을 전해드립니다.</p>
    </div>

    <table class="board-table">
        <thead>
            <tr>
                <th style="width: 10%;">번호</th>
                <th style="width: 50%;">제목</th>
                <th style="width: 15%;">작성자</th>
                <th style="width: 15%;">날짜</th>
                <th style="width: 10%;">조회수</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty list}">
                    <c:forEach var="board" items="${list}">
                        <tr>
                            <%-- IDENTITY COLUMN으로 생성된 번호 출력 --%>
                            <td>${board.notice_no}</td>
                            <td class="title-cell text-left">
                                <%-- 상세 페이지 이동 시 notice_no 파라미터 전달 --%>
                                <a href="${path}/board/detail?notice_no=${board.notice_no}">
                                    <c:if test="${board.board_type == 'NOTICE'}">
                                        <span class="badge badge-notice bg-red" style="margin-right:5px;">공지</span>
                                    </c:if>
                                    <c:out value="${board.title}" />
                                </a>
                            </td>
                            <td>${board.writer}</td>
                            <td>${board.indate}</td>
                            <td>${board.count}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="5" style="text-align: center; padding: 50px 0;">등록된 공지사항이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <div class="pagination-area" style="text-align: center; margin-top: 20px;">
        <ul class="pagination" style="display: inline-flex; list-style: none; padding: 0;">
            <c:if test="${pageMaker.prev}">
                <li style="margin: 0 5px;"><a href="${path}/board/notice${pageMaker.query(pageMaker.startPage - 1)}">이전</a></li>
            </c:if>

            <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
                <li style="margin: 0 5px; ${pageMaker.criteria.page == idx ? 'font-weight: bold;' : ''}">
                    <a href="${path}/board/notice${pageMaker.query(idx)}">${idx}</a>
                </li>
            </c:forEach>

            <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
                <li style="margin: 0 5px;"><a href="${path}/board/notice${pageMaker.query(pageMaker.endPage + 1)}">다음</a></li>
            </c:if>
        </ul>
    </div>

    <%-- 관리자 권한 확인 후 등록 버튼 --%>
    <c:if test="${loginUser.memberType == 'ADMIN'}">
        <div class="board-footer" style="text-align: right; margin-top: 20px;">
            <a href="${path}/board/write?type=NOTICE" class="btn-dark">공지등록</a>
        </div>
    </c:if>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>