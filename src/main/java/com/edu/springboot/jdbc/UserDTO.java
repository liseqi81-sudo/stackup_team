package com.edu.springboot.jdbc;

import lombok.Data;

@Data
public class UserDTO {
	 private String user_id;      // DB: USER_ID
	 private String user_pw;      // DB: USER_PW
	 private String user_name;    // DB: USER_NAME (기존 코드와 일치)
	 private String user_email;   // DB: USER_EMAIL
	 private String user_phone;   // DB: USER_PHONE
	 private String user_type;    // DB: USER_TYPE
	 private String created_at;   // DB: CREATED_AT
	    
	 // 이미 DB에 있는 기업명 컬럼 추가
	 private String company_name; // DB: COMPANY_NAME
	 private String company_email; // 기업 이메일
	 private String manager_name;  // 담당자 이름 (user_name과 별도로 쓸 경우 추가)
}
