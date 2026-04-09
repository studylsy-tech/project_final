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

    // [추가] 정지 요청 상태를 저장하는 플래그 (메모리 가시성 보장을 위해 volatile 사용)
    private volatile boolean stopRequested = false;

    /**
     * 외부(Controller)에서 정지 명령을 내릴 때 호출
     */
    public void requestStop() {
        this.stopRequested = true;
        log.warn("!!! 크롤링 정지 요청이 수신되었습니다. 현재 상품 처리 후 중단됩니다. !!!");
    }

    /**
     * [1] 일반 상품 가격 추적 (핫딜 스타일로 보완)
     */
    public int updateRegisteredProductPrices() {
        this.stopRequested = false;
        int count = 0;
        List<ProductDTO> targetList = adminMapper.getNormalProductList();
        if (targetList.isEmpty()) return 0;

        WebDriver driver = seleniumDriver.getDriver();
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10)); // [추가] 핫딜처럼 대기 객체 생성
        
        try {
            for (ProductDTO product : targetList) {
                if (stopRequested) break;
                if (product.getProdId() <= 0) continue;

                try {
                    // [핫딜 방식 적용] 검색어 정제 (특수문자 제거 및 길이 제한)
                    String searchKeyword = product.getProdName().replaceAll("\\[.*?\\]", "").trim();
                    if (searchKeyword.length() > 20) searchKeyword = searchKeyword.substring(0, 20).trim();

                    driver.get("https://search.danawa.com/dsearch.php?query=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8"));
                    
                    // [핫딜 방식 적용] 암묵적 대기 대신 명시적 대기 사용
                    // 가격 태그가 나타날 때까지 최대 10초 대기
                    WebElement priceElem = wait.until(ExpectedConditions.visibilityOfElementLocated(
                        By.cssSelector(".product_list .prod_item:first-child .price_sect strong")
                    ));

                    int currentPrice = Integer.parseInt(priceElem.getText().replaceAll("[^0-9]", ""));

                    adminMapper.updateCurrentPrice(product.getProdId(), currentPrice);
                    adminMapper.insertCommonPriceHistory(product.getProdId(), currentPrice);
                    
                    count++;
                    log.info("[일반 성공] {} : {}원", product.getProdName(), currentPrice);
                    
                } catch (Exception e) {
                    // [핫딜 방식 적용] 에러 발생 시 로그만 찍고 다음 상품으로 넘어가기
                    log.error("[일반 실패] 상품명: {} | 원인: {}", product.getProdName(), e.getMessage());
                    continue; 
                }
            }
        } finally {
            seleniumDriver.closeDriver();
        }
        return count;
    }
    /**
     * [2] 핫딜 상품 가격 추적
     */
    public int updateRegisteredHotDealPrices() {
        this.stopRequested = false; // 시작 시 플래그 초기화
        int count = 0;
        List<HotDealDTO> hotDealList = adminMapper.getHotDealList();
        
        if (hotDealList.isEmpty()) {
            log.info("추적 중인 핫딜 상품이 없습니다.");
            return 0;
        }

        WebDriver driver = seleniumDriver.getDriver();
        
        try {
            int totalSize = hotDealList.size();
            int currentIdx = 0;

            for (HotDealDTO deal : hotDealList) {
                // [핵심] 정지 요청이 들어왔는지 매 루프 시작 시 확인
                if (stopRequested) {
                    System.out.println("\n!!! 사용자에 의해 작업이 중단되었습니다 !!!");
                    break; 
                }

                currentIdx++;
                String searchKeyword = "";
                
                System.out.println("\n==================================================");
                System.out.printf("  진행률: [%d/%d] (%.1f%%)\n", currentIdx, totalSize, (currentIdx / (double)totalSize) * 100);
                System.out.printf("  현재 상품: %s\n", deal.getTitle());
                System.out.println("--------------------------------------------------");

                try {
                    String originalTitle = deal.getTitle();
                    searchKeyword = originalTitle.replaceAll("\\[.*?\\]", "").trim();
                    if (searchKeyword.isEmpty()) searchKeyword = originalTitle;
                    
                    if (searchKeyword.length() > 15) {
                        searchKeyword = searchKeyword.substring(0, 15).trim();
                    }
                    
                    System.out.println("  > 정제된 검색어: " + searchKeyword);

                    driver.get("https://search.danawa.com/dsearch.php?query=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8"));
                    Thread.sleep(2500);

                    WebElement priceElem = driver.findElement(By.cssSelector(".product_list .prod_item:first-child .price_sect strong"));
                    long currentPrice = Long.parseLong(priceElem.getText().replaceAll("[^0-9]", ""));

                    adminMapper.updateHotDealPrice(deal.getDealId(), currentPrice);
                    adminMapper.insertHotDealPriceHistory(deal.getDealId(), currentPrice);
                    
                    count++;
                    System.out.printf("  [성공] 최저가: %,d원 갱신 완료\n", currentPrice);
                    
                } catch (Exception e) {
                    System.err.printf("  [실패] 오류 메시지: %s\n", e.getMessage());
                    log.error("[핫딜 실패] 상품: {} | 원인: {}", deal.getTitle(), e.getMessage());
                }
                System.out.println("==================================================");
            }
        } finally {
            seleniumDriver.closeDriver();
            System.out.println("\n[최종 결과] 업데이트 중단/완료 총 " + count + "건");
        }
        
        return count;
    }
    
    
}