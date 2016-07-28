package com.example.bean;

public class PPage {
	private String s_type = null; 	//검색타입
	private String s_text = null; 	//검색어
	private int page = 0;			//페이지네이션 번호
	public String getS_type() {
		return s_type;
	}
	public void setS_type(String s_type) {
		this.s_type = s_type;
	}
	public String getS_text() {
		return s_text;
	}
	public void setS_text(String s_text) {
		this.s_text = s_text;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
}
