package com.edu.springboot.jdbc;

import lombok.Data;
import java.util.Date;

@Data
public class JobContactDTO {
	private int contactId;
	private String receiverId;
	private Integer seekId;
	private String senderId;
	private String contactTitle;
	private String contactContent;
	private String companyInfo;
	private String jobInfo;
	private String fileOrgName;
	private String fileSavedName;
	private String filePath;
	private String readYn;
	private Date createdAt;
	private Date readAt;
}