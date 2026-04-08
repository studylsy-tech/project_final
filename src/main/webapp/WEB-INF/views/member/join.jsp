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

<script>
    // 서버에서 받은 인증번호를 저장할 변수 (준회원, 정회원 구분)
    var authCodes = {
        semi: "",
        full: ""
    };

    $(function() {
        // 인증번호 발송 기능
        $(".mail-btn").on("click", function() {
            var type = $(this).data("type"); // 'semi' 또는 'full'
            // 정회원 이메일 입력창 ID는 'email'이고 준회원은 'semi_email'인 점 체크!!!
            var emailSelector = (type === 'semi') ? "#semi_email" : "#email";
            var email = $(emailSelector).val();

            if(!email || !email.includes('@')) {
                alert("이메일 주소를 정확히 입력해주세요.");
                return;
            }

            $.ajax({
                url: "${path}/member/mailCheck",
                type: "GET",
                data: { email: email },
                success: function(data) {
                    if(data !== "error") {
                        alert("인증번호가 발송되었습니다.");
                        authCodes[type] = data; // 서버가 보낸 번호 저장
                        $("#" + type + "_auth_area").show(); // 숨겨진 입력창 노출
                    } else {
                        alert("메일 발송에 실패했습니다.");
                    }
                }
            });
        });

        // [2] 인증번호 확인 및 가입 버튼 활성화 기능
        $(".verify-btn").on("click", function() {
            var type = $(this).data("type");
            var inputCode = $("#" + type + "_code").val(); // 사용자가 입력한 번호
            var serverCode = authCodes[type]; // 서버에서 보냈던 번호

            if(inputCode === serverCode && serverCode !== "") {
                alert("인증 성공!");
                
                // 인증 완료 후 수정 방지
                var emailSelector = (type === 'semi') ? "#semi_email" : "#email";
                $(emailSelector).attr("readonly", true);
                $("#" + type + "_code").attr("readonly", true);
                
                // 가입 버튼 활성화 (disabled 해제)
                $("#" + type + "_submit").prop("disabled", false);
                // 시각적으로 클릭 가능하게 변경
                $("#" + type + "_submit").css("cursor", "pointer").css("opacity", "1");
            } else {
                alert("인증번호가 일치하지 않습니다.");
                $("#" + type + "_submit").prop("disabled", true);
            }
        });
    });
</script>

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
    <!-- flex 컨테이너로 input과 button을 한 줄에 배치 -->
    <div style="display: flex; gap: 8px;">
        <input type="email" name="email" id="semi_email" 
               placeholder="알림을 받을 이메일을 입력하세요" required
               style="flex: 1;"> <!-- flex:1 로 남은 공간을 input이 채움 -->
        <button type="button" class="mail-btn" data-type="semi">인증번호 받기</button>
    </div>
	</div>
        <div id="semi_auth_area" style="display: none;">
    <!-- flex 컨테이너로 input과 button을 한 줄에 배치 + height 일치 -->
    <div style="display: flex; gap: 8px; height: 48px;">
        <input type="text" id="semi_code" 
               placeholder="인증번호 6자리"
               style="flex: 1; height: 100%;">
        <button type="button" class="verify-btn" data-type="semi">인증확인</button>
    </div>
</div>
        <button type="submit" id="semi_submit" class="login-btn" disabled>알림 신청하기</button>
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
                <!-- flex 컨테이너로 input과 button을 한 줄에 배치 -->
   				 <div style="display: flex; gap: 8px;">                
                <input type="email" name="email" id="email" placeholder="example@email.com" required style="flex: 1;">
                <!-- flex:1 로 남은 공간을 input이 채움 -->                
                <button type="button" class="mail-btn" data-type="full">인증번호 받기</button>
            </div>
            </div>
            <div id="full_auth_area" style="display:none; ">
             <!-- flex 컨테이너로 input과 button을 한 줄에 배치 + height 일치 -->
                <div style="display: flex; gap: 8px; height: 48px;">                         
			    <input type="text" id="full_code" placeholder="인증번호 6자리" style="flex: 1; height :100%;">
			    <button type="button" class="verify-btn" data-type="full">인증확인</button>
			</div>
			</div>
            <div class="form-group">
                <label for="nickname">별명</label>
                <input type="text" name="nickname" id="nickname" placeholder="미입력 시 실명이 노출됩니다.">
            </div>
            <div class="form-group">
                <label for="address">주소</label>
                <input type="text" name="address" id="address" placeholder="상세 주소를 입력하세요">
            </div>
            
            <button type="submit" id="full_submit" class="login-btn" disabled>정회원 가입하기</button>
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
