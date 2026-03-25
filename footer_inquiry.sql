-- 1. 기존 테이블 삭제 (에러나도 무시하고 진행하세요)
DROP TABLE footer_inquiry;

-- 2. 기존 시퀀스 삭제 (에러나도 무시하고 진행하세요)
DROP SEQUENCE seq_inquiry_no;

-- 3. 테이블 다시 생성 (여기서 Success가 떠야 합니다!)
CREATE TABLE footer_inquiry (
    inquiry_no NUMBER PRIMARY KEY,
    user_name VARCHAR2(100) NOT NULL,
    user_email VARCHAR2(200) NOT NULL,
    user_content VARCHAR2(2000) NOT NULL,
    reply_content VARCHAR2(2000),
    is_answered CHAR(1) DEFAULT 'N',
    reg_date DATE DEFAULT SYSDATE
);

-- 4. 시퀀스 다시 생성 (여기서 Success가 떠야 합니다!)
CREATE SEQUENCE seq_inquiry_no START WITH 1 INCREMENT BY 1;

-- 5. 확정 저장
COMMIT;