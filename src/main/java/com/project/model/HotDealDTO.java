package com.project.model;

import lombok.Data;

@Data
public class HotDealDTO {
    private int dealId;
    private String originUrl;     // 고유 키 (PK 대용)
    private String title;
    private long currentPrice;
    private String mallName;      // 쇼핑몰 (쿠팡, 11번가 등)
    private String communityName; // 출처 (뽐뿌, 루리웹 등)
    private String lastUpdateDate;
	public void setStartPrice(long price) {
		// TODO Auto-generated method stub
		
	}
}