package com.edu.springboot.jdbc;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class JobPostingDTO {
	private String postingId;
	private String jobCategory;
    private String companyName;
    private String title;
    private String skills;
    private String postType;
    private String postingUrl;
    private java.sql.Date createdate;
    private String contents;
    private String writerId;
    //즐겨찾기 여부
    private String is_fav;


    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date deadline;
}
