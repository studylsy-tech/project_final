<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - 알림 설정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/views/member/join_full.css">
    <style>
        /* 탭 메뉴 스타일: join_semi/full 디자인 차용 */
        .tab-container {
            display: flex;
            margin-bottom: 30px;
            border-bottom: 2px solid #eee;
        }
        .tab-item {
            flex: 1;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            font-size: 16px;
            color: #666;
        }
        .tab-item.active {
            border-bottom: 3px solid #007bff;
            color: #007bff;
            font-weight: bold;
        }
        .setting-section {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
        }
        .slot-info {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
        }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: bold; }
        .checkbox-group { display: flex; flex-direction: column; gap: 10px; }
        .checkbox-item { display: flex; align-items: center; gap: 10px; }
        .btn-save {
            width: 100%;
            padding: 15px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header_user.jsp" />

    <div class="container">
        <h2>마이페이지</h2>

        <div class="tab-container">
            <div class="tab-item" onclick="location.href='info.do'">내 정보 확인</div>
            <div class="tab-item active" onclick="location.href='notification.do'">알림 설정</div>
        </div>

        <div class="setting-section">
            <div class="slot-info">
                <span>🔔 알림 잔여 슬롯</span>
                <strong>7 / 10 <small style="color:#888; font-weight:normal;">(쿠폰 사용 시 확장 가능)</small></strong>
            </div>

            <form action="updateNotification.do" method="post">
                <div class="form-group">
                    <label>수신 이메일 주소</label>
                    <input type="email" name="email" value="user@example.com" class="input-field" placeholder="알림을 받을 이메일을 입력하세요">
                </div>

                <div class="form-group">
                    <label>알림 유형 선택</label>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" id="opt1" name="notif_type" checked>
                            <label for="opt1">목표가 도달 알림</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="opt2" name="notif_type" checked>
                            <label for="opt2">최저가 갱신 알림 (역대)</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="opt3" name="notif_type">
                            <label for="opt3">주간 가격 요약 리포트</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="opt4" name="notif_type">
                            <label for="opt4">마케팅 이벤트 알림</label>
                        </div>
                    </div>
                </div>

                <button type="button" class="btn-save">변경 사항 저장</button>
            </form>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>