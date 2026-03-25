CREATE TABLE MEMBERS (
    PHONE       VARCHAR2(20) PRIMARY KEY, -- 휴대폰 번호 (아이디 대용)
    PW          VARCHAR2(100) NOT NULL,   -- 비밀번호
    NAME        VARCHAR2(50),             -- 이름
    EMAIL       VARCHAR2(100),            -- 이메일
    BIRTH       VARCHAR2(20),             -- 생년월일 (DTO가 String이므로)
    GENDER      VARCHAR2(10),             -- 성별 (M/F)
    MEMBER_TYPE VARCHAR2(10) DEFAULT 'SEMI' -- 반회원/정회원 구분
);

-- 회원 목록 조회
SELECT * FROM MEMBERS;

-- 관리자 계정 생성
INSERT INTO MEMBERS (PHONE, PW, NAME, EMAIL, BIRTH, GENDER, MEMBER_TYPE) 
VALUES ('01099999999', '12345', '관리자', 'admin@test.com', '1990-01-01', 'M', 'ADMIN');

-- 관리자 계정 생성 후 저장
COMMIT

<<<<<<< HEAD




=======
-- DB 조회용
SELECT * FROM MEMBERS;
>>>>>>> branch 'register' of https://github.com/studylsy-tech/project_final.git
