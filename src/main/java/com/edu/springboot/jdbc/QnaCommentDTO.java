package com.edu.springboot.jdbc; 

import lombok.Data;
import java.sql.Timestamp;

@Data
public class QnaCommentDTO {
    private int comment_idx;    // 답변 고유 번호
    private int qna_idx;        // ★ 어떤 질문에 대한 답변인지 (FK)
    private String user_id;     // 답변자 아이디 (관리자 등)
    private String user_name;
    private String content;     // 답변 내용
    private String is_picked;   // 답변 채택 여부 (Y/N)
    private Timestamp createdat; // 답변 작성일
}