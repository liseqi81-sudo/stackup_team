package com.edu.springboot.jdbc;

import lombok.Data;

@Data
public class PortfolioNewDTO {
	private Long portfolioId;
	private String userId;
	private String title;
	private String templateCode;
	private String slug;
	private String status;
	private String outputPath;
	private String thumbnailPath;
	private String portraitPath;
	private java.sql.Date createdAt;
	private java.sql.Date updatedAt;
	// getter/setter
}
