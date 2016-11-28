package kr.co.techflower.service;

import java.util.List;
import java.util.Map;

public interface MenuService {

	public List<Map<String, Object>> selectMenuList(Map<String, Object> map) throws Exception;
	public int saveMenuList(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectComboList(Map<String, Object> map) throws Exception;
	
}
