<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%-- 전용 CSS 연결 --%>
<link rel="stylesheet" href="${path}/resources/css/views/dashboard/add_product.css">

<div class="add-container">
    <h2>관심 상품 등록</h2>

    <%-- ② URL 자동 분석 결과 영역 스타일 --%>
    <div class="product-info-box">
        <p><strong>상품명:</strong> ${selectedProduct.name}</p>
        <p><strong>현재가:</strong> ${selectedProduct.price}원</p>
        <p><strong>상품코드:</strong> ${selectedProduct.prodCode}</p>
    </div>

    <form action="${path}/dashboard/register" method="post">
        <input type="hidden" name="prodCode" value="${selectedProduct.prodCode}">
        <input type="hidden" name="name" value="${selectedProduct.name}">
        <input type="hidden" name="price" value="${selectedProduct.price}">
        
        <div class="form-group">
            <label>③ 목표 가격 설정</label>
            <input type="number" name="targetPrice" placeholder="원하는 가격을 입력하세요" required>
        </div>

        <div class="form-group">
            <label>④ 확인 주기</label>
            <select name="checkInterval">
                <option value="1">1시간</option>
                <option value="6" selected>6시간</option>
                <option value="12">12시간</option>
                <option value="24">1일</option>
            </select>
        </div>

        <%-- ⑤ 등록 완료 버튼 --%>
        <button type="submit" class="submit-btn">등록 완료 - 가격 추적 시작</button>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>