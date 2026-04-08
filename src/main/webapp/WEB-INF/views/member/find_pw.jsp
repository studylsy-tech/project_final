<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/member/find_pw.css?v=2">

<main>
    <div class="form-card">
        <h1>비밀번호 찾기</h1>

        <div class="field">
            <label for="phone">휴대폰 번호</label>
            <input type="text" id="phone" placeholder="- 없이 숫자만 입력">
        </div>

        <div class="field">
            <label for="email">이메일 주소</label>
            <input type="email" id="email" placeholder="example@email.com">
            <button type="button" id="send_code_btn" class="btn-verify">인증번호 받기</button>
        </div>

        <div id="auth_area" style="display:none;">
            <div class="field">
                <label for="auth_code">인증번호</label>
                <input type="text" id="auth_code" placeholder="6자리 입력">
                <button type="button" id="verify_btn" class="btn-verify">인증 확인</button>
            </div>
        </div>
    </div>
</main>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    var serverCode = ""; 

    $(document).ready(function() {
        // 인증번호 발송
        $("#send_code_btn").on("click", function() {
            const phone = $("#phone").val();
            const email = $("#email").val();

            if(!phone || !email) {
                alert("정보를 모두 입력해주세요.");
                return;
            }

            $.ajax({
                url: "${path}/member/findPwCheck",
                type: "POST",
                data: { phone: phone, email: email },
                success: function(result) {
                    if(result === "not_found") {
                        alert("일치하는 회원 정보가 없습니다.");
                    } else if(result === "error") {
                        alert("메일 발송 실패!");
                    } else {
                        alert("메일로 인증번호가 전송되었습니다.");
                        serverCode = result;
                        $("#auth_area").fadeIn(); // 부드러운 노출
                        $("#send_code_btn").text("재전송");
                    }
                }
            });
        });

        // 인증 확인 및 페이지 이동
        $("#verify_btn").on("click", function() {
            const inputCode = $("#auth_code").val();
            if(inputCode === serverCode && serverCode !== "") {
                alert("인증 성공!");
                const phone = $("#phone").val();
                location.href = "${path}/member/resetPwPage?phone=" + phone;
            } else {
                alert("인증번호가 틀렸습니다.");
            }
        });
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>