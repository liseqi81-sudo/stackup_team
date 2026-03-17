package com.edu.springboot.jdbc;

import java.util.Date;

import lombok.Data;

@Data
public class MainExamDTO {
  private String examName;
  private int dayLeft;      // 남은 날짜 (숫자)
  private Date examDate;   // 실제 시험 날짜
  private String targetType;
  private String targetId;
}