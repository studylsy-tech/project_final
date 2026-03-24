package com.project.crawling;

import java.time.Duration;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Component;
import com.project.model.ProductDTO; // DTO 패키지 경로 확인

@Component
public class SeleniumDriver {

    public void crawlingStart(String keyword) {
        // 1. ChromeOptions 설정 (차단 회피 및 속도 최적화)
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless"); // 브라우저 창 띄우지 않음
        options.addArguments("--disable-blink-features=AutomationControlled");
        options.addArguments("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");

        WebDriver driver = new ChromeDriver(options);
        
        try {
            // 2. 다나와 검색 결과 페이지 접속
            String url = "https://search.danawa.com/dsearch.php?query=" + keyword;
            driver.get(url);
            
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

            // 3. 첫 번째 검색 결과 상품명과 가격 파싱
            // 검색 결과 리스트(.product_list)에서 첫 번째 아이템(.prod_item) 선택
            WebElement firstItem = wait.until(ExpectedConditions.presenceOfElementLocated(
                By.cssSelector(".product_list .prod_item:not(.product-pot)")
            ));

            String title = firstItem.findElement(By.cssSelector(".prod_name a")).getText();
            String price = firstItem.findElement(By.cssSelector(".rank_one .price_sect strong")).getText();

            System.out.println("검색 키워드: " + keyword);
            System.out.println("매칭 상품명: " + title);
            System.out.println("최저가: " + price + "원");

        } catch (Exception e) {
            System.out.println("크롤링 중 오류 발생: " + e.getMessage());
        } finally {
            driver.quit(); // 메모리 해제를 위해 반드시 종료
        }
    }
}