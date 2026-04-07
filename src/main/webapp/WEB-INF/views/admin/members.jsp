<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 관리자 권한 체크 --%>
<c:if test="${sessionScope.loginUser.memberType != 0}">
    <script>
        alert("관리자만 접근 가능한 페이지입니다.");
        location.href = "${path}/";
    </script>
</c:if>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%-- 기존 공통 스타일 및 전용 CSS 로드 --%>
<link rel="stylesheet" href="${path}/resources/css/views/member/info.css">
<link rel="stylesheet" href="${path}/resources/css/admin/admin_main.css">
<link rel="stylesheet" href="${path}/resources/css/admin/members.css">

<div class="mypage-wrapper">
    <div class="mypage-header">
        <h2 class="main-title">마이페이지</h2>
        <div class="tab-container">
            <a href="${path}/member/info" class="tab-item">내 정보 확인</a>
            <a href="${path}/member/notification" class="tab-item">알림 설정</a>
            <a href="${path}/admin/main" class="tab-item admin-tab active">관리자 대시보드</a>
        </div>
    </div>

    <div class="info-content-box">
        <div class="admin-wrapper">
            
            <div class="admin-header">
                <h3 class="settings-title">상세 회원 관리</h3>
                <p class="member-count">총 <strong>${totalMemberCount}</strong>명의 회원이 가입되어 있습니다.</p>
            </div>

            <div class="table-container">
                <table class="member-table">
                    <thead>
                        <tr>
                            <th>가입일</th>
                            <th>이름(닉네임)</th>
                            <th>휴대폰 번호</th>
                            <th>이메일</th>
                            <th>권한</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="member" items="${memberList}">
                            <tr>
                                <td>${member.createdAt}</td>
                                <td><span class="u-name">${member.name}</span> (${member.nickname})</td>
                                <td>${member.phone}</td>
                                <td class="u-email">${member.email}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${member.memberType == 0}"><span class="badge admin">관리자</span></c:when>
                                        <c:when test="${member.memberType == 2}"><span class="badge full">정회원</span></c:when>
                                        <c:otherwise><span class="badge semi">준회원</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${member.memberType != 0}">
                                        <button type="button" class="kick-btn" 
                                                onclick="if(confirm('${member.name} 회원을 강제 탈퇴 처리하시겠습니까?')) location.href='${path}/admin/memberDelete?phone=${member.phone}'">
                                            강퇴
                                        </button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="admin-footer">
                <button type="button" class="back-btn" onclick="location.href='${path}/admin/main'">대시보드 복귀</button>
            </div>

        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>