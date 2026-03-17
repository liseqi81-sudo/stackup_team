package com.edu.springboot.jdbc;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IJobApplicationService {
    int insertApplication(JobApplicationDTO dto);
    int checkDuplicateApplication(@Param("user_id") String user_id, @Param("posting_id") String posting_id);
    List<JobApplicationDTO> getApplicationsByUser(String user_id);
    List<JobApplicationDTO> getApplicationsByPosting(int posting_id);
    List<JobApplicationDTO> selectApplicationsByCompany(@Param("companyId") String companyId);
    
}