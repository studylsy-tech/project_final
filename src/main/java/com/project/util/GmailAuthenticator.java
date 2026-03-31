package com.project.util;

import java.io.FileReader;
import java.util.Properties;

// 주의: 프로젝트 pom.xml 설정에 따라 javax.mail 또는 jakarta.mail 중 하나로 통일해야 합니다.
// 현재 에러 로그 기준으로는 javax.mail 계열을 사용 중일 확률이 높으므로 패키지명을 확인하세요.
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GmailAuthenticator extends Authenticator {
    
    private String user;        // 발신 메일 계정 (gmail.properties: user)
    private String password;    // 발신 메일 계정 앱 비밀번호 (gmail.properties: password)
    private String receiver;    // 관리자(수신) 메일 계정 (gmail.properties: receiver)
    
    public GmailAuthenticator() {
        Properties prop = new Properties();
        try {
            // 클래스 패스를 통해 gmail.properties 파일 경로 추출
            String path = GmailAuthenticator.class.getResource("/gmail.properties").getPath();
            path = path.replace("%20", " ");
            
            prop.load(new FileReader(path));
            
            this.user = prop.getProperty("user");
            this.password = prop.getProperty("password");
            this.receiver = prop.getProperty("receiver");
        } catch (Exception e) {
            System.err.println(">>> [GmailAuthenticator] 설정 파일을 읽는 중 오류 발생!");
            e.printStackTrace();
        }
    }

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(this.user, this.password);
    }
    
    // 발신자 주소 반환
    public String getUser() {
        return this.user;
    }

    // 수신자 주소 반환
    public String getReceiver() {
        return this.receiver;
    }

    /**
     * 메일 서버 접속 설정 정보 반환
     * TLS v1.2 프로토콜 오류 해결을 위한 설정 포함
     */
    public Properties getInfo() {
        Properties prop = new Properties();
        prop.setProperty("mail.smtp.host", "smtp.gmail.com");
        prop.setProperty("mail.smtp.port", "587");
        prop.setProperty("mail.smtp.auth", "true");
        prop.setProperty("mail.smtp.starttls.enable", "true");
        
        // [핵심 수정] SSLHandshakeException: No appropriate protocol 해결을 위한 코드
        prop.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
        prop.setProperty("mail.smtp.ssl.trust", "smtp.gmail.com");
        
        // 연결 타임아웃 설정 (선택 사항, 네트워크 지연 대비)
        prop.setProperty("mail.smtp.connectiontimeout", "5000");
        prop.setProperty("mail.smtp.timeout", "5000");
        
        return prop;
    }
}