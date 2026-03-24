<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Price Tracking Platform</title>
    
    <link rel="stylesheet" href="${path}/resources/css/views/common/header.css">
</head>
<body>

<header class="header-container">
    <div class="logo">
        <h1><a href="${path}/">Price Tracking Platform</a></h1>
    </div>
    
    <nav class="nav-menu">
        <c:choose>
            <c:when test="${empty sessionScope.loginUser}">
                <jsp:include page="/WEB-INF/views/common/header_guest.jsp" />
            </c:when>
            <c:otherwise>
                <jsp:include page="/WEB-INF/views/common/header_user.jsp" />
            </c:otherwise>
        </c:choose>
    </nav>
</header>