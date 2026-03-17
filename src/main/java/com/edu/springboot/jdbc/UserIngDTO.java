package com.edu.springboot.jdbc;

import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import lombok.Data;

@Data
public class UserIngDTO {
	    private String ingId;        // ING_ID
	    private String userId;    // USER_ID
	    private String targetType;// TARGET_TYPE (자격증, 강의 등 구분)
	    private String targetId;     // TARGET_ID
	    private int status;    // 퍼센티지
	    private Date lastAuthDate;
	    
	    // 추가 필드: DB Join을 통해 가져올 정보 (화면 표시용)
	    private String targetName; // 자격증 명칭
	    private String examDate;   // 시험 날짜 (D-Day 계산용)
	
	    public int getDayLeft() {
	        if (this.examDate == null || this.examDate.isEmpty()) return 0;
	        try {
	            LocalDate target = LocalDate.parse(this.examDate.substring(0, 10));
	            LocalDate today = LocalDate.now();
	            return (int) ChronoUnit.DAYS.between(today, target);
	        } catch (Exception e) {
	            return 0;
	        }
	    }
}
