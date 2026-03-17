
package com.edu.springboot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.edu.springboot.jdbc.ContestDTO;

@Mapper
public interface ContestMapper {

    List<ContestDTO> selectTop6();   // 👈 추가

    List<ContestDTO> selectList(
    	    @Param("keyword") String keyword,
    	    @Param("category") String category,
    	    @Param("sort") String sort,
    	    @Param("userId") String userId
    	);

    int countList(
        @Param("keyword") String keyword,
        @Param("category") String category,
        @Param("sort") String sort
    );
    List<ContestDTO> selectAll();
    List<String> selectCategoryList();
    
    int checkUserIng(String userId, String targetId, String type);

    int addUserIng(String userId, String targetId, String type, int progress);

    int removeUserIng(String userId, String targetId, String type);
}