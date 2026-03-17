package com.edu.springboot.jdbc;

import org.springframework.web.multipart.MultipartFile;
import lombok.Data;
import java.sql.Date;

@Data 
public class JobSeekerContactDTO {
    private int contactId;          // CONTACT_ID
    private int seekId;             // SEEK_ID
    private String userId;          // USER_ID (받는 구직자)
    private String senderId;        // SENDER_ID (보내는 기업)

    private String contactTitle;    // CONTACT_TITLE 추가
    private String contactContent;  // CONTACT_CONTENT
    private String companyInfo;     // COMPANY_INFO
    private String jobInfo;         // JOB_INFO

    private String cardImg;         // CARD_IMG
    private String remark;          // REMARK
    private String readYn;          // READ_YN 추가
    private Date createDate;        // CREATE_DATE
    private Date readDate;          // READ_DATE 추가해도 좋음

    private MultipartFile uploadFile;
}