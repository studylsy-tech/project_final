package com.project.model;

import lombok.Data;
@Data
public class HotDealDTO {
    private int dealId;
    private String originUrl;
    private String title;
    private long currentPrice;
    private long startPrice;       // 추가
    private String mallName;
    private String communityName;
    private String lastUpdateDate;
    private String imageUrl;
    // 기존 수동 setStartPrice() 메서드 삭제
    
    private int historyId; 
}