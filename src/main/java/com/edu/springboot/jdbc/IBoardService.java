package com.edu.springboot.jdbc;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IBoardService {
    
    // 1. 게시글 목록 보기 (검색 + 페이징 포함)
    public List<BoardDTO> getList(
        @Param("board_type") String board_type, 
        @Param("searchField") String searchField, 
        @Param("searchWord") String searchWord,
        @Param("offset") int offset
    );
    
    public List<BoardDTO> getAllList(String board_type);
    
    // 2. 게시물 갯수 카운트 (페이징 번호 계산용)
    public int getTotalCount(
        @Param("board_type") String board_type,
        @Param("searchField") String searchField, 
        @Param("searchWord") String searchWord
    );

    // 3. 게시글 작성하기
    public int write(BoardDTO dto);
    
    // 4. 게시글 상세 보기
    public BoardDTO getDetail(int idx);
    
    // 5. 게시글 수정하기
    public int update(BoardDTO dto);
    
    // 6. 게시글 삭제하기
    public int delete(int idx);
    
    // 7. 조회수 증가
    public int updateCount(int idx);
    
    //메인페이지에 넣을 리뷰 게시판
    public List<BoardDTO> getTopReviews();
}