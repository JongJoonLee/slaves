package kr.co.techflower.service;

import java.util.Map;

import org.springframework.ui.Model;

public interface HomeService {

	public void getPageLoad(Map<String, Object> map, Model model) throws Exception;
	
}
