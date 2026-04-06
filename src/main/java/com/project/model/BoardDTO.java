package com.project.model;

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
}