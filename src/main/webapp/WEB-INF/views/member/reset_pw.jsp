<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="reset-pw-wrapper">
    <h2>새 비밀번호 설정</h2>
    <p>계정: <strong><c:out value="${phone}" /></strong></p>

    <div id="reset_pw_form">
        <%-- 컨트롤러에서 넘겨받은 phone 번호를 히든필드에 저장 --%>
        <input type="hidden" id="phone" value="${phone}">
        
        <div>
            <label>새 비밀번호</label>
            <input type="password" id="pw" placeholder="새 비밀번호 입력">
        </div>
        <div>
            <label>비밀번호 확인</label>
            <input type="password" id="pw_check" placeholder="비밀번호 재입력">
        </div>
        
        <div style="margin-top: 20px;">
            <button type="button" id="update_btn">비밀번호 변경하기</button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $("#update_btn").on("click", function() {
            const pw = $("#pw").val();
            const pw_check = $("#pw_check").val();
            const phone = $("#phone").val();

            // 유효성 검사
            if(!pw || !pw_check) {
                alert("비밀번호를 입력해주세요.");
                return;
            }
            if(pw !== pw_check) {
                alert("비밀번호가 서로 일치하지 않습니다.");
                return;
            }

            // 실제 비밀번호 업데이트 요청 (Ajax)
            $.ajax({
                url: "${path}/member/updatePw",
                type: "POST",
                data: { 
                    phone: phone, 
                    pw: pw 
                },
                success: function(result) {
                    if(result === "success") {
                        alert("비밀번호가 변경되었습니다. 새로운 비밀번호로 로그인해주세요!");
                        location.href = "${path}/member/login";
                    } else {
                        alert("비밀번호 변경에 실패했습니다. 다시 시도해주세요.");
                    }
                },
                error: function() {
                    alert("서버 통신 중 오류가 발생했습니다.");
                }
            });
        });
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>