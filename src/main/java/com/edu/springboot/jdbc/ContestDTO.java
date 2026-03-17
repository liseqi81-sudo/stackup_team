package com.edu.springboot.jdbc;

import com.fasterxml.jackson.annotation.JsonAlias;

import lombok.Data;

@Data
public class ContestDTO {
	private int contId;
	@JsonAlias("cont_name")
    private String contName;
	private String organizer;
	private java.sql.Date deadline; // 또는 String
	private String logoImg;
	private String siteUrl;
	private String category;
	private java.sql.Timestamp createdate;
	// getter/setter
	// ✅ 즐겨찾기 여부 (Y/N)
	private String is_fav;
	private String is_skillup;

	public String getIs_fav() {
	    return is_fav;
	}

	public void setIs_fav(String is_fav) {
	    this.is_fav = is_fav;
	}

	public String getIs_skillup() {
	    return is_skillup;
	}

	public void setIs_skillup(String is_skillup) {
	    this.is_skillup = is_skillup;
	}
}
