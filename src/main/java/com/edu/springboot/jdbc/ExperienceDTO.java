package com.edu.springboot.jdbc;

import java.util.List;

import lombok.Data;

@Data
public class ExperienceDTO {
	private String title;
	private String company;
	private String period;
	private List<String> description;

	private String location; // 선택
	private String type; // 인턴/정규/프로젝트/동아리 등
	private Integer sortOrder; // 대표 활동 우선순위

	// getters/setters
}