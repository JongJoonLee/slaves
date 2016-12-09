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

	void inputNotice(Map<String, Object> bdwrite, Model model);

	

	

	//Map<String, Object> getBoardContents(int notice_board_no, Model model);

	void getBoardContents(int notice_board_no, Model model);

	

	void updateHit(int notice_board_no, Model model);

	void updateNotice(Map<String, Object> map, int notice_board_no, Model model);


	
}
