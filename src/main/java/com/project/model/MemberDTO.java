package com.project.model;

import lombok.Data;

@Data
public class MemberDTO {
    private String phone;
    private String pw;
    private String name;
    private String nickname;
    private String email;
    private String address;
    
    // [수정] String에서 int로 변경 (0: 관리자, 1: 준회원, 2: 정회원)
    private int memberType; 
    
    private String createdAt;
    
    // 알림 설정 관련 필드
    private String email_alarm; 
    private String web_alarm;   
    private String night_alarm; 
}