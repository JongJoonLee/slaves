package kr.co.techflower.service;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

public interface SurveyService {

	public List<Map<String, Object>> doSearch(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> doSearchDetail(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> doSearchDetailExcample(Map<String, Object> map) throws Exception;
	public int doSave(Map<String, Object> map) throws Exception;
	public int doSaveDetail(Map<String, Object> map) throws Exception;
	public int doDeleteJustOne(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> goSurveyPopup(Map<String, Object> map, Model model) throws Exception;
	public List<Map<String, Object>> popupBefInsert(Map<String, Object> map, Model model) throws Exception;
	public List<Map<String, Object>> popupAftInsert(Map<String, Object> map, Model model) throws Exception;
	public List<Map<String, Object>> popupInsert(Map<String, Object> map, Model model) throws Exception;
	public List<Map<String, Object>> popupUpdate(Map<String, Object> map, Model model) throws Exception;
	
	public int doInsertBefDetail(Map<String, Object> map) throws Exception;
	public int doInsertAftDetail(Map<String, Object> map) throws Exception;
	public int doInsertLastDetail(Map<String, Object> map) throws Exception;
	public int doUpdateDetail(Map<String, Object> map) throws Exception;
	public int doDeleteAllDetail(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> doExcelDown(List<Map<String, Object>> list) throws Exception;
	
}
