package com.project.model;

import lombok.Data;

@Data
public class MemberDTO {
    private String phone;     // 아이디 대용
    private String pw;        // 비밀번호 
    private String name;      // 이름 
    private String email;     // 이메일 (알림용)
    private String birth;     // 생년월일 
    private String gender;    // 성별 
    private String memberType; // 반회원/정회원 구분 
}