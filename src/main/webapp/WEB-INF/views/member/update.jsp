<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container" style="padding: 50px 0;">
    <h2>회원 정보 수정</h2>
    <p>이메일 인증을 통해 본인 확인 후 정보를 수정할 수 있습니다.</p>
    <hr>

    <form action="${path}/member/update" method="post">
        <table border="1" class="table">
            <tr>
                <th>휴대폰 번호 (아이디)</th>
                <td><input type="text" name="phone" value="${loginUser.phone}" readonly class="form-control"></td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td><input type="password" name="pw" placeholder="새 비밀번호 입력" class="form-control" required></td>
            </tr>

            <c:choose>
                <c:when test="${loginUser.memberType eq 'FULL' || loginUser.memberType eq 'ADMIN'}">
                    <tr>
                        <th>이름</th>
                        <td><input type="text" name="name" value="${loginUser.name}" class="form-control"></td>
                    </tr>
                    <tr>
                        <th>별명</th>
                        <td><input type="text" name="nickname" value="${loginUser.nickname}" class="form-control"></td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <%-- 이메일 검증을 통해 수정하므로, 이메일은 키값으로서 조회용(readonly)으로 두는 것이 안전합니다 --%>
                        <td><input type="email" name="email" value="${loginUser.email}" readonly class="form-control"></td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td><input type="text" name="address" value="${loginUser.address}" class="form-control"></td>
                    </tr>
                </c:when>
            </c:choose>
        </table>

        <div style="margin-top: 20px;">
            <button type="submit" class="btn btn-primary">수정 완료</button>
            <button type="button" onclick="history.back()" class="btn btn-secondary">취소</button>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>