<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<link rel="stylesheet" href="${path}/resources/css/views/board/board.css">

<div class="board-wrapper" style="padding: 50px 0; max-width: 800px; margin: 0 auto;">
    <div class="board-title-area">
        <%-- board_type에 따른 동적 제목 출력 --%>
        <h2>${board_type eq 'NOTICE' ? '공지사항 작성' : '1:1 문의하기'}</h2>
        <p style="color: #666;">
            ${board_type eq 'NOTICE' ? '서비스의 새로운 소식을 등록합니다.' : '궁금하신 내용을 남겨주시면 정성껏 답변해 드립니다.'}
        </p>
    </div>
    <hr style="margin: 20px 0; border: 0; border-top: 1px solid #eee;">

    <%-- 통합 @PostMapping("/write")로 데이터 전송 --%>
    <form action="${path}/board/write" method="post">
        <%-- 중요: BoardDTO의 board_type 필드에 매핑됨 --%>
        <input type="hidden" name="board_type" value="${board_type}">
        
        <table class="board-table" style="width: 100%; border-collapse: collapse;">
            <tr>
                <th style="width: 20%; padding: 15px; background: #f9f9f9; border-bottom: 1px solid #ddd; text-align: left;">작성자</th>
                <td style="padding: 10px; border-bottom: 1px solid #ddd;">
                    <%-- 세션의 nickname을 writer 필드에 매핑 --%>
                    <input type="text" name="writer" value="${loginUser.nickname}" 
                           class="form-control" readonly 
                           style="width: 100%; border: 1px solid #ccc; padding: 8px; background: #eee;">
                </td>
            </tr>
            <tr>
                <th style="padding: 15px; background: #f9f9f9; border-bottom: 1px solid #ddd; text-align: left;">제목</th>
                <td style="padding: 10px; border-bottom: 1px solid #ddd;">
                    <input type="text" name="title" class="form-control" 
                           placeholder="제목을 입력하세요" required
                           style="width: 100%; border: 1px solid #ccc; padding: 8px;">
                </td>
            </tr>
            <tr>
                <th style="padding: 15px; background: #f9f9f9; border-bottom: 1px solid #ddd; text-align: left;">내용</th>
                <td style="padding: 10px; border-bottom: 1px solid #ddd;">
                    <textarea name="content" rows="15" class="form-control" 
                              placeholder="내용을 입력하세요" required 
                              style="width: 100%; border: 1px solid #ccc; padding: 10px; resize: none;"></textarea>
                </td>
            </tr>
        </table>

        <div class="board-footer" style="margin-top: 30px; text-align: center; display: flex; gap: 10px; justify-content: center;">
            <button type="submit" class="btn-dark" 
                    style="padding: 10px 30px; background: #333; color: #fff; border: none; cursor: pointer;">
                ${board_type eq 'NOTICE' ? '공지 등록' : '문의 등록'}
            </button>
            <button type="button" class="btn-secondary" onclick="history.back();"
                    style="padding: 10px 30px; background: #ccc; color: #333; border: none; cursor: pointer;">
                취소
            </button>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>