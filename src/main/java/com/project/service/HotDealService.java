package com.project.service;

import java.util.List;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.project.crawling.SeleniumDriver;
import com.project.dao.ProductMapper;
import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;

@Service
public class HotDealService {

    @Autowired
    private ProductMapper productMapper;

    @Autowired
    private SeleniumDriver seleniumDriver;

    // [추가] 관리자용 핫딜 수집 및 저장 메서드
    @Transactional
    public void fetchAndStoreDeals(int limit) {
        WebDriver driver = seleniumDriver.getDriver();
        try {
            // 크롤링 대상 사이트 접속
            driver.get("https://hotdeal.zip"); 
            
            // 사이트 구조에 맞는 셀렉터로 요소 추출 (예시: .deal-item)
            List<WebElement> items = driver.findElements(By.cssSelector(".deal-item"));
            
            int count = 0;
            for (WebElement item : items) {
                if (count >= limit) break; // 50개 제한

                try {
                    String url = item.findElement(By.tagName("a")).getAttribute("href");
                    String title = item.findElement(By.className("title")).getText();
                    String priceText = item.findElement(By.className("price")).getText();
                    long price = Long.parseLong(priceText.replaceAll("[^0-9]", ""));
                    
                    // 쇼핑몰 이름 등 추가 정보 추출 (필요 시)
                    String mallName = item.findElement(By.className("mall-name")).getText();

                    // 1. DB 존재 여부 확인 (URL 기준)
                    HotDealDTO existing = productMapper.findByUrl(url);

                    if (existing == null) {
                        // 2. 신규 등록 (TB_HOTDEAL_TRACKER)
                        HotDealDTO newDeal = new HotDealDTO();
                        newDeal.setOriginUrl(url);
                        newDeal.setTitle(title);
                        newDeal.setCurrentPrice(price);
                        newDeal.setStartPrice(price);
                        newDeal.setMallName(mallName);
                        
                        productMapper.insertHotDeal(newDeal);
                        
                        // 3. 초기 가격 이력 저장 (TB_PRICE_HISTORY)
                        // insertPriceHistoryByDeal 메서드는 Mapper 인터페이스에 정의한 이름과 맞춰야 함
                        productMapper.insertPriceHistoryByDeal(newDeal.getDealId(), price);
                    } else if (existing.getCurrentPrice() != price) {
                        // 4. 가격 변동 시 업데이트 및 이력 추가
                        productMapper.updatePrice(url, price);
                        productMapper.insertPriceHistoryByDeal(existing.getDealId(), price);
                    }
                    count++;
                } catch (Exception e) {
                    // 개별 아이템 파싱 실패 시 건너뜀
                    continue;
                }
            }
        } finally {
            seleniumDriver.closeDriver();
        }
    }

    // 분석 페이지용: 역대 최저가 상품 조회
    public List<ProductDTO> getNewLowProducts() {
        return productMapper.findNewLowProducts();
    }
    
 // 분석 페이지용: 전체 수집된 핫딜 개수 조회
    public int getTotalDealCount() {
        return productMapper.getTotalDealCount();
    }
}