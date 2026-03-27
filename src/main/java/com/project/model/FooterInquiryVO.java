package com.project.model;

import lombok.Data;

@Data
public class FooterInquiryVO {

    private int inquiry_no;
    private String user_name;
    private String user_email;
    private String user_content;
    private String reply_content;
    
    // 기존 'status' 대신 DB 컬럼명과 일치시킨 'is_answered' 사용
    private String is_answered; 
    
    // 기존 'reg_data'의 오타를 수정한 'reg_date' 사용
    private String reg_date; 
}