<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/member/find_pw.css">

<div class="find-pw-body"> <div class="form-card"> <h1>비밀번호 찾기</h1>
        
        <div id="find_pw_step1">
            <div class="field-group">
                <label for="phone">휴대폰 번호</label>
                <input type="text" id="phone" placeholder="- 없이 숫자만 입력">
            </div>
            
            <div class="field-group">
                <label for="email">이메일 주소</label>
                <input type="email" id="email" placeholder="example@email.com">
            </div>
            
            <button type="button" id="send_code_btn" class="btn-submit">인증번호 받기</button>
        </div>

        <div id="auth_area" style="display:none;">
            <p class="auth-title">이메일을 확인하여 인증번호를 입력해주세요.</p>
            <div class="field-group">
                <input type="text" id="auth_code" placeholder="인증번호 6자리 입력">
            </div>
            <button type="button" id="verify_btn" class="btn-submit">인증 확인</button>
        </div>
    </div>
</div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	    var serverCode = ""; // 서버에서 보낸 인증번호 저장 변수
	
	    $(document).ready(function() {
	        
	        // [인증번호 받기] 버튼 클릭 시
	        $("#send_code_btn").on("click", function() {
	            const phone = $("#phone").val();
	            const email = $("#email").val();
	
	            // if(!name || !phone || !email) {
	            if(!phone || !email) {
	                alert("정보를 모두 입력해주세요.");
	                return;
	            }
	
	            $.ajax({
	                url: "${path}/member/findPwCheck", // 컨트롤러 주소
	                type: "POST",
	                data: {
	                    // name: name,
	                    phone: phone,
	                    email: email
	                },
	                success: function(result) {
	                    if(result === "not_found") {
	                        alert("일치하는 회원 정보가 없습니다.");
	                    } else if(result === "error") {
	                        alert("메일 발송 실패!");
	                    } else {
	                        alert("메일로 인증번호가 전송되었습니다.");
	                        serverCode = result; // 서버가 보낸 6자리 코드 저장
	                        $("#auth_area").show(); // 인증창 출력용
	                    }
	                }
	            });
	        });
	
	        // [인증 확인] 버튼 클릭 시
	        $("#verify_btn").on("click", function() {
	            const inputCode = $("#auth_code").val();
	
	            if(inputCode === serverCode && serverCode !== "") {
	                alert("인증 성공!");
	                // 성공하면 비밀번호 변경 페이지로 이동 (phone 번호 같이 전달)
	                const phone = $("#phone").val();
	                location.href = "${path}/member/resetPwPage?phone=" + phone;
	            } else {
	                alert("인증번호가 틀렸습니다.");
	            }
	        });
	    });
	</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>