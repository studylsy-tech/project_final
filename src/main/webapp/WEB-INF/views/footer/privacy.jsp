<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 공통 헤더 포함 --%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- 개인정보 처리방침 전용 CSS 연결 --%>
<link rel="stylesheet" href="${path}/resources/css/views/footer/privacy.css">

<div class="privacy-container">
    <h1>개인정보 처리방침</h1>
    <p class="date">시행일자: 2026년 3월 23일</p>

    <section>
        <h2>1. 수집하는 개인정보 항목</h2>
        <div class="privacy-section">
            <p>본 서비스(Price Tracking Platform)는 원활한 서비스 제공을 위해 아래와 같은 정보를 수집합니다.</p>
            <ul>
                <li><strong>필수 항목:</strong> 이메일 주소, 이름, 비밀번호</li>
                <li><strong>선택 항목:</strong> 휴대폰 번호, 관심 상품 카테고리</li>
            </ul>
        </div>
    </section>

    <section>
        <h2>2. 개인정보의 수집 및 이용 목적</h2>
        <p>수집한 개인정보는 다음의 목적을 위해 활용합니다.</p>
        <ul>
            <li>회원 관리 및 본인 확인</li>
            <li>관심 상품 가격 변동 알림 서비스 제공</li>
            <li>Selenium 기반 크롤링 데이터 개인화 서비스</li>
        </ul>
    </section>

    <section>
        <h2>3. 개인정보의 보유 및 이용기간</h2>
        <p>이용자의 개인정보는 원칙적으로 <strong>회원 탈퇴 시</strong> 지체 없이 파기합니다. 단, 관계 법령에 따라 보존할 필요가 있는 경우 해당 기간 동안 보관합니다.</p>
    </section>

    <section>
        <h2>4. 개인정보 보호책임자</h2>
        <div class="privacy-section">
            <p>성명: 관리자(팀 프로젝트)</p>
            <p>이메일: <a href="mailto:webmaster@koreate.net">webmaster@koreate.net</a></p>
        </div>
    </section>
    
    <div class="back-btn-area">
        <button onclick="history.back()" class="btn-back">뒤로가기</button>
    </div>
</div>
