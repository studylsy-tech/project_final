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
        
        if("SEMI".equals(member.getMemberType())) { // 회원 타입 구분
        	// 반회원 가입 용
        	memberMapper.insertSemiMember(member);
        }else {
        	// 정회원 가입 용
        	
        	// 실제 가입 로직 수행 (비밀번호 암호화 등 추가 가능) [cite: 164]
            memberMapper.insertMember(member); // DB 저장 명령 
        } // end getMemberType
        
        // TODO 정상 출력 되는지 여부 확인 후 지울 것.
        //									  반회원									회원 타입
        System.out.println("가입처리 완료 : " + member.getPhone() + " / 타입: " + member.getMemberType());
        
    }
    
    // 로그인 체크 메서드 - 컨트롤러에서 사용예정
    public MemberDTO loginCheck(MemberDTO member) {
    	return memberMapper.loginCheck(member);
    }
    
} // end MemberService