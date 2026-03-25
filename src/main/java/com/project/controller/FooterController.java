package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.dao.FooterMapper;
import com.project.model.FooterInquiryVO;

@Controller
@RequestMapping("/footer")
public class FooterController {
    
    @Autowired
    private FooterMapper footerMapper;
    
    @GetMapping("/support.do")
    public String supportPage() {
        return "footer/support";
    }
    
    @PostMapping("/support.do")
    public String insertInquiry(FooterInquiryVO vo) {
        System.out.println("접수된 문의: " + vo);
        
        int result = footerMapper.insertInquiry(vo);
        
        if(result > 0) {
            System.out.println("DB 저장 성공!");
        }
        
        return "redirect:/footer/support.do";
    } // insertInquiry 메서드 끝
} // FooterController 클래스 끝