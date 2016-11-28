package kr.co.techflower.service;

import java.util.List;
import java.util.Map;

public interface UserService {

	public List<Map<String, Object>> doSearch(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> doComboList(Map<String, Object> map) throws Exception;
	public int doSave(Map<String, Object> map) throws Exception;
	
}
