package com.edu.springboot.jdbc;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ICertifiService {
	public List<CertifiDTO> certifiList(String userId);
	
	List<CertifiDTO> selectTop5PopularCerti();
	
	List<CertifiDTO> selectTop5Deadline();

	public List<Map<String, Object>> getTypeCounts();
	
	List<CertifiDTO> getCategoryList();
	
	// 즐겨찾기 추가/삭제를 위한 메서드 정의
	public int addFavorite(String userId, String targetId, String targetType);
	
	public int removeFavorite(String userId, String targetId, String targetType);
	
	//skillup에 추가
	int addUserIng(String userId, String targetId, String type, int status);
	int removeUserIng(String userId, String targetId, String type);
	int checkUserIng(String userId, String targetId, String type);

}
