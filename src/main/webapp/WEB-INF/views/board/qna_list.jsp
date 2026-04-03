<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- JSTL 사용을 위한 선언문 추가 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/board/board.css">

<div class="board-wrapper">
    <div class="board-title-area">
        <h2>Q&A</h2>
        <p>궁금하신 점을 남겨주시면 답변해 드립니다.</p>
    </div>

    <table class="board-table">
        <thead>
            <tr>
                <th style="width: 8%;">번호</th>
                <th style="width: 50%;">제목</th>
                <th style="width: 15%;">작성자</th>
                <th style="width: 12%;">상태</th>
                <th style="width: 15%;">날짜</th>
            </tr>
        </thead>
        <tbody>
            <%-- Controller에서 보낸 'list'가 비어있지 않을 때 출력 --%>
            <c:forEach items="${list}" var="board">
                <tr>
                    <%-- 소문자 필드 참조로 수정 --%>
                    <td>${board.notice_no}</td>
                    <td class="title-cell text-left">
                        <a href="${path}/board/detail?notice_no=${board.notice_no}">${board.title}</a>
                    </td>
                    <td>${board.writer}</td>
                    <td>
                        <span class="badge ${board.board_type eq 'QNA' ? 'bg-blue' : 'bg-green'}">
                            ${board.board_type eq 'QNA' ? '질문' : '공지'}
                        </span>
                    </td>
                    <td>${board.indate}</td>
                </tr>
            </c:forEach>
            
            <%-- 데이터가 없을 경우 처리 --%>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="5" style="text-align:center;">등록된 문의사항이 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <%-- 페이징 처리 영역 --%>
    <div class="pagination-area" style="text-align: center; margin-top: 20px;">
        <ul class="pagination" style="display: inline-flex; list-style: none; padding: 0;">
            <%-- '이전' 버튼 --%>
            <c:if test="${pageMaker.prev}">
                <li style="margin: 0 5px;">
                    <a href="${path}/board/qna${pageMaker.query(pageMaker.startPage - 1)}">이전</a>
                </li>
            </c:if>

            <%-- 페이지 번호 목록 --%>
            <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
                <li style="margin: 0 5px;">
                    <a href="${path}/board/qna${pageMaker.query(idx)}" 
                       style="${pageMaker.criteria.page == idx ? 'font-weight: bold; color: #000; text-decoration: underline;' : 'color: #666;'}">
                        ${idx}
                    </a>
                </li>
            </c:forEach>

            <%-- '다음' 버튼 --%>
            <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
                <li style="margin: 0 5px;">
                    <a href="${path}/board/qna${pageMaker.query(pageMaker.endPage + 1)}">다음</a>
                </li>
            </c:if>
        </ul>
    </div>

    <div class="board-footer" style="width: 75%; margin-left: auto; margin-top: 20px; display: flex; justify-content: flex-end;">
        <a href="${path}/board/qnaWrite" class="btn-dark">질문하기</a>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>