package com.edu.springboot.AI;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AIrecomeDAO {
	  int checkUserJob(@Param("userId") String userId, @Param("jobId") String jobId);

	  int existsUserJob(@Param("userId") String userId);

	  int insertUserJob(@Param("userId") String userId,
	                    @Param("jobId") String jobId);

	  int updateUserJob(@Param("userId") String userId,
	                    @Param("jobId") String jobId);

	  String findSkillIdByName(@Param("skillName") String skillName);

	  int checkUserSkill(@Param("userId") String userId, @Param("skillId") String skillId);

	  int insertUserSkill(@Param("userId") String userId,
	                      @Param("skillId") String skillId,
	                      @Param("level") int level);
	}