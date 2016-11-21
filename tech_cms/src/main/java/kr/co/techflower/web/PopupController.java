package kr.co.techflower.web;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.techflower.service.PopupService;
import ngel.core.web.FrameworkController;

@Controller
public class PopupController extends FrameworkController{

	@Autowired
	PopupService popupService;
	
	private static final Logger logger = LoggerFactory.getLogger(PopupController.class);
	
	@RequestMapping(value="/doPopupSearch.do")
	@ResponseBody
	public List<Map<String, Object>> doSearch(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		logger.info("/doPopupSearch.do");
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
		return popupService.doSearchList(reqMap);		
	};
	
	@RequestMapping(value="/doPopupSave.do")
	@ResponseBody
	public Map<String, Object> doSave(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		Map<String, Object> resMap = new HashMap<String, Object>();
		
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
		int resultCnt = 0;
		resultCnt = popupService.doSave(reqMap);
		if(resultCnt > 0){
			resMap.put("result", "true");
			resMap.put("resultValue", "완료");
		}else{
			resMap.put("result", "false");
			resMap.put("resultValue", "실패");
		}
		return resMap;		
	};
	
	@RequestMapping(value="/doPopupContentsUpdate.do")
	@ResponseBody
	public Map<String, Object> doContentsUpdate(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		Map<String, Object> resMap = new HashMap<String, Object>();
		
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
		System.out.println("???????????????????????????????");
		System.out.println(reqMap);
		int resultCnt = 0;
		resultCnt = popupService.doContentsUpdate(reqMap);
		if(resultCnt > 0){
			resMap.put("result", "true");
			resMap.put("resultValue", "완료");
		}else{
			resMap.put("result", "false");
			resMap.put("resultValue", "실패");
		}
		return resMap;		
	};
	
}
