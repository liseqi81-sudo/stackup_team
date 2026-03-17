package com.edu.springboot.jdbc;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IQnaService {
    // QnA 질문 관련
    public List<QnaDTO> getQnaList(@Param("searchField") String searchField, @Param("searchWord") String searchWord);
    public int qnaWrite(QnaDTO qnaDTO);
    public QnaDTO getQnaDetail(int qna_idx);
    public void updateQnaCount(int qna_idx);
    
    // QnA 답변 관련
    public List<QnaCommentDTO> getCommentList(int qna_idx);
    public int commentWrite(QnaCommentDTO commentDTO);
    public void updateQnaStatus(int qna_idx); // 답변 작성 시 상태 변경용
    public int updateQna(QnaDTO qnaDTO);
    public int deleteQna(int qna_idx);
    
    public List<QnaDTO> getQnaList(
            @Param("searchField") String searchField, 
            @Param("searchWord") String searchWord,
            @Param("offset") int offset // XML의 #{offset}으로 전달됨
        );
    public List<QnaDTO> getAllQnaList();
    
        // 전체 개수 조회 (페이징 번호 계산용)
        public int getTotalCount(@Param("searchField") String searchField, @Param("searchWord") String searchWord);
    
}