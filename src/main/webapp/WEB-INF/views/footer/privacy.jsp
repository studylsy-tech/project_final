<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 공통 헤더 포함 (Spring Boot + JSP 프로젝트 기준) --%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- 개인정보 처리방침 전용 CSS (resources/css/views/footer/privacy.css에 별도 생성 추천) --%>
<link rel="stylesheet" href="${path}/resources/css/views/footer/privacy.css">

<div class="privacy-container">
    <h1>개인정보 처리방침</h1>
    <p class="date">시행일자: 2026년 3월 25일</p>

    <p>
        <strong>Price Tracking Platform</strong>(이하 “본 서비스”)은(는) 정보주체의 자유와 권리 보호를 위해 
        ｢개인정보 보호법｣ 및 관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다. 
        이에 ｢개인정보 보호법｣ 제30조에 따라 정보주체에게 개인정보의 처리와 보호에 관한 절차 및 기준을 안내하고, 
        이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다.
    </p>

    <!-- 주요 개인정보 처리 표시 (라벨링) -->
    <div class="privacy-labels">
        <strong>주요 개인정보 처리 표시</strong><br>
        일반 개인정보 수집　｜　개인정보 처리 목적　｜　개인정보의 보유 기간　｜　개인정보의 제공　｜　처리위탁　｜　고충처리부서
    </div>

    <!-- 목차 (하이퍼링크 적용) -->
    <h2>목차</h2>
    <ul class="toc">
        <li><a href="#section1">1. 개인정보의 처리 목적, 수집 항목, 보유기간</a></li>
        <li><a href="#section2">2. 개인정보 자동 수집 장치의 설치·운영 및 거부</a></li>
        <li><a href="#section3">3. 14세 미만 아동의 개인정보 처리</a></li>
        <li><a href="#section4">4. 행태정보의 수집·이용·제공 및 거부 등에 관한 사항</a></li>
        <li><a href="#section5">5. 개인정보의 제3자 제공</a></li>
        <li><a href="#section6">6. 정보주체와 법정대리인의 권리·의무 및 행사방법</a></li>
        <li><a href="#section7">7. 추가적인 이용·제공 판단 기준</a></li>
        <li><a href="#section8">8. 자동화된 결정</a></li>
        <li><a href="#section9">9. 개인정보 처리 업무의 위탁</a></li>
        <li><a href="#section10">10. 개인정보의 안전성 확보조치</a></li>
        <li><a href="#section11">11. 개인정보의 국외 수집 및 이전</a></li>
        <li><a href="#section12">12. 개인정보 보호책임자와 개인정보 업무 담당부서 및 고충사항을 처리하는 부서</a></li>
        <li><a href="#section13">13. 개인정보의 파기 절차 및 방법</a></li>
        <li><a href="#section14">14. 가명정보의 처리</a></li>
        <li><a href="#section15">15. 개인정보 처리방침의 변경</a></li>
    </ul>

    <!-- 1. 개인정보의 처리 목적, 수집 항목, 보유기간 -->
    <section id="section1">
        <h2>1. 개인정보의 처리 목적, 수집 항목, 보유기간</h2>
        <p>본 서비스(Price Tracking Platform)는 「개인정보 보호법」에 따라 서비스 제공을 위해 필요 최소한의 범위에서 개인정보를 수집·이용합니다.</p>

        <h3>① 정보주체의 동의를 받지 않는 경우 (법적 근거에 따른 처리)</h3>
        <table class="privacy-table">
            <thead>
                <tr>
                    <th>법적 근거</th>
                    <th>처리 목적</th>
                    <th>처리 항목</th>
                    <th>처리 및 보유기간</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>개인정보 보호법 제15조제1항제4호<br>(계약 이행 및 법적 의무 준수)</td>
                    <td>회원 가입·관리, 가격 알림 서비스 제공, 서비스 이용 기록 관리</td>
                    <td>이메일 주소, 비밀번호, 이름, 서비스 이용 기록(IP 주소, 접속 로그)</td>
                    <td>회원 탈퇴 시까지 (법령에 따른 보존 기간 제외)</td>
                </tr>
            </tbody>
        </table>

        <h3>② 정보주체의 동의를 받아 처리하는 개인정보 항목</h3>
        <table class="privacy-table">
            <thead>
                <tr>
                    <th>법적 근거</th>
                    <th>처리 목적</th>
                    <th>처리 항목</th>
                    <th>처리 및 보유기간</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>개인정보 보호법 제15조제1항제1호 (동의)</td>
                    <td>가격 변동 알림, 관심 상품 등록·추천, 고객 상담</td>
                    <td>필수: 이메일, 이름, 비밀번호<br>선택: 휴대폰 번호, 관심 카테고리, 주소(배송 시)</td>
                    <td>회원 탈퇴 시까지</td>
                </tr>
            </tbody>
        </table>

        <h3>③ 서비스 이용 과정에서 자동으로 생성·수집되는 개인정보</h3>
        <p>웹 서비스 이용 과정에서 아래 항목이 자동으로 생성되어 수집될 수 있으며, 수집 거부 시 일부 서비스 이용에 제한이 있을 수 있습니다.</p>
        <ul>
            <li>IP 주소, 쿠키, 서비스 이용 기록, 방문 기록, 불량 이용 기록</li>
            <li>기기 정보(OS 버전, 브라우저 종류, 디바이스 모델)</li>
        </ul>
    </section>

    <!-- 2. 개인정보 자동 수집 장치의 설치·운영 및 거부 -->
    <section id="section2">
        <h2>2. 개인정보 자동 수집 장치의 설치·운영 및 거부</h2>
        <p>본 서비스는 정보주체에게 개별적인 서비스와 편의를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용합니다.</p>
        <p>쿠키는 웹사이트 운영에 이용되는 서버(http)가 정보주체의 브라우저에 보내는 소량의 정보로서 정보주체의 컴퓨터 또는 모바일에 저장되며, 웹사이트 접속 시 정보주체의 브라우저에서 서버로 자동 전송됩니다.</p>
        <p>정보주체는 브라우저 옵션 설정을 통해 쿠키 허용, 차단 등의 설정을 할 수 있습니다.</p>
        <ul>
            <li><strong>Chrome</strong>: 오른쪽 상단 ⋮ → 설정 → 개인정보 보호 및 보안 → 쿠키 및 기타 사이트 데이터</li>
            <li><strong>Edge</strong>: 오른쪽 상단 … → 설정 → 쿠키 및 사이트 권한</li>
        </ul>
    </section>

    <!-- 3. 14세 미만 아동의 개인정보 처리 -->
    <section id="section3">
        <h2>3. 14세 미만 아동의 개인정보 처리</h2>
        <p>본 서비스는 14세 미만 아동을 대상으로 하지 않으며, 만 14세 미만 아동의 개인정보를 수집하지 않습니다. 다만, 법정대리인의 동의가 필요한 경우 법정대리인의 성명, 생년월일, 연락처를 추가로 수집합니다.</p>
    </section>

    <!-- 4. 행태정보의 수집·이용·제공 및 거부 등에 관한 사항 -->
    <section id="section4">
        <h2>4. 행태정보의 수집·이용·제공 및 거부 등에 관한 사항</h2>
        <p>본 서비스는 가격 변동 알림 및 맞춤형 상품 추천을 위해 쿠키를 활용하여 행태정보를 처리합니다.</p>
        <table class="privacy-table">
            <thead>
                <tr>
                    <th>수집 항목</th>
                    <th>수집 목적</th>
                    <th>보유 및 이용기간</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>상품 조회·검색 기록, 관심 카테고리, 가격 알림 설정</td>
                    <td>맞춤형 가격 알림, 추천 서비스 제공</td>
                    <td>회원 탈퇴 시까지</td>
                </tr>
            </tbody>
        </table>
        <p>정보주체는 브라우저 쿠키 설정 변경 또는 앱 설정(광고ID 차단)을 통해 맞춤형 알림을 거부할 수 있습니다.</p>
    </section>

    <!-- 5. 개인정보의 제3자 제공 -->
    <section id="section5">
        <h2>5. 개인정보의 제3자 제공</h2>
        <p>본 서비스는 정보주체의 동의 없이 개인정보를 제3자에게 제공하지 않습니다. 다만, 가격 알림 서비스 제공을 위한 SMS/이메일 발송 시 최소한의 정보만 위탁 처리합니다.</p>
    </section>

    <!-- 6. 정보주체와 법정대리인의 권리·의무 및 행사방법 -->
    <section id="section6">
        <h2>6. 정보주체와 법정대리인의 권리·의무 및 행사방법</h2>
        <p>정보주체는 언제든지 개인정보 열람·정정·삭제·처리정지 및 철회 요구를 할 수 있습니다.</p>
        <p>권리 행사는 본 서비스 앱/웹 → 마이페이지 → ‘내 정보 관리’ 또는 고객센터를 통해 가능합니다.</p>
        <p>처리 결과는 요구일로부터 10일 이내에 회신하겠습니다.</p>
    </section>

    <!-- 7~15. 나머지 섹션 (상거래 서비스에 맞게 간결하게 포함) -->
    <section id="section7"><h2>7. 추가적인 이용·제공 판단 기준</h2><p>법령에 따라 추가 이용·제공 시 수집 목적과의 관련성, 예측 가능성 등을 고려합니다.</p></section>
    <section id="section8"><h2>8. 자동화된 결정</h2><p>현재 본 서비스는 AI 기반 자동화된 결정(가격 예측 등)을 사용하지 않습니다. 향후 도입 시 별도 안내하겠습니다.</p></section>
    <section id="section9"><h2>9. 개인정보 처리 업무의 위탁</h2>
        <p>본 서비스는 원활한 서비스 제공을 위해 다음과 같이 개인정보 처리 업무를 위탁하고 있습니다.</p>
        <table class="privacy-table">
            <thead><tr><th>수탁자</th><th>위탁 업무</th></tr></thead>
            <tbody>
                <tr><td>Amazon SES / Twilio</td><td>가격 알림 이메일·SMS 발송</td></tr>
                <tr><td>Google Analytics</td><td>서비스 이용 통계 분석 (익명화 처리)</td></tr>
            </tbody>
        </table>
    </section>
    <section id="section10"><h2>10. 개인정보의 안전성 확보조치</h2>
        <ul>
            <li>관리적 조치: 내부 관리계획 수립, 정기 직원 교육</li>
            <li>기술적 조치: 개인정보 암호화, 접근통제, 보안프로그램 설치</li>
            <li>물리적 조치: 전산실 접근통제</li>
        </ul>
    </section>
    <section id="section11"><h2>11. 개인정보의 국외 수집 및 이전</h2><p>현재 국외 이전은 없으나, 클라우드 서비스(예: AWS 서울 리전) 사용 시 국내 서버에서만 처리합니다.</p></section>
    <section id="section12"><h2>12. 개인정보 보호책임자와 개인정보 업무 담당부서</h2>
        <p><strong>개인정보 보호책임자</strong><br>
           성명: 관리자 (팀 프로젝트)<br>
           연락처: webmaster@koreate.net<br>
           부서: 고객지원팀</p>
    </section>
    <section id="section13"><h2>13. 개인정보의 파기 절차 및 방법</h2>
        <p>개인정보 보유기간 경과 시 지체 없이 파기합니다. 전자적 파일은 복구 불가능하게 삭제, 종이 문서는 분쇄합니다.</p>
    </section>
    <section id="section14"><h2>14. 가명정보의 처리</h2><p>통계 및 서비스 개선 목적으로 가명처리하여 활용합니다. 가명정보는 별도 DB에 분리 보관합니다.</p></section>
    <section id="section15"><h2>15. 개인정보 처리방침의 변경</h2>
        <p>이 개인정보 처리방침은 2026년 3월 25일부터 적용됩니다. 변경 시 홈페이지 공지사항을 통해 안내하겠습니다.</p>
    </section>

    <div class="back-btn-area">
        <button onclick="history.back()" class="btn-back">뒤로가기</button>
    </div>
</div>

<%-- 공통 푸터 포함 --%>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />