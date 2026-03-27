package com.project.model;

import lombok.Data;

@Data
public class BoardDTO {
    private int notice_no;      // NOTICE_NO와 일치
    private String title;       // TITLE과 일치
    private String content;     // CONTENT와 일치
    private String writer;      // WRITER와 일치
    private String board_type;  // BOARD_TYPE과 일치
    private int count;          // COUNT와 일치
    private String indate;      // INDATE와 일치 (날짜)
}