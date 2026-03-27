<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>inquiryDetail.jsp</title>
</head>
<body>
	<div class="inquiry-container">
    <h2>나의 문의 내역</h2>
    
    <div class="user-section">
        <p><strong>작성자:</strong> ${inquiry.user_name}</p>
        <p><strong>문의내용:</strong></p>
        <div class="content-box">${inquiry.user_content}</div>
    </div>

    <hr>

    <div class="admin-section">
        <p><strong>관리자 답변:</strong></p>
        <c:choose>
            <c:when test="${not empty inquiry.reply_content}">
                <div class="reply-box" style="background:#f9f9f9; padding:15px;">
                    ${inquiry.reply_content}
                </div>
            </c:when>
            <c:otherwise>
                <p style="color:gray;">아직 답변이 등록되지 않았습니다.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="re-reply-section" style="margin-top:30px;">
        <form action="addFollowUp.do" method="post">
            <input type="hidden" name="inquiry_no" value="${inquiry.inquiry_no}">
            <textarea name="user_content" placeholder="추가로 궁금한 점을 남겨주세요." style="width:100%; height:100px;"></textarea>
            <button type="submit">추가 문의하기</button>
        </form>
    </div>
</div>


</body>
</html>