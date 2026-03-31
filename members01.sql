--기존 테이블 삭제
DROP TABLE MEMBERS CASCADE CONSTRAINTS;

-- 새 테이블 작성
CREATE TABLE MEMBERS (
    PHONE         VARCHAR2(20) PRIMARY KEY, -- 아이디 역할을 하므로 PK는 유지
    PW            VARCHAR2(100),            -- NOT NULL 제거
    NAME          VARCHAR2(50),             -- NOT NULL 제거 (준회원 가입 에러 해결)
    NICKNAME      VARCHAR2(50),
    EMAIL         VARCHAR2(100),            -- UNIQUE 제거 (중복 이메일 허용)
    ADDRESS       VARCHAR2(300),
    MEMBER_TYPE   VARCHAR2(20) DEFAULT 'SEMI',
    CREATED_AT    DATE DEFAULT SYSDATE
);

-- 관리자 계정 생성
INSERT INTO MEMBERS (PHONE, PW, NAME, NICKNAME, EMAIL, ADDRESS, MEMBER_TYPE) 
VALUES ('01099999999', '12345', '관리자', '최고관리자', 'admin@test.com', '서울특별시 강남구', 'ADMIN');

-- 테스트용 관리자 계정
INSERT INTO MEMBERS (PHONE, PW, NAME, NICKNAME, EMAIL, ADDRESS, MEMBER_TYPE) 
VALUES ('1', '1', '관리자', '관리자1', 'test_admin@test.com', '비공개', 'ADMIN');
-- 변경사항 확정
COMMIT;

-- 회원 목록 전체 조회
SELECT * FROM MEMBERS;

-- 특정 계정 삭제 (PHONE이 1인 계정)
DELETE FROM MEMBERS WHERE PHONE = '1';

-- 삭제 후 저장
COMMIT;