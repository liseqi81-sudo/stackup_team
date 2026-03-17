package com.edu.springboot.auth;

import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.edu.springboot.jdbc.IMemberService;
import com.edu.springboot.jdbc.UserDTO;

import jakarta.servlet.http.HttpSession;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    @Autowired
    private IMemberService dao; 

    @Autowired
    private HttpSession session;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) {
        System.out.println("========== 네이버 로그인 시도 중! =========="); 
        OAuth2User oAuth2User = super.loadUser(userRequest);
        Map<String, Object> attributes = oAuth2User.getAttributes();
        
        Map<String, Object> response = (Map<String, Object>) attributes.get("response");

        String email = (String) response.get("email");
        String name = (String) response.get("name");

        // 1. 이미 등록된 회원인지 확인
        int count = dao.checkId(email);

        if (count == 0) {
            // 2. 신규 회원이면 USER_ACCOUNT 테이블에 insert
            UserDTO dto = new UserDTO();
            dto.setUser_id(email);    
            dto.setUser_name(name);   
            dto.setUser_email(email);
            dto.setUser_pw(UUID.randomUUID().toString().substring(0, 8)); 
            dto.setUser_type("USER"); 
            
            dao.insertUser(dto); 
        }
        
        // ✅ [해결 로직] 에러 지점: 변수 선언 추가
        // DB에서 최신 정보를 가져와 'user'라는 이름의 변수에 담습니다.
        UserDTO user = dao.selectMyPage(email); 
        
        // 이제 'user' 변수가 정의되었으므로 아래 if문에서 에러가 나지 않습니다.
        if (user != null) {
            // JSP에서 ${sessionScope.user.user_name}으로 쓸 수 있게 세션 저장
            session.setAttribute("user", user); 
            
            // 기존 개별 세션 방식도 유지
            session.setAttribute("userId", user.getUser_id());
            session.setAttribute("userName", user.getUser_name());
        }
        
        System.out.println("네이버 로그인 및 세션 저장 완료: " + email);
        return oAuth2User;
    }
}