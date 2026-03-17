package com.edu.springboot.jdbc;

import lombok.Data;

@Data
public class PortfolioSnapshotDTO {
	  private Long snapshotId;
	  private Long portfolioId;
	  private String snapshotJson; // CLOB -> String
	  private java.sql.Date createdAt;
	  // getter/setter
	}
