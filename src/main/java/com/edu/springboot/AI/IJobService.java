package com.edu.springboot.AI;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IJobService {

	  public List<JobRoleDTO> getJobRoleList();

	}