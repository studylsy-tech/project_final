CREATE TABLE MEMBERS (
    PHONE       VARCHAR2(20) PRIMARY KEY, -- 휴대폰 번호 (아이디 대용)
    PW          VARCHAR2(100) NOT NULL,   -- 비밀번호
    NAME        VARCHAR2(50),             -- 이름
    EMAIL       VARCHAR2(100),            -- 이메일
    BIRTH       VARCHAR2(20),             -- 생년월일 (DTO가 String이므로)
    GENDER      VARCHAR2(10),             -- 성별 (M/F)
    MEMBER_TYPE VARCHAR2(10) DEFAULT 'SEMI' -- 반회원/정회원 구분
);


-- DB 조회용
SELECT * FROM MEMBERS;