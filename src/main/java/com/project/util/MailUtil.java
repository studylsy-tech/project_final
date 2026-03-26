package com.project.util;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

/**
 * Spring Boot용 메일 발송 유틸리티
 */
@Component
@RequiredArgsConstructor
public class MailUtil {

    // root-context.xml 빈 등록
    private final JavaMailSender mailSender;

    /**
     * 메일 전송 메소드
     * @param receiver 수신자 이메일
     * @param subject 제목
     * @param content 내용 (HTML 포함 가능)
     */
    public void sendMail(String receiver, String subject, String content) {
        MimeMessage message = mailSender.createMimeMessage();

        try {
            // true: 파일 첨부나 멀티파트 기능을 사용할 때 설정
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(receiver);
            helper.setSubject(subject);
            helper.setText(content, true); // true이면 HTML 태그가 작동함
            
            // 보내는 사람 주소 (application.properties와 동일해야 함)
            helper.setFrom("pafagolue@gmail.com");

            mailSender.send(message);
            System.out.println(">>> [MailUtil] 메일 발송 성공: " + receiver);

        } catch (MessagingException e) {
            System.err.println(">>> [MailUtil] 메일 발송 중 에러 발생!");
            e.printStackTrace();
        }
    }
}