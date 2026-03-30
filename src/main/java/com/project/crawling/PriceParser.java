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
        driver.get("[https://hotdeal.zip/](https://hotdeal.zip/)");
        // 동적 콘텐츠 로딩을 위해 잠시 대기
        Thread.sleep(3000); 

        // 핫딜 아이템 리스트 추출 (사이트의 실제 CSS 선택자에 맞춰 수정 필요)
        List<WebElement> items = driver.findElements(By.cssSelector("a.group")); 

        for (WebElement item : items) {
            try {
                HotDealDTO dto = new HotDealDTO();
                
                // URL 및 제목 추출
                dto.setOriginUrl(item.getAttribute("href"));
                String title = item.findElement(By.cssSelector("h3")).getText();
                dto.setTitle(title);
                
                // 가격 추출 (숫자만 남김)
                String priceText = item.findElement(By.cssSelector(".text-red-500")).getText();
                dto.setCurrentPrice(Integer.parseInt(priceText.replaceAll("[^0-9]", "")));
                
                dto.setCommunityName("HotdealZip");
                dto.setMallName("기타");

                list.add(dto);
            } catch (Exception e) {
                continue; // 개별 항목 파싱 실패 시 다음으로 진행
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
}