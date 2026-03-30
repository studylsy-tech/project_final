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
    private String memberType;
    private String createdAt;
    
    // 알림 설정 관련 필드 추가
    private String email_alarm; // 이메일 알림 여부 (Y/N)
    private String web_alarm;   // 웹 푸시 알림 여부 (Y/N) - 이 부분을 추가하세요
    private String night_alarm; // 야간 알림 제한 여부 (Y/N)
}