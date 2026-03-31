package com.project.model;

import java.util.Date;
import lombok.Data;

@Data
public class ProductDTO {
    // 상품 식별을 위한 고유 코드 (추가 필수)
    private String prodCode;       // 예: "P12345" 또는 크롤링한 고유 ID

    // 공통 필수 필드
    private int prodId;            // 기본 키 (DB 시퀀스)
    private String name;           // 상품명
    private long price;            // 현재가
    private long startPrice;       // 시작가/정가
    
    // 분석 및 출처 필드
    private String imageUrl;       
    private String originUrl;      
    private String mallName;       
    private String communityName;  
    
    // 상태 및 분류 필드
    private String boardType;      
    private Date regDate;          
    
    private int viewCount;         
    private String category;       

}