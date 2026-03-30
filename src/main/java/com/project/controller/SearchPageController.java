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
        
        // 1. "boardType"이 있는지 확인 (게시판인지 상품인지 구분)
        String boardType = scri.getBoardType(); 
        
        if (boardType != null && (boardType.equals("NOTICE") || boardType.equals("QNA"))) {
            // [게시판 모드]
            int totalCount = boardMapper.getBoardCount(scri); // 게시판 개수를 가져옴!
            SearchPageMaker pageMaker = new SearchPageMaker(scri, totalCount, 5);
            
            model.addAttribute("list", boardMapper.selectBoardListPaging(scri)); // 게시판 리스트
            model.addAttribute("pageMaker", pageMaker);
            
            return "board/notice_list"; // 게시판 JSP로 보냄
            
        } else {
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