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
<%-- 마이페이지 공통 레이아웃을 위해 info.css와 수정 전용 update.css를 모두 로드합니다 --%>
<link rel="stylesheet" href="${path}/resources/css/views/member/info.css">
<link rel="stylesheet" href="${path}/resources/css/views/member/update.css">

<div class="mypage-wrapper">
    <%-- 상단 탭 메뉴 유지 --%>
    <div class="mypage-header">
        <h2 class="main-title">마이페이지</h2>
        <div class="tab-container">
            <a href="${path}/member/info" class="tab-item">내 정보 확인</a>
            <a href="${path}/member/notification" class="tab-item">알림 설정</a>
            <c:if test="${sessionScope.loginUser.memberType eq 'ADMIN'}">
                <a href="${path}/admin/main" class="tab-item admin-tab">관리자 모드</a>
            </c:if>
        </div>
    </div>

    <%-- 정보 수정 본문 --%>
    <div class="info-content-box">
        <div class="edit-header">
            <h3>회원 정보 수정</h3>
            <p>이메일 인증을 통해 본인 확인 후 정보를 수정할 수 있습니다.</p>
        </div>
        <hr>

        <form action="${path}/member/update" method="post">
            <table class="info-table">
                <colgroup>
                    <col style="width: 180px;">
                    <col>
                </colgroup>
                <tbody>
                    <tr>
                        <th>휴대폰 번호 (아이디)</th>
                        <td>
                            <input type="text" name="phone" value="${loginUser.phone}" readonly class="form-control readonly-input">
                        </td>
                    </tr>
                    <tr>
                        <th>비밀번호</th>
                        <td>
                            <input type="password" name="pw" placeholder="새 비밀번호 입력" class="form-control" required>
                        </td>
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
                                <td><input type="email" name="email" value="${loginUser.email}" readonly class="form-control readonly-input"></td>
                            </tr>
                            <tr>
                                <th>주소</th>
                                <td><input type="text" name="address" value="${loginUser.address}" class="form-control"></td>
                            </tr>
                        </c:when>
                    </c:choose>
                </tbody>
            </table>

            <div class="action-buttons" style="margin-top: 30px; justify-content: center;">
                <button type="submit" class="btn-solid">수정 완료</button>
                <button type="button" onclick="history.back()" class="btn-outline">취소</button>
            </div>
            <div class="action-buttons" style="margin-top: 30px; justify-content: center; display: flex; gap: 10px;">
    <button type="submit" class="btn-solid">수정 완료</button>
    <button type="button" onclick="deleteMember()" class="btn-outline" style="color: red; border-color: red;">회원 탈퇴</button>
    <button type="button" onclick="history.back()" class="btn-outline">취소</button>
</div>


        </form>
    </div>
</div>
<script>
function deleteMember() {
    if (confirm("정말로 탈퇴하시겠습니까? 모든 정보가 삭제됩니다.")) {
        location.href = "${path}/member/delete";
    }
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>