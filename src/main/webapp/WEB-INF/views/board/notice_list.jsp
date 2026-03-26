<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/board/board.css">

<div class="board-container">
    <div class="board-title-area">
        <h2>공지사항</h2>
        <p>플랫폼의 새로운 소식을 전해드립니다.</p>
    </div>

    <table class="board-table">
        <thead>
            <tr>
                <th style="width: 10%;">번호</th>
                <th style="width: 60%;">제목</th>
                <th style="width: 15%;">날짜</th>
                <th style="width: 15%;">조회수</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><span class="badge badge-notice">공지</span></td>
                <td class="title-cell"><a href="#">서비스 이용 가이드 및 공지사항</a></td>
                <td>2026-03-25</td>
                <td>152</td>
            </tr>
        </tbody>
    </table>

    <%-- 공지사항 목록 하단 버튼 영역 --%>
<c:if test="${loginUser.memberType == 'ADMIN'}">
    <div class="board-footer">
        <a href="${path}/board/write" class="btn-write">공지등록</a>
    </div>
</c:if>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>