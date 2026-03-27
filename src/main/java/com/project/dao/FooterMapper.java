package com.project.dao;

import java.util.List;
import com.project.model.FooterInquiryVO;

public interface FooterMapper {
    // 문의하기 등록 (본인 작업분)
    int insertInquiry(FooterInquiryVO vo);

    // 모든 문의 내역 조회 (상대방 작업분)
    List<FooterInquiryVO> selectAllInquiries();
}