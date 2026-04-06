<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/board/qna_list.css">

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
            <c:forEach items="${list}" var="board">
                <tr>
                    <td>${board.notice_no}</td>
                    <td class="title-cell text-left">
                        <%-- 답변일 경우(is_reply == 1) 들여쓰기와 아이콘 표시 --%>
                        <c:if test="${board.is_reply == 1}">
                            <span style="margin-left: 20px; color: #888;">└ [답변] </span>
                        </c:if>
                        
                        <a href="${path}/board/detail?notice_no=${board.notice_no}">${board.title}</a>
                    </td>
                    <td>${board.writer}</td>
                    <%-- 기존 <td> 영역 수정 --%>
<td>
    <c:choose>
        <%-- 1. 답변글인 경우 (본인 자체가 답변) --%>
        <c:when test="${board.is_reply == 1}">
            <span class="badge bg-gray" style="background-color: #f0f0f0; color: #666;">답변글</span>
        </c:when>
        
        <%-- 2. 원글(질문)인 경우 --%>
        <c:otherwise>
            <c:choose>
                <%-- 답변 개수가 0보다 크면 답변완료 --%>
                <c:when test="${board.reply_count > 0}">
                    <span class="badge bg-success" style="background-color: #28a745; color: #fff;">답변완료</span>
                </c:when>
                <%-- 답변 개수가 0이면 미답변 --%>
                <c:otherwise>
                    <span class="badge bg-danger" style="background-color: #dc3545; color: #fff;">미답변</span>
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:choose>
</td>
                    <td>${board.indate}</td>
                </tr>
            </c:forEach>
            
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
            <c:if test="${pageMaker.prev}">
                <li style="margin: 0 5px;">
                    <a href="${path}/board/qna${pageMaker.query(pageMaker.startPage - 1)}">이전</a>
                </li>
            </c:if>

            <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
                <li style="margin: 0 5px;">
                    <a href="${path}/board/qna${pageMaker.query(idx)}" 
                       style="${pageMaker.criteria.page == idx ? 'font-weight: bold; color: #000; text-decoration: underline;' : 'color: #666;'}">
                        ${idx}
                    </a>
                </li>
            </c:forEach>

            <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
                <li style="margin: 0 5px;">
                    <a href="${path}/board/qna${pageMaker.query(pageMaker.endPage + 1)}">다음</a>
                </li>
            </c:if>
        </ul>
    </div>

    <%-- 하단 버튼 영역 --%>
    <div class="board-footer" style="width: 100%; margin-top: 20px; display: flex; justify-content: flex-end;">
        <a href="${path}/board/qnaWrite" class="btn-dark" style="padding: 10px 25px; background: #333; color: #fff; text-decoration: none; border-radius: 4px;">질문하기</a>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>