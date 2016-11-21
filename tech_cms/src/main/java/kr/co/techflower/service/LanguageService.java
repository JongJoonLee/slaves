package kr.co.techflower.service;

import java.util.List;
import java.util.Map;

public interface LanguageService {

	public List<Map<String, Object>> doComboList(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> doSearch(Map<String, Object> map) throws Exception;
	public int doDelete(Map<String, Object> map) throws Exception;
	public int doUpdate(Map<String, Object> map) throws Exception;
	public int doInsert(Map<String, Object> map) throws Exception;
	
}
