# 🚀 Price-Rader.MALL (득템)
> **"당신의 쇼핑 시간을 0초로, 가격 추적은 득템 레이더에게 맡기세요"**
> 
> 실시간 커뮤니티 핫딜 수집 및 알고리즘 기반 상품 가격 추적 플랫폼입니다.

---

## 📌 프로젝트 소개 (About Us)
Price-Rader.MALL은 정보의 비대칭을 해결하고 소비자에게 최적의 구매 타이밍을 제시하기 위해 기획되었습니다. 주요 커뮤니티의 핫딜 정보를 실시간으로 수집하고, 고유의 가격 분석 알고리즘을 통해 '진짜 할인'을 포착합니다.

### 🎯 주요 타겟
- **고객:** 최저가 검색에 피로감을 느끼는 스마트 쇼퍼
- **개발자:** 대규모 데이터 크롤링과 실시간 데이터 처리에 관심 있는 엔지니어

---

## 🛠 기술 스택 (Tech Stack)

### Backend
- **Core:** Java 11, Spring Framework
- **Persistence:** MyBatis, Oracle DB (JDBC/HikariCP)
- **Library:** JSoup, Selenium (Dynamic Web Scraping)

### Frontend
- **UI/UX:** HTML5, CSS3, JavaScript, jQuery
- **Design:** Bootstrap, Responsive Web Design

### Dev Ops
- **IDE:** STS (Spring Tool Suite) 3
- **Server:** Apache Tomcat 9.0
- **Version Control:** Git, GitHub

---

## ✨ 핵심 기능 (Key Features)

### 🛍 For Customers
- **실시간 인기 핫딜:** 뽐뿌, 개드립, FM코리아 등 주요 커뮤니티 핫딜 통합 큐레이션.
- **급락순위 시스템:** 이전 가격 대비 할인율이 가장 높은 상품을 우선순위로 노출.
- **라이브 전광판:** 역대 최저가가 경신되는 순간 상단 배너를 통해 실시간 알림 제공.

### 💻 For Developers
- **복합 크롤링 엔진:** 정적 페이지(JSoup)와 동적 페이지(Selenium)를 모두 지원하는 수집 로직.
- **데이터 정문화:** 서로 다른 커뮤니티의 데이터를 단일 스키마로 표준화하여 관리.
- **시스템 최적화:** 대용량 데이터 로딩 시의 병목 현상을 해결하기 위한 서버 튜닝.

---

## 🔍 트러블슈팅 (Troubleshooting)

### ⚠️ Tomcat Timeout Issue
- **문제:** 프로젝트 규모 확장 및 라이브러리 로딩 지연으로 인해 서버 구동 시 45초 타임아웃 에러 발생.
- **해결:** `Servers` 설정에서 `Start timeout`을 180초로 상향 조정하여 안정적인 구동 환경 확보.

### ⚠️ Data Consistency
- **문제:** 크롤링 대상 사이트의 UI 변경 시 데이터 유실 위험.
- **해결:** Selector 기반의 유연한 파싱 로직 설계 및 예외 처리 구문 강화.

---

## 👤 팀 정보 및 역할 (Team & Role)
- **Developer:** SoShim (소심)
- **Main Role:** - 백엔드 인프라 설계 및 Footer/Inquiry 시스템 구축
  - 실시간 가격 변동 데이터베이스 스키마 설계 및 관리
  - 1:1 고객 문의 시스템 로직 구현

---

© 2026 Price-Rader.MALL. All Rights Reserved.

© 2026 Price-Rader.MALL. All Rights Reserved.

🚀 Price-Rader.MALL (Deuk-Tem)
"Reduce your shopping time to zero. Leave the price tracking to the Deuk-Tem Radar."

A real-time community hot-deal aggregation and algorithm-based price tracking platform.

📌 Project Overview (About Us)
Price-Rader.MALL was designed to resolve information asymmetry in the market and provide consumers with the optimal purchasing timing.

By collecting hot-deal information from major communities in real-time, we capture "genuine discounts" through our proprietary price analysis algorithm.

🎯 Target Audience
Customers: Smart shoppers seeking to eliminate the fatigue of manual price comparisons.

Developers: Engineers interested in large-scale data crawling and real-time data processing.

🛠 Tech Stack Overview
| Category | Technology | Details |
| :--- | :--- | :--- |
| Backend | Java 11, Spring Framework | Core Logic & API Development |
| Persistence | MyBatis, Oracle DB | Data Mapping & RDBMS |
| Web Scraping | JSoup, Selenium | Static/Dynamic Data Collection |
| Frontend | HTML5, CSS3, JavaScript | Web Standard UI Development |
| Libraries | jQuery, Bootstrap | DOM Manipulation |
| DevOps | Git, GitHub | Version Control |
| Environment | STS 3, Apache Tomcat 9.0 | IDE & WAS |

✨ Key Features
🛍 For Customers
Real-time Popular Hot-Deals: Integrated curation of hot-deals from major communities (Ppomppu, Dogdrip, FM Korea, etc.).

Price Drop Ranking System: Prioritizes products with the highest discount rates compared to previous prices.

Live Status Board: Provides real-time notifications via a top banner whenever an all-time low price is reached.

💻 For Developers
Hybrid Crawling Engine: Implementation of collection logic supporting both static (JSoup) and dynamic (Selenium) pages.

Data Standardization: Management of diverse community data by normalizing it into a single standardized schema.

System Optimization: Server tuning to resolve bottlenecks during large-scale data loading.

🔍 Troubleshooting
⚠️ Tomcat Timeout Issue
Issue: A 45-second timeout error occurred during server startup due to project expansion and library loading delays.

Solution: Secured a stable deployment environment by increasing the Start timeout to 180 seconds in the Servers configuration.

⚠️ Data Consistency
Issue: Risk of data loss when the UI structure of targeted crawling sites changes.

Solution: Enhanced data collection success rates by designing flexible, selector-based parsing logic and reinforcing exception-handling routines.

👤 Team & Role
Head Developer: Lee Seung-yeop

Developers: Kwon Yu-jeong, Yoon Myeong-ji, Park So-shim

Main Role:
         Designed backend infrastructure and developed Footer/Inquiry systems.

         Designed and managed the database schema for real-time price fluctuations.

         mplemented logic for the 1:1 customer inquiry system.
         

© 2026 Price-Rader.MALL. All Rights Reserved.












