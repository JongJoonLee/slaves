package kr.co.techflower.service;

import java.util.List;
import java.util.Map;

public interface BoardService {

	public List<Map<String, Object>> doComboList(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> doSearchList(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> doSearchDetailList(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> doSearchDetailFileList(Map<String, Object> map) throws Exception;
	public int doSaveList(Map<String, Object> map) throws Exception;
	public int doUpdateList(Map<String, Object> map) throws Exception;
	public int doUpdateFile(Map<String, Object> map) throws Exception;
	
}
