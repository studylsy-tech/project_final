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

-- 1. 최고 관리자 계정 생성 (MEMBER_TYPE: 0)
INSERT INTO MEMBERS (PHONE, PW, NAME, NICKNAME, EMAIL, ADDRESS, MEMBER_TYPE) 
VALUES ('01099999999', '12345', '최고관리자', '마스터', 'admin@test.com', '서울특별시 강남구', 0);
INSERT INTO MEMBERS (PHONE, PW, NAME, NICKNAME, EMAIL, ADDRESS, MEMBER_TYPE) 
VALUES ('0', '0', '최고관리자2', '마스터2', 'admin3@test.com', '서울특별시 강남구2', 0);

-- 2. 일반 관리자용 부계정 (PHONE을 '0'으로 설정 시 테스트 환경에 따라 문제가 생길 수 있어 형식을 맞춤)
INSERT INTO MEMBERS (PHONE, PW, NAME, NICKNAME, EMAIL, ADDRESS, MEMBER_TYPE) 
VALUES ('01000000000', '0000', '부관리자', '관리자1', 'admin2@test.com', '서울특별시 서초구', 0);
INSERT INTO MEMBERS (PHONE, PW, NAME, NICKNAME, EMAIL, ADDRESS, MEMBER_TYPE) 
VALUES ('2', '2', '부관리자', '관리자1', 'admin4@test.com', '서울특별시 서초구', 0);

-- 3. 테스트용 일반 회원 (MEMBER_TYPE: 1)
INSERT INTO MEMBERS (PHONE, PW, NAME, NICKNAME, EMAIL, ADDRESS, MEMBER_TYPE) 
VALUES ('01012345678', '1111', '홍길동', '길동이', 'user@test.com', '경기도 성남시', 1);
INSERT INTO MEMBERS (PHONE, PW, NAME, NICKNAME, EMAIL, ADDRESS, MEMBER_TYPE) 
VALUES ('1', '1', '홍길동2', '길동이2', 'user2@test.com', '경기도 성남시', 1);

-- 변경사항 확정
COMMIT;

-- 조회
SELECT * FROM MEMBERS;