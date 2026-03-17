package com.edu.springboot.AI;

public class SaveRecommendedJobDTO {
	 private String jobId;
	    private String jobName;
	    private String lackSpec;
	    private String mode;

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

	    public String getLackSpec() {
	        return lackSpec;
	    }
	    public void setLackSpec(String lackSpec) {
	        this.lackSpec = lackSpec;
	    }

	    public String getMode() {
	        return mode;
	    }
	    public void setMode(String mode) {
	        this.mode = mode;
	    }
}
