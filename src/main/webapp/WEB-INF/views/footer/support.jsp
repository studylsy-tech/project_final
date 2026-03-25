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
        <form action="#">
            <label for="user_name">성함</label>
            <input type="text" id="user_name" placeholder="성함을 입력해주세요.">

            <label for="email">답변받을 이메일</label>
            <input type="email" id="email" placeholder="example@email.com">

            <label for="content">문의 내용</label>
            <textarea id="content" rows="6" placeholder="문의하실 내용을 상세히 적어주세요."></textarea>

            <button type="button" onclick="alert('문의가 접수되었습니다. (데모 버전)')">문의하기</button>
        </form>
    </div>

    <div class="back-btn">
        <a href="${path}/">← 메인으로 돌아가기</a>
    </div>
</div>

<%-- 공통 푸터 포함 --%>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />