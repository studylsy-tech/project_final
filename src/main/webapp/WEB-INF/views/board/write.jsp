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
    <p class="title-desc">
        <c:choose>
            <c:when test="${isReply}">유저의 문의에 대한 답변을 작성합니다.</c:when>
            <c:when test="${board_type eq 'NOTICE'}">서비스의 새로운 소식을 등록합니다.</c:when>
            <c:otherwise>궁금하신 내용을 남겨주시면 정성껏 답변해 드립니다.</c:otherwise>
        </c:choose>
    </p>
</div>

<form action="${path}/board/write" method="post" enctype="multipart/form-data">
    <input type="hidden" name="board_type" value="${board_type}">
    <input type="hidden" name="is_reply" value="${isReply ? 1 : 0}">
    <c:if test="${isReply}">
        <input type="hidden" name="parent_no" value="${parentBoard.notice_no}">
    </c:if>

    <table class="board-table">
        <c:if test="${isReply}">
            <tr class="reply-info-row">
                <th>원글 정보</th>
                <td class="parent-content">
                    <strong>[${parentBoard.writer}님의 질문]:</strong> ${parentBoard.title}
                    <div class="parent-text">${parentBoard.content}</div>
                </td>
            </tr>
        </c:if>
        <tr>
            <th>작성자</th>
            <td>
                <input type="text" name="writer" 
                       value="${not empty loginUser.nickname ? loginUser.nickname : loginUser.name}" 
                       class="form-control" readonly>
            </td>
        </tr>
        <tr>
            <th>제목</th>
            <td>
                <input type="text" name="title" class="form-control" 
                       value="${isReply ? '[답변] '.concat(parentBoard.title) : ''}" required>
            </td>
        </tr>
        <tr>
            <th>내용</th>
            <td>
                <textarea name="content" rows="15" class="form-control" required>${isReply ? '안녕하세요. 관리자입니다.&#10;&#10;' : ''}</textarea>
            </td>
        </tr>
        <tr>
            <th>첨부파일</th>
            <td>
                <input type="file" name="uploadFile" class="form-control">
                <p class="file-help-text">
                    * 텍스트 파일이나 작은 이미지 위주로 첨부해 주세요. (DB 직접 저장 방식)
                </p>
            </td>
        </tr>
    </table>

    <div class="board-footer">
        <button type="submit" class="btn-dark">
            ${isReply ? '답변 등록' : (board_type eq 'NOTICE' ? '공지 등록' : '문의 등록')}
        </button>
        <button type="button" class="btn-secondary" onclick="history.back();">
            취소
        </button>
    </div>
</form>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>