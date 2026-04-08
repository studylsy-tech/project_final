package com.project.crawling;

import java.util.ArrayList;
import java.util.List;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.springframework.stereotype.Component;
import com.project.model.HotDealDTO;

@Component
public class PriceParser {

	public List<HotDealDTO> parseHotdealZip(WebDriver driver) {
	    List<HotDealDTO> list = new ArrayList<>();
	    try {
	        driver.get("https://hotdeal.zip/");
	        Thread.sleep(3000); 

	        // 1. 메인 페이지에서 상품 상세 페이지 링크들 수집
	        List<WebElement> items = driver.findElements(By.cssSelector("a.group")); 
	        List<String> detailUrls = new ArrayList<>();
	        for (WebElement item : items) {
	            detailUrls.add(item.getAttribute("href"));
	        }

	        // 2. 각 상세 페이지로 이동하여 진짜 구매 링크(원문 주소) 추출
	        for (String detailUrl : detailUrls) {
	            try {
	                driver.get(detailUrl);
	                Thread.sleep(1500); // 상세 페이지 로딩 대기

	                HotDealDTO dto = new HotDealDTO();
	                
	                // [핵심 수정] 상세 페이지 내의 진짜 구매 버튼 링크 추출
	                // HTML 분석 결과: body > div.hotdeal-container > div.deal-action-box > a.buy-button
	                WebElement buyBtn = driver.findElement(By.cssSelector(".buy-button"));
	                String realOriginUrl = buyBtn.getAttribute("href");
	                dto.setOriginUrl(realOriginUrl); 

	                // 제목 및 가격 추출 (상세 페이지의 클래스명에 맞게 수정)
	                dto.setTitle(driver.findElement(By.cssSelector(".deal-title")).getText()); 
	                String priceText = driver.findElement(By.cssSelector(".price-value")).getText(); 
	                dto.setCurrentPrice(Integer.parseInt(priceText.replaceAll("[^0-9]", "")));
	                
	                // 쇼핑몰 이름 추출 (예: 네이버)
	                dto.setMallName(driver.findElement(By.cssSelector(".shop-name")).getText().trim());
	                dto.setCommunityName("핫딜모음");

	                list.add(dto);
	            } catch (Exception e) {
	                continue; 
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
}