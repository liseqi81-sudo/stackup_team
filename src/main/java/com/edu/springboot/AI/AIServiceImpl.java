package com.edu.springboot.AI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.springboot.mapper.AIrecomedMapper;

@Service
public class AIServiceImpl implements AIService {

  @Autowired
  private AIrecomedMapper dao;

  @Override
  public void saveRecommendedJob(String userId, SaveRecommendedJobDTO dto) {

    int exists = dao.existsUserJob(userId);

    if (exists > 0) {
      dao.updateUserJob(userId, dto.getJobId());
    } else {
      dao.insertUserJob(userId, dto.getJobId());
    }

    String lackSpec = dto.getLackSpec();

    if (lackSpec == null || lackSpec.trim().isEmpty() || "없음".equals(lackSpec.trim())) {
      return;
    }

    String[] skills = lackSpec.split(",");

    for (String skillName : skills) {
      String trimmedSkill = skillName.trim();

      if (trimmedSkill.isEmpty()) {
        continue;
      }

      String skillId = dao.findSkillIdByName(trimmedSkill);

      if (skillId == null || skillId.trim().isEmpty()) {
        continue;
      }

      int skillCount = dao.checkUserSkill(userId, skillId);

      if (skillCount == 0) {
        dao.insertUserSkill(userId, skillId, 0);
      }
    }
  }
}