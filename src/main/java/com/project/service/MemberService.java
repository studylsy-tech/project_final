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
	    if ("SEMI".equals(member.getMemberType())) {
	        memberMapper.insertSemi(member);
	    } else {
	        memberMapper.insertFull(member);
	    }
	}
	
    
    // 로그인 체크 메서드 - 컨트롤러에서 사용예정
    public MemberDTO loginCheck(MemberDTO member) {
    	return memberMapper.loginCheck(member);
    }
    
} // end MemberService