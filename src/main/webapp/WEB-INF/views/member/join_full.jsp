<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/views/member/join_full.css">
<div class="container" style="padding: 50px 0;">
    <h2>정회원 가입</h2>
    <p>모든 서비스를 이용하기 위해 상세 정보를 입력해주세요.</p>
    <hr>

    <form action="${pageContext.request.contextPath}/member/joinFull" method="post">
        <div class="form-group">
            <label for="phone">휴대폰 번호 (아이디)</label>
            <input type="text" name="phone" id="phone" class="form-control" required>
        </div>
        
        <div class="form-group">
            <label for="pw">비밀번호</label>
            <input type="password" name="pw" id="pw" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="name">이름</label>
            <input type="text" name="name" id="name" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" name="email" id="email" class="form-control" placeholder="example@mail.com">
        </div>

        <div class="form-group">
            <label for="birth">생년월일</label>
            <input type="date" name="birth" id="birth" class="form-control">
        </div>

        <div class="form-group">
            <label>성별</label><br>
            <input type="radio" name="gender" value="M" id="male"> <label for="male">남성</label>
            <input type="radio" name="gender" value="F" id="female"> <label for="female">여성</label>
        </div>

        <div style="margin-top: 20px;">
            <button type="submit" class="btn btn-success">정회원 등록</button>
            <button type="button" onclick="history.back();" class="btn btn-secondary">뒤로가기</button>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>