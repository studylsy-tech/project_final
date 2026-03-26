<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div style="max-width: 800px; margin: 50px auto; padding: 20px; border: 1px solid #ddd;">
    <h2>Q&A 작성</h2>
    <form action="${path}/board/qnaWrite" method="post">
        <div style="margin-bottom: 15px;">
            <label>제목</label><br>
            <input type="text" name="title" style="width: 100%; padding: 10px;" required>
        </div>
        <div style="margin-bottom: 15px;">
            <label>내용</label><br>
            <textarea name="content" rows="10" style="width: 100%; padding: 10px;" required></textarea>
        </div>
        <button type="submit" style="padding: 10px 20px; background: #1a2a44; color: #fff; border: none; cursor: pointer;">
            등록하기
        </button>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>