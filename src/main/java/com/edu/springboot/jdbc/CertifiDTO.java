package com.edu.springboot.jdbc;

import lombok.Data;

@Data 
public class CertifiDTO {
    private String certi_id;
    private String certi_name;
    private String organizer;
    private int is_regular;
    private String certi_type;
    private String main_category;
    private String sub_category;
    private String url;
    private String is_fav;
    private String is_ing;
    
    
    private java.sql.Date deadline;  // reg_end_date의 MIN 값
    private int d_day;               // D-day
    
    
    private java.util.Date deadline_written;
    private int d_day_written;
    private java.util.Date deadline_practical;
    private int d_day_practical;
    
    private String is_skillup;

    public String getIs_skillup() {
      return is_skillup;
    }

    public void setIs_skillup(String is_skillup) {
      this.is_skillup = is_skillup;
    }
}