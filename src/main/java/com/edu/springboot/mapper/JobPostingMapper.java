package com.edu.springboot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.edu.springboot.jdbc.JobPostingDTO;

@Mapper
public interface JobPostingMapper {

    List<JobPostingDTO> selectList(
        @Param("keyword") String keyword,
        @Param("category") String category,
        @Param("offset") int offset,
        @Param("pageSize") int pageSize
    );

    int countList(
        @Param("keyword") String keyword,
        @Param("category") String category
    );

    JobPostingDTO selectOne(@Param("postingId") String postingId);

    int insert(JobPostingDTO dto);

    int update(JobPostingDTO dto);

    int delete(@Param("postingId") String postingId);
    
    List<JobPostingDTO> selectAll(
    	    @Param("keyword") String keyword,
    	    @Param("category") String category,
    	    @Param("userId") String userId
    	);
    
 // ✅ 메인에 뿌릴 상위 5개
    List<JobPostingDTO> selectTop5();
}