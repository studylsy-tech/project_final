package com.project.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.AdminMapper;

@Service
public class AdminServiceImpl implements AdminService {
    
    @Autowired
    private AdminMapper adminMapper;

    @Override
    public Map<String, Object> getDashboardStats() {
        System.out.println("AdminServiceImpl - getDashboardStats called");
        
        Map<String, Object> stats = adminMapper.getDashboardStats();
        System.out.println("AdminServiceImpl - stats: " + stats);
        
        return stats; // 수정: 재귀 호출 대신 결과 반환
    }
}