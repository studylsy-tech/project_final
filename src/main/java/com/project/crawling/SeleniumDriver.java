package com.project.crawling;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Component;
import com.project.model.ProductDTO;

@Component
public class SeleniumDriver {

    // 반환 타입을 List<ProductDTO>로 변경하여 컨트롤러에 전달
    public List<ProductDTO> crawlingList(String keyword) {
        List<ProductDTO> productList = new ArrayList<>();
        
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless"); 
        options.addArguments("--disable-blink-features=AutomationControlled");
        options.addArguments("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");

        WebDriver driver = new ChromeDriver(options);
        
        try {
            String url = "https://search.danawa.com/dsearch.php?query=" + keyword;
            driver.get(url);
            
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

            // 상품 리스트 전체가 나타날 때까지 대기
            wait.until(ExpectedConditions.presenceOfAllElementsLocatedBy(
                By.cssSelector(".product_list .prod_item:not(.product-pot)")
            ));

            // 검색된 상품 요소들을 모두 가져옴
            List<WebElement> items = driver.findElements(By.cssSelector(".product_list .prod_item:not(.product-pot)"));

            // 최대 10개까지만 수집
            int count = 0;
            for (WebElement item : items) {
                if (count >= 10) break;

                try {
                    // 1. 상품명 추출
                    String title = item.findElement(By.cssSelector(".prod_name a")).getText();
                    
                    // 2. 가격 추출
                    String priceStr = item.findElement(By.cssSelector(".rank_one .price_sect strong")).getText();
                    int price = Integer.parseInt(priceStr.replaceAll("[^0-9]", ""));

                    // 3. 상품 고유 코드 추출
                    String prodCode = item.getAttribute("id");

                    // [추가] 4. 카테고리(스펙 리스트) 추출 및 분류 테스트
                    // 다나와 검색 결과의 .spec_list 클래스에는 "스마트폰 / 17.0cm(6.7인치) / ..." 형태의 텍스트가 담깁니다.
                    String specText = item.findElement(By.cssSelector(".spec_list")).getText();
                    
                    System.out.println("추출된 스펙/카테고리: " + specText); // 테스트 로그

                    // 단순 포함 여부로 테이블 분류 로직 예시
                    String targetTable = "GENERAL_PRODUCTS";
                    if (specText.contains("스마트폰") || specText.contains("노트북") || specText.contains("가전")) {
                        targetTable = "ELECTRONIC_PRODUCTS";
                    }
                    System.out.println("분류된 대상 테이블: " + targetTable);

                    // DTO 객체 생성 및 저장
                    ProductDTO dto = new ProductDTO();
                    dto.setProdCode(prodCode);
                    dto.setName(title);
                    dto.setPrice(price);
                    // 필요 시 DTO에 카테고리 필드를 추가하여 저장 가능
                    
                    productList.add(dto);
                    count++;
                } catch (Exception e) {
                    continue;
                }
            }

        } catch (Exception e) {
            System.out.println("크롤링 중 오류 발생: " + e.getMessage());
        } finally {
            driver.quit();
        }
        
        return productList;
    }
}