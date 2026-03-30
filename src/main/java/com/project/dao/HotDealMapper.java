package com.project.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.project.model.HotDealDTO;

@Mapper
public interface HotDealMapper {
    // URL이 중복되면 업데이트, 없으면 삽입 (Oracle MERGE 문 활용)
    void upsertHotDeal(HotDealDTO dto);

    // 최신 핫딜 목록 조회
    List<HotDealDTO> selectRecentDeals();
    int getTotalCount();

	String getLastCollectTime();
}