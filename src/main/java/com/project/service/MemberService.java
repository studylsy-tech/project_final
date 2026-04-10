package com.project.service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.MemberMapper;
import com.project.model.MemberDTO;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.service.DefaultMessageService;
@Service
public class MemberService {

	@Autowired
	private MemberMapper memberMapper;
	
	private DefaultMessageService messageService; // coolsms 휴대폰 인증
	

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
	
	// 비밀번호 재설정 (비밀번호만 업데이트)
	public int updatePassword(MemberDTO member) {
	    return memberMapper.updatePassword(member);
	}

	// 비밀번호 찾기 시 회원 존재 여부 확인 (필요하다면 추가)
	public int checkMemberForPw(MemberDTO member) {
	    return memberMapper.checkUserForPw(member);
	}
	
	@PostConstruct
	public void init() {
		// 발급받으신 실제 키를 적용했습니다.
		this.messageService = NurigoApp.INSTANCE.initialize(
            "NCSBDVPFHB4RXIPQ", 
            "S2JASPGD6D3COYUIWCVLUUROSLCMM6J5", 
            "https://api.coolsms.co.kr"
        );
	}

	public void sendSms(String phone, String code) {
		Message message = new Message();
		// [수정 필요] CoolSMS 사이트에 등록한 본인 휴대폰 번호를 숫자만 입력하세요.
		message.setFrom("01095662234"); 
		message.setTo(phone);
		message.setText("[득템] 인증번호는 [" + code + "] 입니다.");

		try {
			this.messageService.sendOne(new SingleMessageSendingRequest(message));
		} catch (Exception e) {
			e.printStackTrace();
			// 에러 발생 시 로그를 남기거나 예외 처리를 추가할 수 있습니다.
		}
	}
	
}