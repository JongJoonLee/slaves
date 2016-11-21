package kr.co.techflower.service;

import java.util.List;
import java.util.Map;

public interface WebeditorService {

	public List<Map<String, Object>> doCombo(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> doSearch(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> doDetailSearch(Map<String, Object> map) throws Exception;
	public int doSave(Map<String, Object> map) throws Exception;
	public Map<String, Object> doContentSave(Map<String, Object> map) throws Exception;
	
}
