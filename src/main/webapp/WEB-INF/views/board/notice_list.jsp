<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/css/views/board/notice_list.css">

<div class="board-wrapper">
	<div class="board-title-area">
		<h2>공지사항</h2>
		<p>플랫폼의 새로운 소식을 전해드립니다.</p>
	</div>

	<table class="board-table">
		<thead>
			<tr>
				<th style="width: 10%;">번호</th>
				<th style="width: 50%;">제목</th>
				<th style="width: 15%;">작성자</th>
				<th style="width: 15%;">날짜</th>
				<th style="width: 10%;">조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty list}">
					<c:forEach var="board" items="${list}">
						<tr>
							<%-- 소문자 필드명으로 수정 --%>
							<td>${board.notice_no}</td>
							<td class="title-cell text-left">
								<a href="${path}/board/detail?notice_no=${board.notice_no}"> 
									<c:if test="${board.board_type == 'NOTICE'}">
										<span class="badge badge-notice bg-red" style="margin-right: 5px;">공지</span>
									</c:if> 
									<c:out value="${board.title}" />
								</a>
							</td>
							<td>${board.writer}</td>
							<td>${board.indate}</td>
							<td>${board.count}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="5" style="text-align: center; padding: 50px 0;">등록된 공지사항이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>

	<div class="pagination-area" style="text-align: center; margin-top: 30px;">
		<ul class="pagination" style="display: inline-flex; list-style: none; padding: 0;">
			<c:if test="${pageMaker.prev}">
				<li style="margin: 0 5px;">
					<a href="${path}/board/notice${pageMaker.query(pageMaker.startPage - 1)}">이전</a>
				</li>
			</c:if>

			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				<li style="margin: 0 5px;">
					<a href="${path}/board/notice${pageMaker.query(idx)}" 
					   style="${pageMaker.cri.page == idx ? 'font-weight: bold; color: red;' : 'color: #333;'}">
					    ${idx}
					</a>
				</li>
			</c:forEach>

			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<li style="margin: 0 5px;">
					<a href="${path}/board/notice${pageMaker.query(pageMaker.endPage + 1)}">다음</a>
				</li>
			</c:if>
		</ul>
	</div>
	
	<!-- 검색기능 -->
	<div class="search-box">
	    <select name="searchType" id="searchTypeSelect">
	        <option value="t" ${pageMaker.cri.searchType eq 't' ? 'selected' : ''}>제목</option>
	        <option value="c" ${pageMaker.cri.searchType eq 'c' ? 'selected' : ''}>내용</option>
	        <option value="tc" ${pageMaker.cri.searchType eq 'tc' ? 'selected' : ''}>제목+내용</option>
	    </select>
	    
	    <input type="text" name="keyword" id="keywordInput" value="${pageMaker.cri.keyword}" placeholder="공지 검색어 입력">
	    <button id="searchBtn" class="btn-dark">검색</button>
	</div>
	
<script>
    $(function(){
        $('#searchBtn').on("click", function(event){
            // 주소를 noticeListPaging에서 notice로 변경!
            var url = "notice?page=1"; 
            
            url += "&perPageNum=${pageMaker.cri.perPageNum}";
            url += "&searchType=" + $("#searchTypeSelect").val();
            url += "&keyword=" + encodeURIComponent($('#keywordInput').val());
            
            self.location = url;
        });
    });
</script>	
	
	<c:if test="${loginUser.memberType == 'ADMIN'}">
		<div class="board-footer" style="text-align: right; margin-top: 20px;">
			<a href="${path}/board/write?type=NOTICE" class="btn-dark">공지등록</a>
		</div>
	</c:if>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>