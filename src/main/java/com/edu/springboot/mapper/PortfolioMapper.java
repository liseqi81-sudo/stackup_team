package com.edu.springboot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.edu.springboot.jdbc.PortfolioNewDTO;
import com.edu.springboot.jdbc.PortfolioSnapshotDTO;
import com.edu.springboot.jdbc.ProjectDTO;
import com.edu.springboot.jdbc.ResumeDTO;
import com.edu.springboot.jdbc.ResumeSkillDTO;

@Mapper
public interface PortfolioMapper {

	List<String> selectUserSkills(@Param("userId") String userId);

	List<ResumeSkillDTO> selectUserSkillItems(@Param("userId") String userId);

	List<String> selectCertNamesByIds(@Param("ids") List<String> ids);

	List<String> selectContestNamesByIds(@Param("ids") List<String> ids);

	PortfolioSnapshotDTO selectLatestSnapshotByUserId(@Param("userId") String userId);

	PortfolioSnapshotDTO selectLatestSnapshot(@Param("portfolioId") long portfolioId);

	int insertSnapshot(@Param("portfolioId") long portfolioId, @Param("snapshotJson") String snapshotJson);

	int insertPortfolioSnapshot(@Param("portfolioId") long portfolioId, @Param("snapshotJson") String snapshotJson);

	List<PortfolioNewDTO> selectPortfoliosByUserId(@Param("userId") String userId);

	PortfolioNewDTO selectPortfolioById(@Param("portfolioId") long portfolioId);

	Long selectPortfolioIdByUserAndTemplate(@Param("userId") String userId, @Param("templateCode") String templateCode);

	int insertPortfolioNew(@Param("userId") String userId, @Param("title") String title,
			@Param("templateCode") String templateCode, @Param("slug") String slug, @Param("status") String status);

	int countSnapshotsByPortfolioId(@Param("portfolioId") long portfolioId);

	int updatePortfolioOutput(@Param("portfolioId") long portfolioId, @Param("outputPath") String outputPath,
			@Param("thumbnailPath") String thumbnailPath);

	int updateLatestSnapshotJson(@Param("portfolioId") Integer portfolioId, @Param("userId") String userId,
			@Param("snapshotJson") String snapshotJson);
}