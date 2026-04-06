package com.project.service;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.MemberMapper;
import com.project.model.MemberDTO;

@Service
public class MemberService {

	@Autowired
	private MemberMapper memberMapper;

	// 회원 가입
	public void registerMember(MemberDTO member) {
		if (member.getMemberType() == 1) { // 준회원 타입 체크
			memberMapper.insertSemiMember(member);
		} else {
			memberMapper.insertFull(member);
		}
	}

	// 로그인 체크
	public MemberDTO loginCheck(MemberDTO member) {
		return memberMapper.loginCheck(member);
	}

	// 회원 정보 수정
	public int updateMember(MemberDTO member) {
		return memberMapper.updateMember(member);
	}

	// 자동 로그인 쿠키 관리
	public void handleCookie(String phone, String rememberMe, HttpServletResponse response) {
		if ("on".equals(rememberMe)) {
			Cookie cookie = new Cookie("rememberID", phone);
			cookie.setMaxAge(60 * 60 * 24 * 7);
			cookie.setPath("/");
			response.addCookie(cookie);
		} else {
			Cookie cookie = new Cookie("rememberID", null);
			cookie.setMaxAge(0);
			cookie.setPath("/");
			response.addCookie(cookie);
		}
	}

	// 회원 삭제 (강제 탈퇴 포함)
	public void deleteMember(String phone) {
		memberMapper.deleteMember(phone);
	}

	// 준회원 가입 처리
	public int insertSemiMember(MemberDTO member) {
		return memberMapper.insertSemiMember(member);
	}

	// [수정] 전체 회원 수 조회
	public int getTotalMemberCount() {
		// Mapper를 호출하여 DB의 전체 회원 수를 반환합니다.
		return memberMapper.getTotalMemberCount();
	}

	// [수정] 전체 회원 목록 조회
	public List<MemberDTO> selectAllMembers() {
		// Mapper를 호출하여 DB의 모든 회원 데이터를 리스트로 가져옵니다.
		return memberMapper.selectAllMembers();
	}

}