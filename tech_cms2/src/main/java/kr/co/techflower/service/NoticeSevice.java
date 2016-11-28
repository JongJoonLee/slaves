package kr.co.techflower.service;

import java.io.UnsupportedEncodingException;

import java.util.Locale;
import java.util.Map;

import org.springframework.ui.Model;

public interface NoticeSevice {

	

	

	

	void getNoticeList(Map<String, Object> map, Model model, int cnt) throws Exception;

	int getTotgl1();

	int getNoticeSearch(Locale locale, Model model, int cnt, String s_type, String s_text)
			throws UnsupportedEncodingException;


	
}
