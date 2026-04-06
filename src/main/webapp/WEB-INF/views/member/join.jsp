<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/member/join_full.css">

<c:if test="${not empty msg}">
    <script>
        alert("${msg}");
        // 필요한 경우 특정 탭(정회원 가입)이 바로 보이도록 설정 가능
        window.onload = function() {
            showForm('full');
        };
    </script>
</c:if>

<div class="join-container">
    <h2>회원가입</h2>
     
    <div class="tab-menu">
        <div class="tab-item active" onclick="showForm('semi')">알림만 받기</div>
        <div class="tab-item" onclick="showForm('full')">정회원 가입</div>
    </div>

    <%-- 준회원(SEMI) 폼 수정: 이메일 입력란 추가 --%>
<div id="semi-form" class="form-content active">
    <form action="${path}/member/joinSemi" method="post">
        <div class="form-group">
            <label for="semi_phone">휴대폰 번호</label>
            <input type="text" name="phone" id="semi_phone" placeholder="'-' 제외 번호만 입력" required>
        </div>
        <div class="form-group">
            <label for="semi_pw">비밀번호</label>
            <input type="password" name="pw" id="semi_pw" required>
        </div>
        
        <%-- 추가된 이메일 입력란 --%>
        <div class="form-group">
            <label for="semi_email">이메일</label>
            <input type="email" name="email" id="semi_email" placeholder="알림을 받을 이메일을 입력하세요" required>
        </div>
        
        <button type="submit" class="login-btn">알림 신청하기</button>
    </form>
</div>

    <%-- 정회원(FULL) 폼: 상세 정보 입력 (이메일 필수 추가) --%>
    <div id="full-form" class="form-content">
        <form action="${path}/member/joinFull" method="post">
            <div class="form-group">
                <label for="full_phone">휴대폰 번호 (아이디)</label>
                <input type="text" name="phone" id="full_phone" placeholder="'-' 제외 번호만 입력" required>
            </div>
            <div class="form-group">
                <label for="full_pw">비밀번호</label>
                <input type="password" name="pw" id="full_pw" required>
            </div>
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" name="name" id="name" placeholder="실명을 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" name="email" id="email" placeholder="example@email.com" required>
            </div>
            <div class="form-group">
                <label for="nickname">별명</label>
                <input type="text" name="nickname" id="nickname" placeholder="미입력 시 실명이 노출됩니다.">
            </div>
            <div class="form-group">
                <label for="address">주소</label>
                <input type="text" name="address" id="address" placeholder="상세 주소를 입력하세요">
            </div>
            
            <button type="submit" class="login-btn">정회원 가입하기</button>
        </form>
    </div>
</div>

<script>
    function showForm(type) {
        document.querySelectorAll('.form-content').forEach(f => f.classList.remove('active'));
        document.querySelectorAll('.tab-item').forEach(t => t.classList.remove('active'));

        if(type === 'semi') {
            document.getElementById('semi-form').classList.add('active');
            document.querySelectorAll('.tab-item')[0].classList.add('active');
        } else {
            document.getElementById('full-form').classList.add('active');
            document.querySelectorAll('.tab-item')[1].classList.add('active');
        }
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>