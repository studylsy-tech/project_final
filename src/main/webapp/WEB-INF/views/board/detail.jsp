<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<link rel="stylesheet" href="${path}/resources/css/views/board/detail.css">

<div class="board-wrapper">
    <div class="detail-header">
        <div class="detail-title">
            <c:if test="${board.board_type == 'NOTICE'}">
                <span style="color: #e74c3c; margin-right: 10px;">[공지]</span>
            </c:if>
            <c:out value="${board.title}" />
        </div>
        <div class="detail-info">
            <span><b>작성자</b> ${board.writer}</span>
            <span><b>작성일</b> ${board.indate}</span>
            <span><b>조회수</b> ${board.count}</span>
        </div>
    </div>

    <div class="detail-content">
        ${board.content}
    </div>

    <div class="detail-footer">
        <%-- 게시판 타입에 따른 목록 이동 --%>
        <a href="${path}/board/${board.board_type == 'NOTICE' ? 'notice' : 'qna'}" class="btn-detail btn-list">목록으로</a>
        
        <div class="btn-group">
            <%-- 1. [관리자 전용] 답변하기 버튼: 관리자(0)이고 QNA 글일 때만 노출 --%>
            <c:if test="${sessionScope.loginUser.memberType == 0 && board.board_type == 'QNA'}">
    <a href="${path}/board/qnaReply?notice_no=${board.notice_no}" 
       class="btn-detail btn-reply" 
       style="background-color: #444; color: #fff; margin-right: 5px;">답변하기</a>
</c:if>
<c:if test="${not empty board.org_filename}">
    <div class="detail-file-area" style="margin-top: 20px; padding: 10px; border: 1px solid #eee;">
        <strong>첨부파일: </strong>
        <%-- DB에 저장된 실제 원본 파일명 출력 --%>
        <a href="${path}/board/download?notice_no=${board.notice_no}">
            <c:out value="${board.org_filename}" />
        </a>
    </div>
</c:if>
            <%-- 2. 수정/삭제 버튼: 본인 글이거나 관리자(0)일 때 노출 --%>
            <c:if test="${loginUser.nickname == board.writer || loginUser.memberType == 0}">
                <a href="${path}/board/modify?notice_no=${board.notice_no}" class="btn-detail btn-edit">수정</a>
                <button type="button" class="btn-detail btn-delete" onclick="deleteBoard();">삭제</button>
            </c:if>
        </div>
    </div>
</div>

<script>
function deleteBoard() {
    if(confirm("정말로 삭제하시겠습니까?")) {
        location.href = "${path}/board/delete?notice_no=${board.notice_no}&type=${board.board_type}";
    }
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>