<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/views/member/join_semi.css">
<div class="container" style="padding: 50px 0;">
    <h2>반회원 가입</h2>
    <p>휴대폰 번호와 비밀번호만으로 간편하게 가입하세요.</p>
    <hr>

    <form action="${pageContext.request.contextPath}/member/joinSemi" method="post">
        <div class="form-group">
            <label for="phone">휴대폰 번호 (아이디)</label>
            <input type="text" name="phone" id="phone" class="form-control" placeholder="010-0000-0000" required>
        </div>
        
        <div class="form-group">
            <label for="pw">비밀번호</label>
            <input type="password" name="pw" id="pw" class="form-control" required>
        </div>

        <div style="margin-top: 20px;">
            <button type="submit" class="btn btn-primary">가입하기</button>
            <button type="reset" class="btn btn-secondary">취소</button>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>