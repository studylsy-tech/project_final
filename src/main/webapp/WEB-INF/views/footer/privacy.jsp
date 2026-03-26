<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 공통 헤더 포함 --%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
    /* 전체 컨테이너 및 폰트 설정 */
    .privacy-container {
        max-width: 900px;
        margin: 50px auto;
        padding: 0 20px;
        font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, sans-serif;
        line-height: 1.8;
        color: #333;
    }

    /* 제목 및 날짜 */
    .privacy-container h1 {
        font-size: 2.2rem;
        color: #1a2a44;
        text-align: center;
        margin-bottom: 10px;
    }
    .privacy-container .date {
        text-align: right;
        color: #888;
        font-size: 0.9rem;
        margin-bottom: 30px;
        border-bottom: 1px solid #eee;
        padding-bottom: 10px;
    }

    /* 목차 디자인 */
    .toc-box {
        background-color: #f8f9fa;
        border: 1px solid #e9ecef;
        border-radius: 8px;
        padding: 25px;
        margin: 40px 0;
    }
    .toc-box h2 { font-size: 1.1rem; margin-top: 0; margin-bottom: 15px; border: none; padding: 0; }
    .toc {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 10px 20px;
        padding-left: 20px;
        margin: 0;
    }
    .toc li a { text-decoration: none; color: #4a90e2; font-size: 0.9rem; }
    .toc li a:hover { text-decoration: underline; }

    /* 섹션 제목 스타일 */
    section { margin-bottom: 70px; }
    section h2 {
        font-size: 1.4rem;
        color: #1a2a44;
        border-left: 5px solid #1a2a44;
        padding: 8px 15px;
        margin-bottom: 25px;
        background-color: #f1f4f9;
    }
    section h3 {
        font-size: 1.1rem;
        color: #333;
        margin-top: 30px;
        margin-bottom: 15px;
    }

    /* 표(Table) 스타일 - 가독성 핵심: 1px 선 */
    .privacy-table {
        width: 100%;
        border-collapse: collapse;
        margin: 15px 0;
        font-size: 0.9rem;
    }
    .privacy-table th, .privacy-table td {
        border: 1px solid #ddd; /* 1px 선 */
        padding: 12px 15px;
        text-align: left;
    }
    .privacy-table th {
        background-color: #f8f9fa;
        color: #555;
        font-weight: 600;
        width: 25%;
        text-align: center;
    }

    /* 강조 텍스트 */
    .highlight { color: #e74c3c; font-weight: bold; }

    /* 라벨링 영역 */
    .privacy-labels {
        background-color: #f1f3f5;
        padding: 20px;
        border-radius: 6px;
        margin: 30px 0;
        font-size: 0.85rem;
        text-align: center;
    }

    /* 버튼 영역 */
    .back-btn-area { text-align: center; margin-top: 50px; padding-top: 30px; border-top: 1px solid #eee; }
    .btn-back {
        background-color: #1a2a44;
        color: #fff;
        padding: 12px 40px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-weight: 600;
    }

    @media (max-width: 768px) {
        .toc { grid-template-columns: 1fr; }
        .privacy-table th { width: 35%; }
    }
</style>

<div class="privacy-container">
    <h1>개인정보 처리방침</h1>
    <p class="date">시행일자: 2026년 3월 25일</p>

    <div class="intro">
        <p>
            <strong>Price Tracking Platform</strong>(이하 “본 서비스”)은(는) 정보주체의 자유와 권리 보호를 위해 
            ｢개인정보 보호법｣ 및 관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다. 
        </p>
    </div>

    <div class="privacy-labels">
        <strong>[주요 개인정보 처리 표시]</strong><br>
        일반 개인정보 수집　｜　개인정보 처리 목적　｜　개인정보의 보유 기간　｜　개인정보의 제공　｜　처리위탁　｜　고충처리부서
    </div>

    <div class="toc-box">
        <h2>목차</h2>
        <ul class="toc">
            <li><a href="#section1">1. 처리 목적, 항목, 기간</a></li>
            <li><a href="#section2">2. 자동 수집 장치의 운영</a></li>
            <li><a href="#section3">3. 14세 미만 아동의 정보</a></li>
            <li><a href="#section4">4. 행태정보 수집 및 거부</a></li>
            <li><a href="#section5">5. 개인정보의 제3자 제공</a></li>
            <li><a href="#section6">6. 정보주체의 권리·의무</a></li>
            <li><a href="#section7">7. 추가 이용·제공 기준</a></li>
            <li><a href="#section8">8. 자동화된 결정</a></li>
            <li><a href="#section9">9. 개인정보 처리 업무 위탁</a></li>
            <li><a href="#section10">10. 안전성 확보 조치</a></li>
            <li><a href="#section11">11. 국외 수집 및 이전</a></li>
            <li><a href="#section12">12. 보호책임자 및 고충처리</a></li>
            <li><a href="#section13">13. 파기 절차 및 방법</a></li>
            <li><a href="#section14">14. 가명정보의 처리</a></li>
            <li><a href="#section15">15. 개인정보 처리방침 변경</a></li>
        </ul>
    </div>

    <!-- 1. 개인정보의 처리 목적, 수집 항목, 보유기간 -->
    <section id="section1">
        <h2>1. 개인정보의 처리 목적, 수집 항목, 보유기간</h2>
        <p>본 서비스는 서비스 제공을 위해 최소한의 범위에서 개인정보를 수집·이용합니다.</p>
        
        <table class="privacy-table">
            <thead>
                <tr>
                    <th>구분</th>
                    <th>처리 목적</th>
                    <th>수집 항목</th>
                    <th>보유 및 이용기간</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th>필수 처리 (법적근거)</th>
                    <td>회원 가입·관리, 가격 알림 서비스 제공</td>
                    <td>이메일, 비밀번호, 이름, 접속로그</td>
                    <td><span class="highlight">회원 탈퇴 시까지</span></td>
                </tr>
                <tr>
                    <th>선택 처리 (동의기반)</th>
                    <td>관심 상품 추천, 맞춤형 상담 서비스</td>
                    <td>휴대폰 번호, 관심 카테고리, 배송 주소</td>
                    <td><span class="highlight">동의 철회 또는 탈퇴 시</span></td>
                </tr>
            </tbody>
        </table>
    </section>

    <!-- 2. 쿠키 운영 -->
    <section id="section2">
        <h2>2. 개인정보 자동 수집 장치의 설치·운영 및 거부</h2>
        <p>본 서비스는 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용합니다.</p>
        <p><strong>거부 방법:</strong> 브라우저 설정(Chrome) > 개인정보 및 보안 > 쿠키 차단 설정을 통해 거부할 수 있습니다.</p>
    </section>

    <!-- 3. 아동 정보 -->
    <section id="section3">
        <h2>3. 14세 미만 아동의 개인정보 처리</h2>
        <p>본 서비스는 만 14세 미만 아동의 개인정보를 원칙적으로 수집하지 않습니다. 필요 시 법정대리인의 동의를 별도로 구합니다.</p>
    </section>

    <!-- 4. 행태정보 -->
    <section id="section4">
        <h2>4. 행태정보의 수집·이용·제공 및 거부 등에 관한 사항</h2>
        <table class="privacy-table">
            <tr>
                <th>수집 항목</th>
                <td>상품 조회·검색 기록, 관심 카테고리, 가격 알림 설정값</td>
            </tr>
            <tr>
                <th>수집 목적</th>
                <td>맞춤형 가격 변동 알림 및 상품 추천 서비스 제공</td>
            </tr>
            <tr>
                <th>보유 기간</th>
                <td><span class="highlight">회원 탈퇴 시까지</span></td>
            </tr>
        </table>
    </section>

    <!-- 5. 제3자 제공 -->
    <section id="section5">
        <h2>5. 개인정보의 제3자 제공</h2>
        <p>원칙적으로 정보주체의 동의 없이 개인정보를 외부에 제공하지 않습니다. 단, 법령에 따른 요구가 있을 경우 예외로 합니다.</p>
    </section>

    <!-- 6. 권리행사 -->
    <section id="section6">
        <h2>6. 정보주체와 법정대리인의 권리·의무 및 행사방법</h2>
        <p>정보주체는 언제든지 열람, 정정, 삭제, 처리정지를 요구할 수 있습니다. 마이페이지 또는 고객센터를 통해 신청 가능합니다.</p>
    </section>

    <!-- 7~8. 기타 기준 -->
    <section id="section7">
        <h2>7. 추가적인 이용·제공 판단 기준</h2>
        <p>당초 수집 목적과 밀접한 관련성이 있고 정보주체에게 불이익이 없는 경우에 한해 추가 이용이 가능합니다.</p>
    </section>

    <section id="section8">
        <h2>8. 자동화된 결정</h2>
        <p>현재 AI를 활용한 자동화된 결정(프로파일링 등)으로 법적 효력을 발생하는 처리는 수행하지 않고 있습니다.</p>
    </section>

    <!-- 9. 위탁 -->
    <section id="section9">
        <h2>9. 개인정보 처리 업무의 위탁</h2>
        <table class="privacy-table">
            <thead>
                <tr>
                    <th>수탁자 (위탁업체)</th>
                    <th>위탁 업무 내용</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Amazon SES / Twilio</td>
                    <td>알림 이메일 및 SMS 발송 대행</td>
                </tr>
                <tr>
                    <td>Google Analytics</td>
                    <td>서비스 이용 통계 분석 (익명화 데이터)</td>
                </tr>
            </tbody>
        </table>
    </section>

    <!-- 10. 안전성 확보 -->
    <section id="section10">
        <h2>10. 개인정보의 안전성 확보조치</h2>
        <p>본 서비스는 개인정보 암호화, 백신 프로그램 설치, 접근 권한의 최소화 등 기술적/관리적 보호 조치를 수행합니다.</p>
    </section>

    <!-- 11. 국외 이전 -->
    <section id="section11">
        <h2>11. 개인정보의 국외 수집 및 이전</h2>
        <p>현재 개인정보를 국외에 저장하거나 이전하지 않습니다. 모든 데이터는 국내 클라우드 서버에서 처리됩니다.</p>
    </section>

    <!-- 12. 보호책임자 -->
    <section id="section12">
        <h2>12. 개인정보 보호책임자 및 고충처리</h2>
        <table class="privacy-table">
            <tr>
                <th>성명 / 직책</th>
                <td>관리자 (팀 프로젝트 마스터)</td>
            </tr>
            <tr>
                <th>연락처 (E-mail)</th>
                <td>webmaster@koreate.net</td>
            </tr>
            <tr>
                <th>담당 부서</th>
                <td>고객지원 및 데이터 보안팀</td>
            </tr>
        </table>
    </section>

    <!-- 13. 파기 -->
    <section id="section13">
        <h2>13. 개인정보의 파기 절차 및 방법</h2>
        <p><strong>절차:</strong> 목적 달성 즉시 DB에서 분리하여 파기합니다.</p>
        <p><strong>방법:</strong> 전자적 파일은 복구가 불가능한 기술적 방법으로 영구 삭제합니다.</p>
    </section>

    <!-- 14. 가명정보 -->
    <section id="section14">
        <h2>14. 가명정보의 처리</h2>
        <p>서비스 개선을 위한 통계 작성 시 특정 개인을 식별할 수 없는 가명정보 상태로 처리하여 활용합니다.</p>
    </section>

    <!-- 15. 변경 -->
    <section id="section15">
        <h2>15. 개인정보 처리방침의 변경</h2>
        <p>이 방침은 2026년 3월 25일부터 적용됩니다. 변경 사항 발생 시 공지사항을 통해 사전에 안내해 드립니다.</p>
    </section>

    <div class="back-btn-area">
        <button onclick="history.back()" class="btn-back"> 뒤로 가기 </button>
    </div>
</div>

<%-- 공통 푸터 포함 --%>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />