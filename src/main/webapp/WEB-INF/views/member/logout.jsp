<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 서버 세션 무효화
    session.invalidate(); 

    // 브라우저 쿠키 삭제
    Cookie[] cookies = request.getCookies(); // 브라우저에서 보낸 모든 쿠키를 가져옴
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            // 삭제하고 싶은 쿠키의 이름을 체크 (본인이 설정한 쿠키 이름으로 수정하세요)
            if (cookie.getName().equals("rememberID")) { 
                cookie.setValue("");       // 값을 비움
                cookie.setPath("/");       // 생성 시 설정했던 경로와 일치해야 함
                cookie.setMaxAge(0);       // 유효기간을 0으로 설정하여 즉시 삭제
                response.addCookie(cookie); // 응답 객체에 담아서 브라우저로 전송
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
<script>
    alert("로그아웃 되었습니다.");
    // 세션이 삭제된 후 메인으로 이동
    location.href = "${pageContext.request.contextPath}/";
</script>
</head>
<body>
</body>
</html>