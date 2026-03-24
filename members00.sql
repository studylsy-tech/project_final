-- 1. 우회 설정 활성화 (이게 없으면 pricedata라는 이름을 거부합니다)
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- 2. 사용자 생성
CREATE USER pricedata IDENTIFIED BY 1234;

-- 3. 필수 권한 부여
-- CONNECT: 접속 권한
-- RESOURCE: 테이블, 시퀀스 등 객체 생성 권한
GRANT CONNECT, RESOURCE TO pricedata;

-- 4. 저장소(용량) 권한 부여
-- USERS 테이블스페이스에 데이터를 마음껏 쌓을 수 있게 합니다.
ALTER USER pricedata QUOTA UNLIMITED ON USERS;