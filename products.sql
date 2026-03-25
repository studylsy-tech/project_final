
-- 1. [Table 1] 상품 기본 정보 (Common_Product)
CREATE TABLE Common_Product (
    PROD_ID     NUMBER PRIMARY KEY,         -- 시스템 고유 식별자
    PROD_CODE   VARCHAR2(50) UNIQUE,        -- 크롤링한 원본 코드 (다나와/네이버 ID)
    SOURCE      VARCHAR2(50),               -- 데이터 출처 (Danawa, Naver 등)
    CATEGORY    VARCHAR2(50),               -- 카테고리 (Electronics 등)
    PROD_NAME   VARCHAR2(200) NOT NULL,     -- 상품명
    BRAND       VARCHAR2(100),              -- 제조사/브랜드
    PROD_PRICE  NUMBER,                     -- 가격
    REG_DATE    DATE DEFAULT SYSDATE        -- 데이터 수집일
);
--[Table 2] 전자제품 상세 (Electronics_Detail)
CREATE TABLE Electronics_Detail (
    DETAIL_ID   NUMBER PRIMARY KEY,         -- 상세정보 고유 ID
    PROD_ID     NUMBER NOT NULL,            -- Common_Product 테이블 참조
    MODEL_NAME  VARCHAR2(100),              -- 모델명 (예: 아이폰X)
    CAPACITY    NUMBER,                     -- 용량 (숫자만 저장, 예: 256)
    GRADE       VARCHAR2(20),               -- 등급 (S등급, A등급 등)
    COLOR       VARCHAR2(50),               -- 색상
    BATTERY     NUMBER,                     -- 배터리 효율 (%)
    CONSTRAINT FK_PROD_ID FOREIGN KEY (PROD_ID) 
    REFERENCES Common_Product(PROD_ID) ON DELETE CASCADE
);
