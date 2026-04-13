<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<link rel="stylesheet" href="${path}/resources/css/views/board/modify.css">

<div class="container">
    <div class="board-title-area">
        <h2>게시글 수정</h2>
    </div>

    <form action="${path}/board/modify" method="post" enctype="multipart/form-data">
        <input type="hidden" name="notice_no" value="${board.notice_no}">
        
        <table class="board-table">
            <tr>
                <th><label for="title">제목</label></th>
                <td>
                    <input type="text" id="title" name="title" class="form-control" value="${board.title}" required>
                </td>
            </tr>
            <tr>
                <th><label for="writer">작성자</label></th>
                <td>
                    <input type="text" id="writer" name="writer" class="form-control" value="${board.writer}" readonly>
                </td>
            </tr>
            <tr>
                <th><label for="content">내용</label></th>
                <td>
                    <textarea id="content" name="content" class="form-control" rows="10" required>${board.content}</textarea>
                </td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td>
                    <c:if test="${not empty board.org_filename}">
                        <div class="file-info-area">
                            <span>현재 파일:</span> ${board.org_filename}
                        </div>
                    </c:if>
                    <input type="file" id="file" name="uploadFile" class="form-control">
                    <small class="file-notice">* 새로운 파일을 선택하면 기존 파일이 교체됩니다.</small>
                </td>
            </tr>
        </table>

        <div class="board-footer">
            <button type="submit" class="btn-dark">수정완료</button>
            <button type="button" class="btn-secondary" onclick="history.back()">취소</button>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>