package com.edu.springboot.jdbc;

import lombok.Data;

@Data
public class ResumeSkillDTO {
    private String skillName;   // skill.skill_name
    private Integer userLevel;  // user_skill.user_level
}