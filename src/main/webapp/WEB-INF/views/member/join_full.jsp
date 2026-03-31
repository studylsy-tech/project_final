<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%-- 회원가입 전용 스타일 --%>
<link rel="stylesheet" href="${path}/resources/css/views/member/join_full.css">

<div class="container" style="padding: 50px 0;">
    <h2>정회원 가입</h2>
    <p>모든 서비스를 이용하기 위해 상세 정보를 입력해주세요.</p>
    <hr>
  
    <%-- 폼 데이터가 MemberDTO의 필드와 자동 매핑되도록 name 설정 --%>
    <form action="${path}/member/joinFull" method="post">
        
        <div class="form-group">
            <label for="phone">휴대폰 번호 (아이디)</label>
            <input type="text" name="phone" id="phone" class="form-control" 
                   placeholder="'-' 없이 숫자만 입력" required>
        </div>
        
        <div class="form-group">
            <label for="pw">비밀번호</label>
            <input type="password" name="pw" id="pw" class="form-control" 
                   placeholder="비밀번호를 입력하세요" required>
        </div>

        <div class="form-group">
            <label for="name">이름</label>
            <input type="text" name="name" id="name" class="form-control" 
                   placeholder="실명을 입력하세요" required>
        </div>

        <div class="form-group">
            <label for="nickname">별명</label>
            <input type="text" name="nickname" id="nickname" class="form-control" 
                   placeholder="메인 페이지에서 사용될 별명입니다">
        </div>

        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" name="email" id="email" class="form-control" 
                   placeholder="example@mail.com (정보 수정 시 인증용)" required>
        </div>

        <div class="form-group">
            <label for="address">주소</label>
            <input type="text" name="address" id="address" class="form-control" 
                   placeholder="상세 주소를 입력하세요">
        </div>

        <%-- MEMBER_TYPE은 Controller에서 .setMemberType("FULL")로 처리하므로 input은 생략 --%>

        <div style="margin-top: 30px; text-align: center;">
            <button type="submit" class="btn btn-success" style="width: 150px;">정회원 등록</button>
            <button type="button" onclick="history.back();" class="btn btn-secondary" style="width: 150px;">뒤로가기</button>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>