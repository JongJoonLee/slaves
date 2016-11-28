package kr.co.techflower.service;

import java.util.List;
import java.util.Map;

public interface PopupService {

	public List<Map<String, Object>> doSearchList(Map<String, Object> map) throws Exception;
	public int doSave(Map<String, Object> map) throws Exception;
	public int doContentsUpdate(Map<String, Object> map) throws Exception;
	
}
