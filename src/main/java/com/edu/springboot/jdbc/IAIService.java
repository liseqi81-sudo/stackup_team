package com.edu.springboot.jdbc;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAIService {
    List<AIrecomedDTO> getRecommendList();
    List<Map<String, Object>> getSkillListByIds(List<String> skillIds);
}