package com.project.util;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.springframework.stereotype.Component;

/**
 * GmailAuthenticator를 이용한 메일 발송 유틸리티
 */
@Component
public class MailUtil {

    /**
     * 메일 전송 메소드
     * @param receiver 수신자 이메일
     * @param subject 제목
     * @param content 내용 (HTML 포함 가능)
     */
    public void sendMail(String receiver, String subject, String content) {
        
        // 1. 인증 객체 생성 (gmail.properties 정보를 읽어옴)
        GmailAuthenticator auth = new GmailAuthenticator();
        
        // 2. 메일 서버 접속 설정 정보 가져오기 (TLS v1.2 설정 포함됨)
        Properties prop = auth.getInfo();
        
        // 3. 세션 생성 (설정과 인증 정보를 결합)
        Session session = Session.getInstance(prop, auth);
        
        // 통신 과정을 상세히 보고 싶다면 true로 설정 (에러 디버깅 시 유용)
        session.setDebug(true); 

        try {
            // 4. 메세지 객체 생성 및 설정
            Message message = new MimeMessage(session);
            
            // 보내는 사람 (Authenticator에서 읽어온 발신 계정)
            message.setFrom(new InternetAddress(auth.getUser()));
            
            // 받는 사람
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
            
            // 제목
            message.setSubject(subject);
            
            // 내용 (HTML 형식 지정)
            message.setContent(content, "text/html; charset=utf-8");

            // 5. 실제 메일 발송
            Transport.send(message);
            
            System.out.println(">>> [MailUtil] 메일 발송 성공: " + receiver);

        } catch (Exception e) {
            System.err.println(">>> [MailUtil] 메일 발송 중 에러 발생!");
            e.printStackTrace();
        }
    }
}