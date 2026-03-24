package com.project.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor  // 파라미터 없는 기본 생성자
@AllArgsConstructor // 모든 필드를 포함한 생성자
public class ProductDTO {
    private String name;
    private int price;
    private String updateStatus;
}