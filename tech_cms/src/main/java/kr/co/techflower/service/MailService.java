package kr.co.techflower.service;

import java.util.List;
import java.util.Map;

public interface MailService {

	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectUserList(Map<String, Object> map) throws Exception;
	public int saveUserList(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> selectComboList(Map<String, Object> map) throws Exception;
	
}
