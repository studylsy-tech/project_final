<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/css/views/member/info.css">
<link rel="stylesheet" href="${path}/resources/css/admin/notice_manage.css">

<div class="mypage-wrapper">
    <div class="mypage-header">
        <h2 class="main-title">마이페이지</h2>
        <div class="tab-container">
            <a href="${path}/member/info" class="tab-item">내 정보 확인</a>
            <a href="${path}/member/notification" class="tab-item">알림 설정</a>
            <a href="${path}/admin/main" class="tab-item admin-tab active">관리자 모드</a>
        </div>
    </div>

    <div class="info-content-box">
        <div class="admin-wrapper">
            <div class="admin-header" style="display: flex; justify-content: space-between; align-items: center;">
                <h3 class="settings-title">공지사항 관리</h3>
                <button class="btn-primary" onclick="location.href='${path}/board/write?type=NOTICE'">신규 등록</button>
            </div>

            <div class="panel-card">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>등록일</th>
                            <th>조회수</th>
                            <th>상태 제어</th>
                        </tr>
                    </thead>
                    <tbody>
    <c:forEach var="notice" items="${noticeList}">
        <tr class="notice-row">
            <td>${notice.notice_no}</td>
            <td onclick="toggleContent(${notice.notice_no})" style="cursor:pointer; text-align: left; font-weight: 500;">
                <c:out value="${notice.title}"/>
                <span id="arrow-${notice.notice_no}" style="font-size: 0.7em; margin-left: 8px; color: #888;">▼</span>
            </td>
            <td>${notice.indate}</td>
            <td>${notice.count}</td>
            <td>
                <button type="button" 
                        onclick="changeStatus(${notice.notice_no}, '${notice.status}')"
                        style="border:none; border-radius:20px; padding:6px 15px; cursor:pointer; font-weight:bold; color:white; min-width:80px;
                               background-color:${notice.status == 'Y' ? '#28a745' : '#6c757d'};">
                    ${notice.status == 'Y' ? '게시중' : '정지됨'}
                </button>
            </td>
        </tr>
        
        <tr id="content-${notice.notice_no}" class="content-row" style="display:none; background-color: #fcfcfc;">
            <td colspan="5" style="padding: 25px 40px; text-align: left; border-bottom: 1px solid #eee; line-height: 1.8;">
                <div class="content-viewer" style="color: #444; font-size: 0.95em; min-height: 50px; white-space: pre-wrap;"><c:out value="${notice.content}"/></div>
            </td>
        </tr>
    </c:forEach>
</tbody>
                </table>
            </div>

            <%-- 페이징: 테이블 하단에 안정적으로 배치 --%>
            <div class="pagination-container" style="text-align: center; margin-top: 30px;">
                <ul class="pagination" style="display: inline-flex; list-style: none; padding: 0;">
                    <c:if test="${pm.prev}">
                        <li><a href="${path}/admin/notice_manage${pm.makeSearch(pm.startPage - 1)}" style="padding: 8px 12px; border: 1px solid #ddd; margin: 0 2px; text-decoration: none; color: #333;">이전</a></li>
                    </c:if>
                    <c:forEach var="idx" begin="${pm.startPage}" end="${pm.endPage}">
                        <li>
                            <a href="${path}/admin/notice_manage${pm.makeSearch(idx)}" 
                               style="${pm.cri.page == idx ? 'background-color: #007bff; color: white; border-color: #007bff;' : ''} padding: 8px 14px; border: 1px solid #ddd; margin: 0 2px; text-decoration: none; color: #333; font-weight: bold;">
                               ${idx}
                            </a>
                        </li>
                    </c:forEach>
                    <c:if test="${pm.next}">
                        <li><a href="${path}/admin/notice_manage${pm.makeSearch(pm.endPage + 1)}" style="padding: 8px 12px; border: 1px solid #ddd; margin: 0 2px; text-decoration: none; color: #333;">다음</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>

<script>
/**
 * 공지사항 게시 상태 변경 함수
 * @param no 게시글 번호
 * @param currentStatus 현재 상태 (Y: 게시중, N: 숨김)
 */
function changeStatus(no, currentStatus) {
    const nextStatus = (currentStatus === 'Y') ? 'N' : 'Y';
    const confirmMsg = nextStatus === 'Y' ? "해당 공지를 다시 '게시' 하시겠습니까?" : "해당 공지를 '정지' 처리하여 숨기시겠습니까?";
    
    if(confirm(confirmMsg)) {
        // 현재 페이지와 검색 조건을 유지하며 상태 업데이트 요청
        location.href = "${path}/admin/updateNoticeStatus?notice_no=" + no + "&status=" + nextStatus + "&page=${pm.cri.page}";
    }
}
/**
 * 게시글 내용 토글 함수
 * @param no 게시글 번호
 */
function toggleContent(no) {
    const contentRow = document.getElementById('content-' + no);
    const arrow = document.getElementById('arrow-' + no);
    
    if (contentRow.style.display === 'none') {
        // 열기: 다른 열려있는 내용이 있다면 닫고 싶을 때 (선택 사항)
        // document.querySelectorAll('.content-row').forEach(row => row.style.display = 'none');
        
        contentRow.style.display = 'table-row';
        arrow.innerText = '▲';
        contentRow.style.animation = 'fadeIn 0.3s'; // 부드러운 효과 (CSS 필요)
    } else {
        // 닫기
        contentRow.style.display = 'none';
        arrow.innerText = '▼';
    }
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>