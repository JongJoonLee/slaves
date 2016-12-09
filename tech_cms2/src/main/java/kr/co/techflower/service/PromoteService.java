package kr.co.techflower.service;


import java.util.Map;

import org.springframework.ui.Model;

public interface PromoteService {

	void getPromoteList(Map<String, Object> map, Model model, int cnt) throws Exception;

	int getPromoteCount();

	

	void getPromoteContents(Model model, int tb_promote_no) throws Exception;

	void updatePromoteHit(int tb_promote_no, Model model);

	void inputPromote(Map<String, Object> map, Model model);

}
