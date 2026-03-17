package com.edu.springboot.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.edu.springboot.jdbc.UserDTO;
import com.edu.springboot.mapper.JobSeekerMapper;

import jakarta.servlet.http.HttpSession;

@ControllerAdvice
public class GlobalModelAdvice {

  @Autowired
  private JobSeekerMapper seekerMapper;

  @ModelAttribute("globalUnreadContactCount")
  public int globalUnreadContactCount(HttpSession session) {
    UserDTO loginUser = (UserDTO) session.getAttribute("user");

    if (loginUser == null) {
      return 0;
    }

    try {
      return seekerMapper.getUnreadContactCount(loginUser.getUser_id());
    } catch (Exception e) {
      return 0;
    }
  }
}