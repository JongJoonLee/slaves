package kr.co.techflower.service;


import java.io.UnsupportedEncodingException;
import java.util.Map;

import org.springframework.ui.Model;

public interface PromoteService {

	void getPromoteList(Map<String, Object> map, Model model, int cnt) throws Exception;

	int getPromoteCount();

	

	void getPromoteContents(Model model, int tb_promote_no) throws Exception;

	void updatePromoteHit(int tb_promote_no, Model model);

	void inputPromote(Map<String, Object> map, Model model);

	void getPromoteSearch(Map<String, Object> map, Model model, int cnt, String stype, String stext)
			throws UnsupportedEncodingException;

	int getSearchTotgl1(String stype, String stext);

	void updatePromote(Map<String, Object> map, int tb_promote_no, Model model);

}
