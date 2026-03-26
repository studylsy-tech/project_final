<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<h2>내 정보 확인</h2>

<table border="1">
    <tr>
        <th>아이디(전화번호)</th>
        <td>${user.phone}</td>
    </tr>
    <tr>
        <th>회원 등급</th>
        <td>
            <c:choose>
               <%-- 관리자 일 때 --%>
                <c:when test="${user.memberType eq 'ADMIN'}">
                    <b style="color: red;">시스템 관리자</b>
                </c:when>
               <%-- 정회원 일 때 --%>
                <c:when test="${user.memberType eq 'FULL'}">
                    정회원
                </c:when>
                <%-- 그 외 (준회원 등) --%>
                <c:otherwise>
                    준회원
                </c:otherwise>
            </c:choose>
        </td>
    </tr>

    <!-- 정회원 / 관리자 일 때만 추가 정보 표시 -->
    <c:if test="${user.memberType eq 'FULL' || user.memberType eq 'ADMIN'}">
    	
    	<tr>
	        <th>이메일</th>
	        <td>${user.email}</td>
  		</tr>
        <tr>
            <th>생년월일</th>
            <td>${user.birth}</td>
        </tr>
        <tr>
            <th>성별</th>
            <td>${user.gender}</td>
        </tr>
    </c:if>
</table>

<!-- 추후 추가 예정 -->
<div>
    <button onclick="location.href='${path}/'">메인으로</button>
    <button onclick="location.href='${path}/member/update'">정보 수정</button>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>