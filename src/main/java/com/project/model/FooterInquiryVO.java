package com.project.model;

import lombok.Data;

@Data
public class FooterInquiryVO {
    private int inquiry_no;
    private String user_name;
    private String user_email;
    private String user_content;
    private String reply_content;
    
    // DB의 'is_answered' 컬럼과 이름을 똑같이 맞춥니다.
    private String is_answered; 
    
    // 만약 DB 컬럼명이 reg_date라면 여기도 date로 맞추는 게 좋습니다.
    private String reg_date; 
}