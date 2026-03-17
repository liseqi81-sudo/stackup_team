package com.edu.springboot.jdbc;

import java.util.List;

import lombok.Data;

@Data
public class ProjectDTO {
  private String title;
  private String period;
  private String role;

  private List<String> stack;
  private List<String> highlights;

  private List<ProjectLinkDTO> links;
  
  private String oneLine;     // 한 줄 요약
  private Integer sortOrder;  // 대표 프로젝트 우선순위

  // getter/setter
}