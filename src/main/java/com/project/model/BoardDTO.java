package com.project.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardDTO {
	private int notice_no;
    private String title;
    private String content;
    private String writer;
    private String board_type;
    private int count;
    
    private String indate;  
    private int parent_no;
    private int is_reply;
    
    private int reply_count; 
    private String status;
    
    private String file_str;      // DB의 CLOB과 매핑
    private String org_filename;  // 파일명
    private MultipartFile uploadFile; // JSP <input type="file"> 전용
}