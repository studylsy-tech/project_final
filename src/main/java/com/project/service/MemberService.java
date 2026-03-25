package com.project.service;

import com.project.model.MemberDTO;
import com.project.dao.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

	@Autowired
	private MemberMapper memberMapper;

	// 회원 가입 
	public void registerMember(MemberDTO member) {
		if ("SEMI".equals(member.getMemberType())) {
			memberMapper.insertSemi(member);  // 반회원
		} else {
			memberMapper.insertFull(member);  // 정회원
		}
		
		// 본인의 확인용 로그 (추후 삭제 가능성 o)
		//										아이디(폰)							로그인 타입
		System.out.println("가입처리 완료 : " + member.getPhone() + " / 타입: " + member.getMemberType());
	}
	
	// 로그인 체크
	public MemberDTO loginCheck(MemberDTO member) {
		return memberMapper.loginCheck(member);
	}
	
	// 회원 정보 수정
	public int updateMember(MemberDTO member) {
		// memberMapper를 호출해서 DB 수정을 요청 후, 수정 성공한 행의 개수 하나를 리턴 함.
	    return memberMapper.updateMember(member);
	}
}