<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<c:if test="${empty sessionScope.loginUser}">
    <script>
        alert("로그인이 필요한 페이지입니다.");
        location.href = "${path}/member/login";
    </script>
</c:if>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/member/info.css">

<div class="mypage-wrapper">
    <div class="mypage-header">
        <h2 class="main-title">마이페이지</h2>
        <div class="tab-container">
            <a href="${path}/member/info" class="tab-item active">내 정보 확인</a>
            <a href="${path}/member/notification" class="tab-item">알림 설정</a>
        </div>
    </div>

    <div class="info-content-box">
        <table class="info-table">
            <colgroup>
                <col style="width: 180px;">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th>아이디(전화번호)</th>
                    <td>${sessionScope.loginUser.phone}</td>
                </tr>
                <tr>
                    <th>회원 등급</th>
                    <td class="status-text">
                        <c:choose>
                            <c:when test="${sessionScope.loginUser.memberType eq 'ADMIN'}">시스템 관리자</c:when>
                            <c:when test="${sessionScope.loginUser.memberType eq 'FULL'}">정회원</c:when>
                            <c:otherwise>준회원</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                </tbody>
        </table>

        <div class="action-buttons">
            <button type="button" class="btn-outline" onclick="location.href='${path}/'">메인으로</button>
    <button type="button" class="btn-solid" onclick="location.href='${path}/member/update'">정보 수정</button>
        <c:if test="${sessionScope.loginUser.memberType eq 'ADMIN'}">
        <button type="button" class="btn-admin" onclick="location.href='${path}/admin/main'" 
                style="background-color: #dc3545; color: white; margin-left: 10px;">
            관리자 모드
        </button>
    </c:if>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>