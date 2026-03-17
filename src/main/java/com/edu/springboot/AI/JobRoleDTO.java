package com.edu.springboot.AI;

public class JobRoleDTO {

	private String jobId;
	  private String jobName;
	  private String jobDesc;

	  public JobRoleDTO() {}

	  public String getJobId() {
	    return jobId;
	  }

	  public void setJobId(String jobId) {
	    this.jobId = jobId;
	  }

	  public String getJobName() {
	    return jobName;
	  }

	  public void setJobName(String jobName) {
	    this.jobName = jobName;
	  }

	  public String getJobDesc() {
	    return jobDesc;
	  }

	  public void setJobDesc(String jobDesc) {
	    this.jobDesc = jobDesc;
	  }
}
