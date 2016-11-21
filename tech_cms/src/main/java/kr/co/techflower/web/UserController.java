package kr.co.techflower.web;

import java.io.File;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.techflower.service.ExcelDownloadService;
import kr.co.techflower.service.UserService;

@Controller
public class UserController extends FrameworkController{

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	UserService userService;
	
	@Autowired
	ExcelDownloadService excelDownloadService;
	
	@RequestMapping(value="/doExcelDownloadUser.do")
	@ResponseBody
	public Map<String, Object> doExcelDownloadUser(HttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.info("/doExcelDownloadUser.do");
		
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
		resMap = excelDownloadService.createExcelFileUser(reqMap);
		resMap.put("result", "true");
		resMap.put("resultValue", "완료");
		return resMap;
	};
	
	@RequestMapping(value="/doFileDownLoadUser.do")
	public ModelAndView doFileDownLoadUser(HttpServletRequest req, HttpServletResponse res) throws Exception{
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
		};
		
		String fullPath = "C:/MEIC/WEBSITE/UploadFiles/board/";
		File fileFolder = new File(fullPath);
		if(!fileFolder.exists()) {
			fileFolder.mkdirs();
		}
		
		File file = new File(fullPath, (String)reqMap.get("svg_filename"));			
		
		reqMap.put("file", file);
		reqMap.put("filename", reqMap.get("svg_filename"));
		reqMap.put("temp", false);
		return new ModelAndView("fileDownloadView", "fileMap", reqMap);
	};
	
	@RequestMapping(value="/userComboBoxList.do")
	@ResponseBody
	public List<Map<String, Object>> doComboList(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		List<Map<String, Object>> resList = userService.doComboList(reqMap);
		
		return resList;		
	};
	
	@RequestMapping(value="/userSearch.do")
	@ResponseBody
	public Map<String, Object> doSearch(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("pageNo", req.getParameter("pageNo"));
		reqMap.put("userDiv", req.getParameter("userDiv"));
		reqMap.put("userId", req.getParameter("userId"));
		if(req.getParameter("receive") != null && !"".equals(req.getParameter("receive"))){
			reqMap.put("receive", req.getParameter("receive"));
		}
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("rows", userService.doSearch(reqMap));
		return resMap;
	};
	
	@RequestMapping(value="/userSave.do")
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
		resultCnt = userService.doSave(reqMap);
		if(resultCnt > 0){
			resMap.put("result", "true");
		}else{
			resMap.put("result", "false");
		}		
		return resMap;		
	};
	
}
