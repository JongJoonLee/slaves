package kr.co.techflower.service;

import java.util.List;
import java.util.Map;

public interface BannerService {

	public List<Map<String, Object>> doSearch(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> doOneDataSearch(Map<String, Object> map) throws Exception;
	public int doDelete(Map<String, Object> map) throws Exception;
	public Map<String, Object> doUpdate(Map<String, Object> map) throws Exception;
	public int doUpdateFile(Map<String, Object> map) throws Exception;
	public Map<String, Object> doInsert(Map<String, Object> map) throws Exception;
	public int doInsertFile(Map<String, Object> map) throws Exception;
	
}
