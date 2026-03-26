package com.project.dao;

import java.util.List;

import com.project.model.FooterInquiryVO;

public interface FooterMapper {
		int insertInquiry(FooterInquiryVO vo);
		List<FooterInquiryVO> selectAllInquiries();
}
