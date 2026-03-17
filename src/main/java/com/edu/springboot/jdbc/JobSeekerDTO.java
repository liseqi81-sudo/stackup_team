package com.edu.springboot.jdbc;

import lombok.Data;

@Data
public class JobSeekerDTO {
    private int seekId;          // SEEK_ID
    private String userId;       // USER_ID
    private String userName;
    private String seekTitle;    // SEEK_TITLE (기존 title에서 변경)
    private String seekCategory; // SEEK_CATEGORY (기존 category에서 변경)
    private String skills;       // SKILLS
    private String contents;     // CONTENTS (기존 content에서 변경)
    private String createDate;   // CREATE_DATE (기존 regidate에서 변경)
    private String seekUrl;      // SEEK_URL
    private String isFav;        // IS_FAV
    
    private String seekFile;     //첨부파일
}