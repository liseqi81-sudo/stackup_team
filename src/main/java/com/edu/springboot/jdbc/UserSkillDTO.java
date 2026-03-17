package com.edu.springboot.jdbc;

import lombok.Data;

@Data
public class UserSkillDTO {
    private String usId;         // US_ID
    private String userId;    // USER_ID
    private String skillId;      // SKILL_ID
    private int userLevel;    // USER_LEVEL (차트 비중 결정 요소)
    private int skillYears;   // SKILL_YEARS
}