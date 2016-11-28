package kr.co.techflower.service;

import java.util.List;
import java.util.Map;

public interface CodeService {

	public List<Map<String, Object>> selectBasicCode(Map<String, Object> map) throws Exception;
	public int saveBasicCode(Map<String, Object> map) throws Exception;
	
}
