package com.edu.springboot.jdbc;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.edu.springboot.skillup.SkillDTO;
import com.edu.springboot.skillup.UserJobDTO;

@Mapper
public interface ISkillupService {
	
	//메인 D-Day DTO
	MainExamDTO selectMainExam(String userId);
	
    // 사용자의 진행 중인 항목 가져오기
    List<UserIngDTO> selectUserIngList(String userId);
    
    // 사용자의 스킬 역량 데이터 가져오기
    List<UserSkillDTO> selectUserSkillList(String userId);
    
    // 사용자의 즐겨찾기 목록 가져오기
    List<SavedItemDTO> selectSavedItemList(String userId);

    //??
    List<Map<String, Object>> selectAllSkills();
    
    //사용자의 진행중인 항목 삭제
    int deleteUserIngByUser(java.util.Map<String, String> params);
    int removeFavorite(String userId, String targetId, String targetType);
    
    public int deleteUserSkills(String userId); 
    public int insertUserSkill(UserSkillDTO userSkillDTO);
    
    //
    UserJobDTO selectUserJob(String userId);
    List<SkillDTO> selectJobSkills(String jobCategory);
    
 // [추가] 인증을 위한 특정 진행 항목 정보 가져오기
    UserIngDTO getIngInfo(String ingId);

    // [추가] 진행률 업데이트
    int updateStatus(UserIngDTO vo);
}