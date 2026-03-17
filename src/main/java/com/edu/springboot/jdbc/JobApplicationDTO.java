package com.edu.springboot.jdbc;

import java.sql.Date;

public class JobApplicationDTO {
    private int apply_id;
    private String user_id;
    private String posting_id;
    private String apply_title;
    private String apply_content;
    private String resume_file;
    private String apply_status;
    private Date created_at;
    private Date updated_at;
    
    // 조인해서 보여줄 값
    private String postingTitle;
    private String applicantName;

    public int getApply_id() {
        return apply_id;
    }

    public void setApply_id(int apply_id) {
        this.apply_id = apply_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getPosting_id() {
        return posting_id;
    }

    public void setPosting_id(String posting_id) {
        this.posting_id = posting_id;
    }

    public String getApply_title() {
        return apply_title;
    }

    public void setApply_title(String apply_title) {
        this.apply_title = apply_title;
    }

    public String getApply_content() {
        return apply_content;
    }

    public void setApply_content(String apply_content) {
        this.apply_content = apply_content;
    }

    public String getResume_file() {
        return resume_file;
    }

    public void setResume_file(String resume_file) {
        this.resume_file = resume_file;
    }

    public String getApply_status() {
        return apply_status;
    }

    public void setApply_status(String apply_status) {
        this.apply_status = apply_status;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public Date getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Date updated_at) {
        this.updated_at = updated_at;
    }
    
    public String getPostingTitle() {
        return postingTitle;
    }

    public void setPostingTitle(String postingTitle) {
        this.postingTitle = postingTitle;
    }

    public String getApplicantName() {
        return applicantName;
    }

    public void setApplicantName(String applicantName) {
        this.applicantName = applicantName;
    }
}