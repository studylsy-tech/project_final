<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<link rel="stylesheet" href="${path}/resources/css/views/board/write.css">

<div class="board-wrapper" style="padding: 50px 0; max-width: 800px; margin: 0 auto;">
    <div class="board-title-area">
        <h2>문의사항 답변하기</h2>
        <p style="color: #666;">원글의 내용을 확인하고 답변을 작성해 주세요.</p>
    </div>
    <hr style="margin: 20px 0; border: 0; border-top: 1px solid #eee;">

    <form action="${path}/board/write" method="post">
    <input type="hidden" name="board_type" value="QNA">
    
    <%-- [수정] re_ref 대신 parent_no라는 이름으로 보냅니다 --%>
    <input type="hidden" name="parent_no" value="${parentBoard.notice_no}">
    
    <%-- [추가] 답변이므로 is_reply 값을 1로 보냅니다 --%>
    <input type="hidden" name="is_reply" value="1">
    
    <table class="board-table" style="width: 100%; border-collapse: collapse;">
            <tr>
                <th style="width: 20%; padding: 15px; background: #f0f0f0; border-bottom: 1px solid #ddd; text-align: left;">원글 내용</th>
                <td style="padding: 15px; border-bottom: 1px solid #ddd; background: #fafafa; font-size: 0.9em; color: #555;">
                    <%-- 게시글 번호 표시 추가 --%>
                    <strong>[게시글 번호]:</strong> ${parentBoard.notice_no}<br>
                    <strong>[질문자]:</strong> ${parentBoard.writer}<br>
                    <strong>[제목]:</strong> ${parentBoard.title}
                    <div style="margin-top:10px; padding:10px; background:#fff; border:1px solid #eee; white-space: pre-wrap;">${parentBoard.content}</div>
                </td>
            </tr>
            <tr>
                <th style="padding: 15px; background: #f9f9f9; border-bottom: 1px solid #ddd; text-align: left;">답변자</th>
                <td style="padding: 10px; border-bottom: 1px solid #ddd;">
                    <input type="text" name="writer" value="${loginUser.nickname}" 
                           class="form-control" readonly 
                           style="width: 100%; border: 1px solid #ccc; padding: 8px; background: #eee;">
                </td>
            </tr>
            <tr>
                <th style="padding: 15px; background: #f9f9f9; border-bottom: 1px solid #ddd; text-align: left;">답변 제목</th>
                <td style="padding: 10px; border-bottom: 1px solid #ddd;">
                    <input type="text" name="title" class="form-control" 
                           value="[답변] ${parentBoard.title}" required
                           style="width: 100%; border: 1px solid #ccc; padding: 8px;">
                </td>
            </tr>
            <tr>
                <th style="padding: 15px; background: #f9f9f9; border-bottom: 1px solid #ddd; text-align: left;">답변 내용</th>
                <td style="padding: 10px; border-bottom: 1px solid #ddd;">
                    <textarea name="content" rows="12" class="form-control" required 
                              style="width: 100%; border: 1px solid #ccc; padding: 10px; resize: none;">안녕하세요. 관리자입니다.&#10;&#10;</textarea>
                </td>
            </tr>
        </table>

        <div class="board-footer" style="margin-top: 30px; text-align: center; display: flex; gap: 10px; justify-content: center;">
            <button type="submit" class="btn-dark" style="padding: 10px 30px; background: #333; color: #fff; border: none; cursor: pointer;">답변 등록</button>
            <button type="button" class="btn-secondary" onclick="history.back();" style="padding: 10px 30px; background: #ccc; color: #333; border: none; cursor: pointer;">취소</button>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>