<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<style>
    /* 표를 예쁘게 만들기 위한 스타일 */
    table { width: 100%; border-collapse: collapse; }
    th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
    th { background-color: #333; color: white; }
</style>
</head>
<body>

    <h2>📩 접수된 문의 목록</h2>

    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>성함</th>
                <th>내용</th>
            </tr>
        </thead>
        <tbody>
            
            </tbody>
            <c:forEach var="item" items="${inquiryList}">
        <tr>
            <td>${item.inquiry_no}</td>
            
            <td><strong>${item.user_name}</strong></td>
            
            <td>${item.user_email}</td>
            
            <td>${item.user_content}</td>
            
            <td>${item.is_answered}</td>
            
            <td>${item.reg_date}</td>
        </tr>
    </c:forEach>
    </table>

    <br>
    <a href="${pageContext.request.contextPath}/">메인 화면으로 가기</a>

</body>
</html>