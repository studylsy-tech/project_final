<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet"
	href="${path}/resources/css/views/board/board.css">

<div class="board-wrapper">
	<div class="board-title-area">
		<h2>공지사항</h2>
		<p>플랫폼의 새로운 소식을 전해드립니다.</p>
	</div>
	
<!-- 검색기능(수정 파악 쉽게 주석처리, 끝나면 제거 예정) -->
	<div class="board-search">
	    <select id="searchType" name="searchType">
	        <option value="t" <c:out value="${pageMaker.cri.searchType == 't' ? 'selected':''}"/>>제목</option>
	        <option value="c" <c:out value="${pageMaker.cri.searchType == 'c' ? 'selected':''}"/>>내용</option>
	        <option value="tc" <c:out value="${pageMaker.cri.searchType == 'tc' ? 'selected':''}"/>>제목+내용</option>
	    </select>
	    
	    <input type="text" id="keywordInput" name="keyword" 
	           value="${pageMaker.cri.keyword}" placeholder="검색어 입력">
	    
	    <button id="searchBtn">검색</button>
	</div>

<script>
	$(function() {
	    // 검색 버튼 클릭 시
	    $('#searchBtn').on("click", function(event) {
	        var sType = $("#searchType").val();
	        var sKeyword = $('#keywordInput').val();
	        
	        var url = "noticeListPaging?page=1&perPageNum=10"
	                + "&searchType=" + sType 
	                + "&keyword=" + encodeURIComponent(sKeyword);
	        
	        self.location = url;
	    });
	
	    // 엔터키 지원
	    $('#keywordInput').on("keydown", function(event) {
	        if (event.keyCode === 13) {
	            $('#searchBtn').click();
	        }
	    });
	});
</script>
<!-- 검색기능 끝(수정 파악 쉽게 주석처리, 끝나면 제거 예정) -->

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
							<%-- IDENTITY COLUMN으로 생성된 번호 출력 --%>
							<td>${board.notice_no}</td>
							<td class="title-cell text-left">
								<%-- 상세 페이지 이동 시 notice_no 파라미터 전달 --%> <a
								href="${path}/board/detail?notice_no=${board.notice_no}"> <c:if
										test="${board.board_type == 'NOTICE'}">
										<span class="badge badge-notice bg-red"
											style="margin-right: 5px;">공지</span>
									</c:if> <c:out value="${board.title}" />
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
						<td colspan="5" style="text-align: center; padding: 50px 0;">등록된
							공지사항이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>

	<!-- 페이징 -->
	<div class="pagination-area" style="text-align: center;">
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li><a
					href="noticeListPaging${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
			</c:if>

			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
				var="idx">
				<li
					<c:out value="${pageMaker.cri.page == idx ? 'class=active' : ''}"/>>
					<a href="noticeListPaging${pageMaker.makeSearch(idx)}">${idx}</a>
				</li>
			</c:forEach>

			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<li><a
					href="noticeListPaging${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
			</c:if>
		</ul>
	</div>

	<%-- 관리자(ADMIN) 권한 확인 후 등록 버튼 노출 --%>
	<c:if test="${loginUser.memberType == 'ADMIN'}">
		<div class="board-footer" style="text-align: right; margin-top: 20px;">
			<a href="${path}/board/write?type=NOTICE" class="btn-dark">공지등록</a>
		</div>
	</c:if>

	</ul>
</div>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>