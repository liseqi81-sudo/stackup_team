package com.edu.springboot.jdbc;

import lombok.Data;

@Data
public class EducationDTO {
	private String school; // 학교명 (추가)
	private String major; // 전공 (추가)

	private String degree; // 학사/석사/박사
	private String startDate; // 2022-03
	private String endDate; // 2026-02 (재학이면 null)
	private String status; // 재학/졸업/수료
}