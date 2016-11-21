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

import kr.co.techflower.service.NoticeSevice;

@Controller
public class NoticeController extends FrameworkController{
	
	@Autowired
	NoticeSevice noticeService;
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@RequestMapping(value="/doNoticeList.do")
	@ResponseBody
	public List<Map<String, Object>> doList(HttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.debug("/doNoticeList.do");
		
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
		return noticeService.doSearch(reqMap);
	};
	
	@RequestMapping(value="/doNoticeSave.do")
	@ResponseBody
	public Map<String, Object> doSave(HttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.debug("/doNoticeSave.do");
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
		resultCnt = noticeService.doSave(reqMap);
		if(resultCnt > 0){
			resMap.put("result", "true");
			resMap.put("resultValue", "완료");
		}else{
			resMap.put("result", "false");
			resMap.put("resultValue", "실패");
		}
		return resMap;
	};
	
	@RequestMapping(value="/doBoardCdCnt.do")
	@ResponseBody
	public Map<String, Object> doBoardCdCnt(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		logger.debug("/doBoardCdCnt.do");
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
		resMap = noticeService.doBoardCdCnt(reqMap);
		if(Integer.parseInt(String.valueOf(resMap.get("CNT"))) > 0){
			resMap.put("result", "false");
		}else{
			resMap.put("result", "true");
		}
		return resMap;
	};
	
}
