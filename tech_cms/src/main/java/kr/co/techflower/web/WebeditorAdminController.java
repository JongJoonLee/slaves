package kr.co.techflower.web;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ngel.core.web.FrameworkController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.techflower.service.WebeditorService;

@Controller
public class WebeditorAdminController extends FrameworkController{

	@Autowired
	WebeditorService webeditorService;
	
	@RequestMapping(value="/doWebeditorComboList.do")
	@ResponseBody
	public List<Map<String, Object>> doComboList(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = convertMap(req);
		List<Map<String, Object>> resList = webeditorService.doCombo(reqMap);		
		return resList;
	}
	
	@RequestMapping(value="/doWebeditorSearchList.do")
	@ResponseBody
	public List<Map<String, Object>> doSearchList(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = convertMap(req);		
		List<Map<String, Object>> resList = webeditorService.doSearch(reqMap);		
		return resList;
	}
	
	@RequestMapping(value="/doWebeditorSearchDetailList.do")
	@ResponseBody
	public List<Map<String, Object>> doSearchDetailList(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = convertMap(req);		
		List<Map<String, Object>> resList = webeditorService.doDetailSearch(reqMap);		
		return resList;
	}
	
	@RequestMapping(value="/doWebeditorSaveList.do")
	@ResponseBody
	public Map<String, Object> doSaveList(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = convertMap(req);
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		int resultCnt = 0;
		resultCnt = webeditorService.doSave(reqMap);
		if(resultCnt > 0){
			resMap.put("result", "true");
		}else{
			resMap.put("result", "false");
		}		
		return resMap;
	};
	
	@RequestMapping(value="/doContentSave.do")
	@ResponseBody
	public Map<String, Object> doContentSave(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = convertMap(req);
		Map<String, Object> resMap = webeditorService.doContentSave(reqMap);	
		return resMap;
		
	};
	
	@RequestMapping(value="/doWebeditorPopup.do")
	public String doWebeditorPopup(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		
		@SuppressWarnings("unchecked")
		Enumeration<String> parameterNames = req.getParameterNames();
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			String[] paramValues = req.getParameterValues(paramName);
			for (int i = 0; i < paramValues.length; i++) {
				String paramValue = paramValues[i];
				model.addAttribute(paramName, paramValue);
				reqMap.put(paramName, paramValue);
			}
		}
		
		if(null != reqMap.get("DESIGN_PAGE_ID") && null != reqMap.get("DESIGN_LOCALE")){
			List<Map<String, Object>> returnList = webeditorService.doDetailSearch(reqMap);
			if(!returnList.isEmpty() && returnList.size() > 0){
				model.addAttribute("DESIGN_HTML", returnList.get(0).get("DESIGN_HTML"));
				model.addAttribute("DESIGN_PAGE_NM", returnList.get(0).get("DESIGN_PAGE_NM"));
				model.addAttribute("DESIGN_LOCALE", returnList.get(0).get("DESIGN_LOCALE"));
			}
		}
		
		return "cms/niceditorPopup/webEditorPopup";
	}
	
	/**
	 * 
	 * @param req
	 * @return
	 */
	public Map<String, Object> convertMap(HttpServletRequest req){
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
		return reqMap;
	}
	
}
