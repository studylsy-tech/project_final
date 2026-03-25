package com.project.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDTO {
    private int prodId;         // DB 자동 생성 PK 값 수신용
    private String prodCode;    
    private String name;        
    private int price;         
    private int targetPrice;    // 추가: 목표 가격
    private int checkInterval;  // 추가: 확인 주기
    private String source;      // 추가: 출처 (Danawa 등)
    private String category; 
}