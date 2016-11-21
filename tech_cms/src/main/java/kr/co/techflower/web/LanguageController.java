package kr.co.techflower.web;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ngel.core.web.FrameworkController;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.techflower.service.LanguageService;

@Controller
public class LanguageController extends FrameworkController{

	@Autowired
	LanguageService languageService; 
	
	private static final Logger logger = LoggerFactory.getLogger(LanguageController.class);	
	
	@RequestMapping(value="/doLocaleComboList.do")
	@ResponseBody
	public List<Map<String, Object>> getLocaleComboList(HttpServletRequest req, HttpServletResponse res) throws Exception{
		Map<String, Object> reqMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = languageService.doComboList(reqMap);
		return list;
	};
	
	@RequestMapping(value="/doLanguageSearch.do")
	@ResponseBody
	public List<Map<String, Object>> doSearch(HttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.debug("/doLanguageSearch.do");
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		
		@SuppressWarnings("unchecked")
		Enumeration<String> parameterNames = req.getParameterNames();
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			String[] paramValues = req.getParameterValues(paramName);
			for (int i = 0; i < paramValues.length; i++) {
				String paramValue = paramValues[i];
				reqMap.put(paramName, paramValue);				
			}
		}
		List<Map<String, Object>> resultList = languageService.doSearch(reqMap);
		return resultList;
	};
	
	@RequestMapping(value="/doLanguageSave.do")
	@ResponseBody
	public Map<String, Object> doSave(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		Map<String, Object> resMap = new HashMap<String, Object>();
		int resultCnt = 0;
		
		@SuppressWarnings("unchecked")
		Enumeration<String> parameterNames = req.getParameterNames();
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			String[] paramValues = req.getParameterValues(paramName);
			for (int i = 0; i < paramValues.length; i++) {
				String paramValue = paramValues[i];
				reqMap.put(paramName, paramValue);				
			}
		}
		
		if("D".equals(reqMap.get("rowType"))){
			resultCnt += languageService.doDelete(reqMap);
		}else if("U".equals(reqMap.get("rowType"))){
			resultCnt += languageService.doUpdate(reqMap);
		}else if("C".equals(reqMap.get("rowType"))){
			resultCnt += languageService.doInsert(reqMap);
		} 
		
		if(resultCnt > 0){
			resMap.put("result", "true");
			resMap.put("resultVal", "완료");
		}else{
			resMap.put("result", "false");
			resMap.put("resultVal", "실패");
		}
		return resMap;
	};
}
