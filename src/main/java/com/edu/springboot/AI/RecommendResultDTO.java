package com.edu.springboot.AI;

public class RecommendResultDTO {
  private String jobId;
  private String jobName;
  private String requiredSpec;
  private String lackSpec;
  private double score;
  
  private String haveSpec;
  private String similarSpec;

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

  public String getRequiredSpec() {
    return requiredSpec;
  }

  public void setRequiredSpec(String requiredSpec) {
    this.requiredSpec = requiredSpec;
  }

  public String getLackSpec() {
    return lackSpec;
  }

  public void setLackSpec(String lackSpec) {
    this.lackSpec = lackSpec;
  }

  public double getScore() {
    return score;
  }

  public void setScore(double score) {
    this.score = score;
  }
  
  public String getHaveSpec() {
	  return haveSpec;
	}
	
	public void setHaveSpec(String haveSpec) {
	  this.haveSpec = haveSpec;
	}
	
	public String getSimilarSpec() {
	    return similarSpec;
	}

	public void setSimilarSpec(String similarSpec) {
	    this.similarSpec = similarSpec;
	}
}