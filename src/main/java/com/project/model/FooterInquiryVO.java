package com.project.model;

import lombok.Data;

@Data
public class FooterInquiryVO {
	
	private int inquiry_no;
	private String user_name;
	private String user_email;
	private String user_content;
	private String reply_content;
	private String status;
	private String reg_data;
	

}
