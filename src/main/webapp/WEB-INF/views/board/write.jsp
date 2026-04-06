<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<link rel="stylesheet" href="${path}/resources/css/views/board/write.css">

<div class="board-title-area">
    <h2>
        <c:choose>
            <c:when test="${isReply}">문의사항 답변하기</c:when>
            <c:when test="${board_type eq 'NOTICE'}">공지사항 작성</c:when>
            <c:otherwise>1:1 문의하기</c:otherwise>
        </c:choose>
    </h2>
    <p style="color: #666;">
        <c:choose>
            <c:when test="${isReply}">유저의 문의에 대한 답변을 작성합니다.</c:when>
            <c:when test="${board_type eq 'NOTICE'}">서비스의 새로운 소식을 등록합니다.</c:when>
            <c:otherwise>궁금하신 내용을 남겨주시면 정성껏 답변해 드립니다.</c:otherwise>
        </c:choose>
    </p>
</div>

<form action="${path}/board/write" method="post">
    <input type="hidden" name="board_type" value="QNA">
    
    <table class="board-table" style="width: 100%; border-collapse: collapse;">
        <c:if test="${isReply}">
            <tr>
                <th style="width: 20%; padding: 15px; background: #f0f0f0; border-bottom: 1px solid #ddd; text-align: left;">원글 정보</th>
                <td style="padding: 15px; border-bottom: 1px solid #ddd; background: #fafafa; font-size: 0.9em; color: #555;">
                    <strong>[${parentBoard.writer}님의 질문]:</strong> ${parentBoard.title}<br>
                    <div style="margin-top:5px; white-space: pre-wrap;">${parentBoard.content}</div>
                </td>
            </tr>
        </c:if>
        <tr>
            <th style="width: 20%; padding: 15px; background: #f9f9f9; border-bottom: 1px solid #ddd; text-align: left;">작성자</th>
            <td style="padding: 10px; border-bottom: 1px solid #ddd;">
                <input type="text" name="writer" value="${not empty loginUser.nickname ? loginUser.nickname : loginUser.name}" 
                       class="form-control" readonly style="width: 100%; border: 1px solid #ccc; padding: 8px; background: #eee;">
            </td>
        </tr>
        <tr>
            <th style="padding: 15px; background: #f9f9f9; border-bottom: 1px solid #ddd; text-align: left;">제목</th>
            <td style="padding: 10px; border-bottom: 1px solid #ddd;">
                <input type="text" name="title" class="form-control" 
                       value="${isReply ? '[답변] '.concat(parentBoard.title) : ''}" required
                       style="width: 100%; border: 1px solid #ccc; padding: 8px;">
            </td>
        </tr>
        <tr>
            <th style="padding: 15px; background: #f9f9f9; border-bottom: 1px solid #ddd; text-align: left;">내용</th>
            <td style="padding: 10px; border-bottom: 1px solid #ddd;">
                <textarea name="content" rows="15" class="form-control" required 
                          style="width: 100%; border: 1px solid #ccc; padding: 10px; resize: none;">${isReply ? '안녕하세요. 관리자입니다.&#10;&#10;' : ''}</textarea>
            </td>
        </tr>
    </table>

    <div class="board-footer" style="margin-top: 30px; text-align: center; display: flex; gap: 10px; justify-content: center;">
        <button type="submit" class="btn-dark" style="padding: 10px 30px; background: #333; color: #fff; border: none; cursor: pointer;">
            ${isReply ? '답변 등록' : (board_type eq 'NOTICE' ? '공지 등록' : '문의 등록')}
        </button>
        <button type="button" class="btn-secondary" onclick="history.back();" style="padding: 10px 30px; background: #ccc; color: #333; border: none; cursor: pointer;">
            취소
        </button>
    </div>
</form>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>