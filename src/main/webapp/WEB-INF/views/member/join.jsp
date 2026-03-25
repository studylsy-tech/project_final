<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/member/join_full.css">

<div class="join-container">
    <h2>회원가입</h2>
     
    <div class="tab-menu">
        <div class="tab-item active" onclick="showForm('semi')">알림만 받기</div>
        <div class="tab-item" onclick="showForm('full')">회원가입</div>
    </div>

    <div id="semi-form" class="form-content active">
        <form action="${pageContext.request.contextPath}/member/joinSemi" method="post">
            <div class="form-group">
                <label>휴대폰 번호</label>
                <input type="text" name="phone" placeholder="번호만 입력" required>
            </div>
            <div class="form-group">
                <label>비밀번호</label>
                <input type="password" name="pw" required>
            </div>
            <button type="submit" class="login-btn">알림 신청하기</button>
        </form>
    </div>

    <div id="full-form" class="form-content">
        <form action="${pageContext.request.contextPath}/member/joinFull" method="post">
            <div class="form-group">
                <label>휴대폰 번호 (아이디)</label>
                <input type="text" name="phone" required>
            </div>
            <div class="form-group">
                <label>비밀번호</label>
                <input type="password" name="pw" required>
            </div>
            <div class="form-group">
                <label>이름</label>
                <input type="text" name="name" required>
            </div>
            <div class="form-group">
                <label>이메일</label>
                <input type="email" name="email" required>
            </div>
            <div class="form-group">
                <label>생년월일</label>
                <input type="date" name="birth">
            </div>
            <div class="form-group">
                <label>성별</label>
                <div class="gender-selection" style="display: flex; gap: 20px; align-items: center; margin-top: 10px;">
                    <label style="display: flex; align-items: center; cursor: pointer; font-weight: normal; margin-bottom: 0;">
                        <input type="radio" name="gender" value="M" id="male" style="width: auto; margin-right: 8px;"> 남성
                    </label>
                    <label style="display: flex; align-items: center; cursor: pointer; font-weight: normal; margin-bottom: 0;">
                        <input type="radio" name="gender" value="F" id="female" style="width: auto; margin-right: 8px;"> 여성
                    </label>
                </div>
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