package com.edu.springboot.AI;

import java.util.List;

public class RecommendRequestDTO {
  private List<UserSkillRequestDTO> user_skills;

  public List<UserSkillRequestDTO> getUser_skills() {
    return user_skills;
  }

  public void setUser_skills(List<UserSkillRequestDTO> user_skills) {
    this.user_skills = user_skills;
  }
}