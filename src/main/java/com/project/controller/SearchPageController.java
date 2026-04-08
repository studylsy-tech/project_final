package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.dao.BoardMapper;
import com.project.dao.SearchMapper;
import com.project.model.HotDealDTO;
import com.project.model.ProductDTO;
import com.project.util.SearchCriteria;
import com.project.util.SearchPageMaker;

@Controller
@RequestMapping("/search")
public class SearchPageController {

    @Autowired
    private SearchMapper searchMapper; // 상품용 매퍼

    @Autowired
    private BoardMapper boardMapper;   // 게시판용 매퍼

    @GetMapping("/list")
    public String searchList(@ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
        scri.calcPageRange();
        
        String boardType = scri.getBoardType(); 
        
        if (boardType != null && (boardType.equals("NOTICE") || boardType.equals("QNA"))) {
            int totalCount = boardMapper.getBoardCount(scri); 
            SearchPageMaker pageMaker = new SearchPageMaker(scri, totalCount, 5);
            
            model.addAttribute("list", boardMapper.selectBoardListPaging(scri)); 
            model.addAttribute("pageMaker", pageMaker);
            // 1. "boardType"이 있는지 확인 (게시판인지 상품인지 구분)

            // [수정 포인트] boardType에 따라 반환하는 JSP 경로를 분기합니다.
            if ("QNA".equals(boardType)) {
                return "board/qna_list";    // Q&A 검색 시 qna_list.jsp로 이동
            } else {
                return "board/notice_list"; // NOTICE 검색 시 notice_list.jsp로 이동
            }

        
        
        }else if (boardType != null && boardType.equals("HOTDEAL")) {
            // [핫딜 분석 모드] 추가된 부분!
            int totalCount = searchMapper.getHotDealSearchCount(scri); // 핫딜용 카운트 매퍼 필요
            SearchPageMaker pageMaker = new SearchPageMaker(scri, totalCount, 5);
            
            // 여기서 반환되는 리스트 타입을 HotDealDTO로 인식하게 합니다.
            List<HotDealDTO> list = searchMapper.getHotDealSearchList(scri);
            
            model.addAttribute("hotDealList", list);
            model.addAttribute("pageMaker", pageMaker);
            
            return "stock/analysis"; // 핫딜 분석 JSP로 보냄
            
        }else {
            // [상품 모드] 기존 코드 유지
            List<ProductDTO> list = searchMapper.getSearchList(scri);
            int totalCount = searchMapper.getSearchCount(scri);
            SearchPageMaker pageMaker = new SearchPageMaker(scri, totalCount, 5);
            
            model.addAttribute("stockList", list);
            model.addAttribute("pageMaker", pageMaker);
            
            return "stock/stock_list"; // 상품 JSP로 보냄
        }
        
    }
}