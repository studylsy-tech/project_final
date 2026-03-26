<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 공통 헤더 포함 --%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- 고객센터 전용 CSS 연결 --%>
<link rel="stylesheet" href="${path}/resources/css/views/footer/support.css">

<div class="support-container">
    <h1>고객센터</h1>

    <div class="contact-info">
        <p>📧 이메일 문의: <a href="mailto:webmaster@koreate.net">webmaster@koreate.net</a></p>
        <p>⏰ 운영시간: 평일 09:00 ~ 18:00 (주말/공휴일 휴무)</p>
        <p>📍 위치: 부산광역시... (팀 프로젝트 사무실)</p>
    </div>

    <div class="support-form">
    <%-- 1. action 경로를 컨트롤러의 @PostMapping 주소로 설정 --%>
    <%-- 2. method를 post로 설정 --%>
    <form action="${path}/footer/support.do" method="post">
        
        <label for="user_name">성함</label>
        <%-- name="user_name" 추가: VO의 필드명과 일치해야 함 --%>
        <input type="text" id="user_name" name="user_name" placeholder="성함을 입력해주세요." required>

        <label for="user_email">답변받을 이메일</label>
        <%-- name="user_email" 추가: VO의 필드명과 일치해야 함 --%>
        <input type="email" id="email" name="user_email" placeholder="example@email.com" required>

        <label for="user_content">문의 내용</label>
        <%-- name="user_content" 추가: VO의 필드명과 일치해야 함 --%>
        <textarea id="user_content" name="user_content" rows="6" placeholder="문의하실 내용을 상세히 적어주세요." required></textarea>

        <%-- type을 submit으로 변경하여 폼 전송 활성화 --%>
        <button type="submit">문의하기</button>
    </form>
</div>

    <div class="back-btn">
        <a href="${path}/">← 메인으로 돌아가기</a>
    </div>
</div>

<%-- 공통 푸터 포함 --%>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />