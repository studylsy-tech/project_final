<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- CSS 경로는 반드시 컨텍스트 패스(${path})를 포함해야 합니다 --%>
<link rel="stylesheet" href="${path}/resources/css/views/common/footer.css">

<footer class="footer">
    <div class="footer-links">
        <a href="${path}/footer/terms.do">서비스 이용약관</a> | 
        <a href="${path}/footer/privacy.do">개인정보 처리방침</a> | 
        <a href="${path}/footer/support.do">고객센터</a>
    </div>
    
    <div class="copyright">
        &copy; 2026 Price Tracking Platform. All rights reserved.<br>
        팀 프로젝트: 가격 추적 서비스 | 부산광역시...
    </div>
</footer>

<%-- 여기서 footer.jsp를 또 include하면 안 됩니다 --%>
</body>
</html>