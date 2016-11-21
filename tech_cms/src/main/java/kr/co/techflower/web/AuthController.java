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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.techflower.service.AuthService;

@Controller
public class AuthController extends FrameworkController{
	
	private static final Logger logger = LoggerFactory.getLogger(AuthController.class);
	
	@Autowired
	AuthService authService;
	
	@RequestMapping(value="/doAuthComboList.do")
	@ResponseBody
	public List<Map<String, Object>> getComboList(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		List<Map<String, Object>> returnList = authService.doComboList(reqMap);
		return returnList;
	}
	
	@RequestMapping(value="/doMenuList.do")
	@ResponseBody
	public List<Map<String, Object>> getMenuList(HttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.info("doMenuList.do");
		Map<String, Object> reqMap = new HashMap<String, Object>();
		
		if(null != req.getParameter("menuNm") && !"".equals(req.getParameter("menuNm"))){
			reqMap.put("menuNm", req.getParameter("menuNm"));
		}
		
		List<Map<String, Object>> returnList = authService.doMenuList(reqMap);
		return returnList;
	};
	
	@RequestMapping(value="/doMenuInAuthList.do")
	@ResponseBody
	public List<Map<String, Object>> getMenuInAuthList(HttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.info("doMenuInAuthList.do");
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("menuCd", req.getParameter("ID"));
		
		List<Map<String, Object>> returnList = authService.doMenuInAuthList(reqMap);
		return returnList;
	};
	
	@RequestMapping(value="/doAuthSave.do")
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
		resultCnt = authService.doSave(reqMap);
		if(resultCnt > 0){
			resMap.put("result", "true");
			resMap.put("resultVal", "성공");
		}else{
			if(resultCnt == -1){
				resMap.put("result", "false");
				resMap.put("resultVal", "회원구분이 중복되는 데이터가 존재합니다.");
				resMap.put("resultCnt", "-1");
			}else{
				resMap.put("result", "false");
				resMap.put("resultVal", "실패");
			}
		}		
		return resMap;		
	};

}
