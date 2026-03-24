package com.project.dao;

import com.project.model.MemberDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {
    
    // 1. 초기 회원 정보 저장 (기존 메서드)
    void insertMember(MemberDTO member);

    // 2. 반회원 가입 (휴대폰 번호, 비밀번호 저장)
    int insertSemiMember(MemberDTO member);

    // 3. 로그인 처리 (아이디/비밀번호 확인)
    MemberDTO loginCheck(MemberDTO member);
    
    // 4. 정회원 전환 (이름, 이메일 등 추가 정보 업데이트)
    int updateToFullMember(MemberDTO member);
}