package com.edu.springboot.jdbc; 

import lombok.Data;

import java.util.Date;

@Data
public class QnaDTO {
    private int qna_idx;        // QnA 고유 번호
    private String title;       // 제목
    private String user_id;     // 작성자 아이디
    private String user_name;
    private String content;     // 문의 내용 (CLOB 대응)
    private int count;          // 조회수
    private String qna_status;  // ★ 답변 상태 (WAITING, COMPLETED)
    private Date createdat; // 작성일
}