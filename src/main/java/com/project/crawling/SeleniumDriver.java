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

    private WebDriver driver;

    // [추가] 공통 드라이버 생성 및 반환 메서드
    public WebDriver getDriver() {
        if (this.driver == null) {
            ChromeOptions options = new ChromeOptions();
            options.addArguments("--headless");
            options.addArguments("--disable-blink-features=AutomationControlled");
            options.addArguments("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
            
            this.driver = new ChromeDriver(options);
        }
        return this.driver;
    }

    // [추가] 공통 드라이버 종료 메서드
    public void closeDriver() {
        if (this.driver != null) {
            this.driver.quit();
            this.driver = null;
        }
    }

    // 기존 메서드 (유지하되 내부 로직을 getDriver 활용으로 변경 가능)
    public List<ProductDTO> crawlingList(String keyword) {
        List<ProductDTO> productList = new ArrayList<>();
        WebDriver localDriver = getDriver(); // 내부에서도 공통 메서드 활용

        try {
            String url = "https://search.danawa.com/dsearch.php?query=" + keyword;
            localDriver.get(url);
            WebDriverWait wait = new WebDriverWait(localDriver, Duration.ofSeconds(10));
            
            wait.until(ExpectedConditions.presenceOfAllElementsLocatedBy(By.cssSelector(".product_list .prod_item:not(.product-pot)")));
            List<WebElement> items = localDriver.findElements(By.cssSelector(".product_list .prod_item:not(.product-pot)"));

            int count = 0;
            for (WebElement item : items) {
                if (count >= 10) break;
                try {
                    String title = item.findElement(By.cssSelector(".prod_name a")).getText();
                    String priceStr = item.findElement(By.cssSelector(".rank_one .price_sect strong")).getText();
                    int price = Integer.parseInt(priceStr.replaceAll("[^0-9]", ""));
                    String prodCode = item.getAttribute("id");

                    ProductDTO dto = new ProductDTO();
                    dto.setProdCode(prodCode);
                    dto.setName(title);
                    dto.setPrice(price);

                    productList.add(dto);
                    count++;
                } catch (Exception e) {
                    continue;
                }
            }
        } catch (Exception e) {
            System.out.println("크롤링 중 오류 발생: " + e.getMessage());
        } finally {
        }
        closeDriver(); // 공통 종료 메서드 호출

        return productList;
    }
}