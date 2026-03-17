package com.edu.springboot.jdbc;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IMemberService {
    // 회원 목록 보기
    public List<UserDTO> select();

    // 회원 등록 (회원가입)
    public int insert(UserDTO userDTO);

    // 회원 정보 조회 (수정 폼 불러오기용)
    public UserDTO selectOne(UserDTO userDTO);

    // 회원 정보 수정 처리
    public int update(UserDTO userDTO);

    // 회원 삭제 처리
    public int delete(UserDTO userDTO);
    
// --- [신규 추가] 실전 회원가입/로그인 기능 (user_account 테이블용) ---
    
    // 1. 진짜 회원가입 처리 (UserDTO 사용)
    public int insertUser(UserDTO userDTO); 

    // 2. 진짜 로그인 확인 (아이디/비번 일치 여부)
    public UserDTO loginCheck(UserDTO userDTO);

    // 3. 아이디 중복 체크
    public int checkId(String user_id);
    
 // 4. 아이디 찾기 (이름과 이메일로 조회)
    public String findId(@Param("user_name") String user_name, @Param("user_email") String user_email);
    
 // 5. 이름, 아이디, 이메일이 일치하는 회원이 있는지 확인
    public int checkUserForPw(@Param("user_name") String user_name, 
                             @Param("user_id") String user_id, 
                             @Param("user_email") String user_email);

    // 6. 비밀번호를 임시 비밀번호로 업데이트
    public int updatePw(@Param("user_id") String user_id, 
                        @Param("user_pw") String user_pw);
    
    // 7. 기업 회원 추가 정보(회사명) 업데이트
    public int updateCompanyInfo(UserDTO userDTO);

    
    //------------------------------------------------
    
    //아이디로 정보 찾기 (마이페이지용)
    public UserDTO selectMyPage(@Param("user_id") String user_id);
    
    //유저 정보 업데이트(마이페이지 수정처리용)
    public int updateMyPage(UserDTO userDTO);
}

