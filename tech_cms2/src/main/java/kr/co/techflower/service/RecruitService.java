package kr.co.techflower.service;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import org.springframework.ui.Model;

public interface RecruitService {

	void getRecruitList(Map<String, Object> map, Model model, int cnt) throws Exception;

	void getRecruitSearch(Map<String, Object> map, Model model, int cnt, String stype, String stext)
			throws UnsupportedEncodingException;

	
	int getSearchTotgl1(String stype, String stext);

	int getTotgl1();

	void updateHit(int tb_recruit_no, Model model);

	void inputRecruit(Map<String, Object> bdwrite, Model model);

	void getRecruitContents(int tb_recruit_no, Model model);

	

	

	

}
