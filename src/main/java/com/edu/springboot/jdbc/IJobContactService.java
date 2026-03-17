package com.edu.springboot.jdbc;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IJobContactService {

    int insertContact(JobContactDTO dto);

    List<JobContactDTO> getReceivedContacts(@Param("receiverId") String receiverId);

    JobContactDTO getContactDetail(@Param("contactId") int contactId);

    int updateReadStatus(@Param("contactId") int contactId);

    int getUnreadContactCount(@Param("receiverId") String receiverId);
}