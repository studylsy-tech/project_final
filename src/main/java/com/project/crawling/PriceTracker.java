package com.project.crawling;

import java.time.Duration;
import java.util.List;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Component;
import com.project.dao.AdminMapper;
import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class PriceTracker {

    private final SeleniumDriver seleniumDriver;
    private final AdminMapper adminMapper;

    private volatile boolean stopRequested = false;

    public void requestStop() {
        this.stopRequested = true;
        log.warn("!!! 크롤링 정지 요청 수신 !!!");
    }

    /**
     * [1] 일반 상품 가격 추적 (핫딜 로직 및 콘솔 로그 이식)
     */
    public int updateRegisteredProductPrices() {
        this.stopRequested = false;
        int count = 0;
        List<ProductDTO> targetList = adminMapper.getNormalProductList();
        
        if (targetList.isEmpty()) {
            System.out.println("[알림] 추적 중인 일반 상품이 없습니다.");
            return 0;
        }

        WebDriver driver = seleniumDriver.getDriver();
        // 핫딜처럼 명시적 대기 시간 설정
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        
        try {
            int totalSize = targetList.size();
            int currentIdx = 0;

            for (ProductDTO product : targetList) {
                if (stopRequested) {
                    System.out.println("\n!!! 사용자에 의해 일반 상품 수집이 중단되었습니다 !!!");
                    break;
                }

                currentIdx++;
                System.out.println("\n==================================================");
                System.out.printf("  일반 진행률: [%d/%d] (%.1f%%)\n", currentIdx, totalSize, (currentIdx / (double)totalSize) * 100);
                System.out.printf("  현재 상품: %s\n", product.getProdName());
                System.out.println("--------------------------------------------------");

                try {
                    // 1. 검색어 정제 (핫딜 방식 적용)
                    String searchKeyword = product.getProdName().replaceAll("\\[.*?\\]", "").trim();
                    if (searchKeyword.length() > 15) {
                        searchKeyword = searchKeyword.substring(0, 15).trim();
                    }
                    System.out.println("  > 정제된 검색어: " + searchKeyword);

                    // 2. 다나와 이동
                    driver.get("https://search.danawa.com/dsearch.php?query=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8"));
                    
                    // 3. 가격 요소 대기 및 추출 (핫딜 스타일의 명시적 대기)
                    WebElement priceElem = wait.until(ExpectedConditions.visibilityOfElementLocated(
                        By.cssSelector(".product_list .prod_item:first-child .price_sect strong")
                    ));

                    int currentPrice = Integer.parseInt(priceElem.getText().replaceAll("[^0-9]", ""));

                    // 4. DB 업데이트
                    adminMapper.updateCurrentPrice(product.getProdId(), currentPrice);
                    adminMapper.insertCommonPriceHistory(product.getProdId(), currentPrice);
                    
                    count++;
                    System.out.printf("  [성공] 일반 최저가: %,d원 갱신 완료\n", currentPrice);
                    log.info("[일반 성공] {} : {}원", product.getProdName(), currentPrice);
                    
                } catch (Exception e) {
                    System.err.printf("  [실패] 오류 메시지: %s\n", e.getMessage());
                    log.error("[일반 실패] 상품명: {} | 원인: {}", product.getProdName(), e.getMessage());
                }
                System.out.println("==================================================");
            }
        } finally {
            seleniumDriver.closeDriver();
            System.out.println("\n[최종 결과] 일반 상품 업데이트 총 " + count + "건 완료");
        }
        return count;
    }

    /**
     * [2] 핫딜 상품 가격 추적 (기존 유지)
     */
    public int updateRegisteredHotDealPrices() {
        this.stopRequested = false;
        int count = 0;
        List<HotDealDTO> hotDealList = adminMapper.getHotDealList();
        
        if (hotDealList.isEmpty()) return 0;

        WebDriver driver = seleniumDriver.getDriver();
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        
        try {
            int totalSize = hotDealList.size();
            int currentIdx = 0;

            for (HotDealDTO deal : hotDealList) {
                if (stopRequested) break; 

                currentIdx++;
                System.out.println("\n==================================================");
                System.out.printf("  핫딜 진행률: [%d/%d] (%.1f%%)\n", currentIdx, totalSize, (currentIdx / (double)totalSize) * 100);
                System.out.printf("  현재 상품: %s\n", deal.getTitle());
                System.out.println("--------------------------------------------------");

                try {
                    String searchKeyword = deal.getTitle().replaceAll("\\[.*?\\]", "").trim();
                    if (searchKeyword.length() > 15) searchKeyword = searchKeyword.substring(0, 15).trim();
                    
                    System.out.println("  > 정제된 검색어: " + searchKeyword);

                    driver.get("https://search.danawa.com/dsearch.php?query=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8"));
                    
                    WebElement priceElem = wait.until(ExpectedConditions.visibilityOfElementLocated(
                        By.cssSelector(".product_list .prod_item:first-child .price_sect strong")
                    ));
                    
                    long currentPrice = Long.parseLong(priceElem.getText().replaceAll("[^0-9]", ""));

                    adminMapper.updateHotDealPrice(deal.getDealId(), currentPrice);
                    adminMapper.insertHotDealPriceHistory(deal.getDealId(), currentPrice);
                    
                    count++;
                    System.out.printf("  [성공] 핫딜 최저가: %,d원 갱신 완료\n", currentPrice);
                    
                } catch (Exception e) {
                    System.err.printf("  [실패] 오류 메시지: %s\n", e.getMessage());
                }
                System.out.println("==================================================");
            }
        } finally {
            seleniumDriver.closeDriver();
        }
        return count;
    }
}