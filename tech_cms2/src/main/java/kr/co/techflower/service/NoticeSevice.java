package kr.co.techflower.service;

import java.io.UnsupportedEncodingException;


import java.util.Map;

import org.springframework.ui.Model;

public interface NoticeSevice {

	

	

	

	void getNoticeList(Map<String, Object> map, Model model, int cnt) throws Exception;

	int getTotgl1();

	void getNoticeSearch(Map<String, Object> map, Model model, int cnt, String stype, String stext)
			throws UnsupportedEncodingException;

	

	int getSearchTotgl1(String stype, String stext);


	
}