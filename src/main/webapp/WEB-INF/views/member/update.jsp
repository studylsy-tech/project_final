<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 회원 정보 수정 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 수정 완료 버튼을 누르면 컨트롤러의 @PostMapping("/member/update")로 데이터가 갑니다 -->
<form action="${path}/member/update" method="post">
    <table border="1">
        <tr>
            <th>아이디(전화번호)</th>
            <!-- 아이디는 모든 등급 공통이지만 PK라 수정은 불가 -->
            <td><input type="text" name="phone" value="${user.phone}" readonly></td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td><input type="password" name="pw" placeholder="새 비밀번호 입력"></td>
        </tr>

        <!-- 정회원(FULL) 또는 관리자(ADMIN)일 때만 나오는 정보 목록 -->
        <c:choose>
            <c:when test="${user.memberType eq 'FULL' || user.memberType eq 'ADMIN'}">
                <tr>
                    <th>이름</th>
                    <td><input type="text" name="name" value="${user.name}"></td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td><input type="email" name="email" value="${user.email}"></td>
                </tr>
                <tr>
                    <th>생년월일</th>
                    <td><input type="text" name="birth" value="${user.birth}"></td>
                </tr>
                <tr>
                    <th>성별</th>
                    <td>
                        <input type="radio" name="gender" value="M" ${user.gender eq 'M' ? 'checked' : ''}> 남
                        <input type="radio" name="gender" value="F" ${user.gender eq 'F' ? 'checked' : ''}> 여
                    </td>
                </tr>
            </c:when>
        </c:choose>
    </table>

    <div style="margin-top: 20px;">
        <button type="submit">수정 완료</button>
        <button type="button" onclick="history.back()">취소</button>
    </div>
</form>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>