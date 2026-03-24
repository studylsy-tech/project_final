package com.project.service;

import com.project.model.MemberDTO;
import com.project.dao.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

    @Autowired
    private MemberMapper memberMapper;

    public void registerMember(MemberDTO member) {
        // 실제 가입 로직 수행 (비밀번호 암호화 등 추가 가능) [cite: 164]
        memberMapper.insertMember(member); // DB 저장 명령 
    }
}