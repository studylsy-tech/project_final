<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/board/board.css">

<div class="board-container">
    <div class="board-title-area">
        <h2>Q&A</h2>
        <p>궁금하신 점을 남겨주시면 답변해 드립니다.</p>
    </div>

    <table class="board-table">
        <thead>
            <tr>
                <th style="width: 10%;">번호</th>
                <th style="width: 50%;">제목</th>
                <th style="width: 15%;">작성자</th>
                <th style="width: 15%;">상태</th>
                <th style="width: 10%;">날짜</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td class="title-cell"><a href="#">가격 알림이 오지 않아요.</a></td>
                <td>${loginUser.name}</td>
                <td><span class="badge badge-qna">답변완료</span></td>
                <td>2026-03-24</td>
            </tr>
        </tbody>
    </table>

    <div class="board-footer">
        <a href="${path}/board/write" class="btn-write">질문하기</a>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>