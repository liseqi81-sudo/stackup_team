package com.edu.springboot.AI;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.edu.springboot.mapper.AIrecomedMapper;

@Service
public class AIRecommendService {

  private static final String PYTHON_API_URL = "http://127.0.0.1:8000/recommend";

  public List<RecommendResultDTO> recommendJobs(List<UserSkillRequestDTO> userSkills) {
    try {
      RestTemplate restTemplate = new RestTemplate();

      RecommendRequestDTO requestDto = new RecommendRequestDTO();
      requestDto.setUser_skills(userSkills);

      HttpHeaders headers = new HttpHeaders();
      headers.setContentType(MediaType.APPLICATION_JSON);

      HttpEntity<RecommendRequestDTO> requestEntity =
          new HttpEntity<>(requestDto, headers);

      ResponseEntity<RecommendResultDTO[]> response = restTemplate.exchange(
          PYTHON_API_URL,
          HttpMethod.POST,
          requestEntity,
          RecommendResultDTO[].class
      );

      RecommendResultDTO[] body = response.getBody();
      if (body == null) {
        return Collections.emptyList();
      }

      List<String> userSkillNames = new ArrayList<>();
      for (UserSkillRequestDTO skill : userSkills) {
        if (skill != null && skill.getName() != null) {
          userSkillNames.add(normalize(skill.getName()));
        }
      }

      List<RecommendResultDTO> result = new ArrayList<>();

      for (RecommendResultDTO dto : body) {
    	    if (dto == null) {
    	        continue;
    	    }

    	    List<String> requiredList = parseSkills(dto.getRequiredSpec());
    	    List<String> haveList = new ArrayList<>();
    	    List<String> similarList = new ArrayList<>();
    	    List<String> lackList = new ArrayList<>();

    	    for (String requiredSkill : requiredList) {
    	        String normalizedRequired = normalize(requiredSkill);

    	        boolean exactMatched = false;
    	        boolean similarMatched = false;
    	        String matchedUserSkill = null;

    	        for (String userSkill : userSkillNames) {
    	            if (normalizedRequired.equals(userSkill)) {
    	                exactMatched = true;
    	                matchedUserSkill = userSkill;
    	                break;
    	            }
    	        }

    	        if (!exactMatched) {
    	            for (String userSkill : userSkillNames) {
    	                if (isSimilarSkill(normalizedRequired, userSkill)) {
    	                    similarMatched = true;
    	                    matchedUserSkill = userSkill;
    	                    break;
    	                }
    	            }
    	        }

    	        if (exactMatched) {
    	            haveList.add(requiredSkill);
    	        } else if (similarMatched) {
    	            similarList.add(requiredSkill + " ← " + matchedUserSkill);
    	        } else {
    	            lackList.add(requiredSkill);
    	        }
    	    }

    	    dto.setRequiredSpec(requiredList.isEmpty() ? "없음" : String.join(", ", requiredList));
    	    dto.setHaveSpec(haveList.isEmpty() ? "없음" : String.join(", ", haveList));
    	    dto.setSimilarSpec(similarList.isEmpty() ? "없음" : String.join(", ", similarList));
    	    dto.setLackSpec(lackList.isEmpty() ? "없음" : String.join(", ", lackList));

    	    result.add(dto);
    	}

      return result;

    } catch (Exception e) {
      e.printStackTrace();
      return Collections.emptyList();
    }
  }

  private List<String> parseSkills(String spec) {
    if (spec == null || spec.trim().isEmpty()) {
      return Collections.emptyList();
    }

    String normalized = spec.trim();
    String[] tokens;

    if (normalized.contains(",")) {
      tokens = normalized.split("\\s*,\\s*");
    } else {
      tokens = normalized.split("\\s+");
    }

    List<String> result = new ArrayList<>();
    for (String token : tokens) {
      String skill = token.trim();
      if (!skill.isEmpty() && !result.contains(skill)) {
        result.add(skill);
      }
    }
    return result;
  }

  private String normalize(String skill) {
    return skill == null ? "" : skill.trim().toLowerCase();
  }

  private boolean isSimilarSkill(String requiredSkill, String userSkill) {
    if (requiredSkill.equals(userSkill)) {
      return true;
    }

    if (requiredSkill.equals("tcp/ip") && (userSkill.equals("tcp") || userSkill.equals("ip"))) {
      return true;
    }

    if (userSkill.equals("tcp/ip") && (requiredSkill.equals("tcp") || requiredSkill.equals("ip"))) {
      return true;
    }

    if (requiredSkill.equals("cloud") && userSkill.equals("aws")) {
      return true;
    }

    if (requiredSkill.equals("aws") && userSkill.equals("cloud")) {
      return true;
    }

    return false;
  }
  
  @Autowired
  AIrecomedMapper aiRecomedMapper;
  
  public void saveUserSkills(String userId, List<UserSkillRequestDTO> userSkills) {
	    aiRecomedMapper.deleteUserSkills(userId);

	    for (UserSkillRequestDTO skill : userSkills) {
	        if (skill.getName() == null || skill.getName().trim().isEmpty()) {
	            continue;
	        }

	        int level = skill.getLevel();
	        if (level < 0) {
	            level = 0;
	        }

	        String skillId = aiRecomedMapper.findSkillIdByName(skill.getName());

	        if (skillId == null || skillId.trim().isEmpty()) {
	            System.out.println("SKILL 테이블에 없는 스킬명: " + skill.getName());
	            continue;
	        }

	        aiRecomedMapper.insertUserSkill(userId, skillId, level);
	    }
	}
  
  public void saveUserJob(String userId, String jobId) {

	    int exists = aiRecomedMapper.existsUserJob(userId);

	    if (exists > 0) {
	        aiRecomedMapper.updateUserJob(userId, jobId);
	    } else {
	        aiRecomedMapper.insertUserJob(userId, jobId);
	    }
	}
  public int existsUserJob(String userId) {
	    return aiRecomedMapper.existsUserJob(userId);
	}
}