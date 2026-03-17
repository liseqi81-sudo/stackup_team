package com.edu.springboot.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.edu.springboot.jdbc.JobSeekerDTO;
import com.edu.springboot.jdbc.JobSeekerContactDTO;

@Mapper
public interface JobSeekerMapper {

    // 🚩 수정: offset과 pageSize를 삭제하고 keyword와 category만 남깁니다.
    // 이렇게 해야 Controller의 seekerMapper.selectAll(keyword, category)와 짝이 맞습니다.
    List<JobSeekerDTO> selectAll(
        @Param("keyword") String keyword, 
        @Param("category") String category
    );

    // 검색 조건에 맞는 전체 개수
    int countList(
        @Param("keyword") String keyword, 
        @Param("category") String category
    );

    // 상세 보기
    JobSeekerDTO selectOne(@Param("seekId") int seekId);

    // 글 작성
    int insert(JobSeekerDTO dto);

    // 글 수정
    int update(JobSeekerDTO dto);

    // 글 삭제
    int delete(@Param("seekId") int seekId);

    // 채용 제안 저장
    int insertContact(JobSeekerContactDTO dto);
    
    // 받은 채용 제안 목록
    List<JobSeekerContactDTO> getReceivedContacts(@Param("userId") String userId);

    // 안 읽은 채용 제안 개수
    int getUnreadContactCount(@Param("userId") String userId);

    // 채용 제안 상세
    JobSeekerContactDTO getContactDetail(@Param("contactId") int contactId);

    // 읽음 처리
    int updateReadYn(@Param("contactId") int contactId);
    
    JobSeekerContactDTO getReceivedContactDetail(int contactId);
    
    //읽음처리
    int updateReadDate(int contactId);
    
    
}