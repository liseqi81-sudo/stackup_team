package com.edu.springboot.jdbc; 

import lombok.Data;
import java.sql.Timestamp;

@Data
public class BoardDTO {
    private int idx;
    private String title;
    private String user_id;
    private String user_name;
    private String content;
    private String board_type;
    private int count;
    private int liked;
    private int comment_cnt;
    private Timestamp createdat; 
    private int review_star;
}