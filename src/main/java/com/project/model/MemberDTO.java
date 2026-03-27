package com.project.model;

import lombok.Data;

@Data
public class MemberDTO {
    private String phone;      // 전화번호 (아이디 대용)
    private String pw;         // 비밀번호
    private String name;       // 이름
    private String nickname;   // 별명 (메인 페이지 호출용)
    private String email;      // 이메일 (알림 및 정보 수정 인증용)
    private String address;    // 주소
    private String memberType; // 회원 유형 (ADMIN, FULL, SEMI 등)
    private String createdAt;  // 가입일 (필요 시 추가)
}