package com.project.dao;

import com.project.model.MemberDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface MemberMapper {

	// 1. 초기 회원 정보 저장 (기존 메서드)
	void insertFull(MemberDTO member);

	// 2. 반회원 가입 (휴대폰 번호, 비밀번호 저장)
	void insertSemi(MemberDTO member);

	// 3. 로그인 처리 (아이디/비밀번호 확인)
	MemberDTO loginCheck(MemberDTO member);

	// 4. 정회원 전환 (이름, 이메일 등 추가 정보 업데이트)
	int updateToFullMember(MemberDTO member);

	// 5. 내 정보 수정 (준회원/정회원 공통. 4번은 전환이라면 관리자 용도인가요..?)
	int updateMember(MemberDTO member);

	void deleteMember(String phone);

	int insertSemiMember(MemberDTO member);
	
	// 비밀번호 업데이트
	@Update("UPDATE members SET pw = #{pw} WHERE phone = #{phone}")
    int updatePassword(MemberDTO member);

    // 비밀번호 찾기 시 회원 확인
    int checkUserForPw(MemberDTO member);
	
}