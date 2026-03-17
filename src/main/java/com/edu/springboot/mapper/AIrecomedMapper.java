package com.edu.springboot.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AIrecomedMapper {

  List<Map<String, Object>> getAllSkills();

  List<Map<String, Object>> getUserSkills(@Param("userId") String userId);

  int deleteUserSkills(@Param("userId") String userId);

  String findSkillIdByName(@Param("skillName") String skillName);

  int insertUserSkill(@Param("userId") String userId,
                      @Param("skillId") String skillId,
                      @Param("skillLevel") int skillLevel);

  int checkUserJob(@Param("userId") String userId,
                   @Param("jobId") String jobId);

  int checkUserSkill(@Param("userId") String userId,
                     @Param("skillId") String skillId);

  int existsUserJob(@Param("userId") String userId);

  int insertUserJob(@Param("userId") String userId,
                    @Param("jobId") String jobId);

  int updateUserJob(@Param("userId") String userId,
                    @Param("jobId") String jobId);
}