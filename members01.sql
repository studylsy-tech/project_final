-- 기존 테이블 삭제
DROP TABLE MEMBERS CASCADE CONSTRAINTS;

-- 새 테이블 작성
CREATE TABLE MEMBERS (
    PHONE        VARCHAR2(20) PRIMARY KEY, -- 휴대폰 번호 (PK)
    PW           VARCHAR2(100),            -- 비밀번호
    NAME         VARCHAR2(50),             -- 이름
    NICKNAME     VARCHAR2(50),             -- 별명
    EMAIL        VARCHAR2(100) UNIQUE,     -- 이메일 (중복 방지 UNIQUE 제약)
    ADDRESS      VARCHAR2(300),            -- 주소
    MEMBER_TYPE  NUMBER(1) DEFAULT 1,      -- 0: 관리자, 1: 준회원, 2: 정회원
    CREATED_AT   DATE DEFAULT SYSDATE      -- 가입일
);

-- 관리자 계정 생성 (MEMBER_TYPE: 0)
INSERT INTO MEMBERS (PHONE, PW, NAME, NICKNAME, EMAIL, ADDRESS, MEMBER_TYPE) 
VALUES ('01099999999', '12345', '관리자', '최고관리자', 'admin@test.com', '서울특별시 강남구', 0);
INSERT INTO MEMBERS (PHONE, PW, NAME, NICKNAME, EMAIL, ADDRESS, MEMBER_TYPE) 
VALUES ('0', '0', '관리자', '관리자', 'admin2@test.com', '서울특별시 강남구', 0);

-- 테스트용 계정
INSERT INTO MEMBERS (PHONE, PW, NAME, NICKNAME, EMAIL, ADDRESS, MEMBER_TYPE) 
VALUES ('1', '1', '테스트', '테스터1', 'test@test.com', '비공개', 1);

-- 변경사항 확정
COMMIT;

-- 회원 목록 전체 조회
SELECT * FROM MEMBERS;