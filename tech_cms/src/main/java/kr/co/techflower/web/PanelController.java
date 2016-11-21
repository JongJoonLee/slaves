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

import kr.co.techflower.service.PanelService;

@Controller
public class PanelController extends FrameworkController{

	private static final Logger logger = LoggerFactory.getLogger(PanelController.class);
	
	@Autowired
	PanelService panelService;
	
	@RequestMapping(value="/panelComboBoxList.do")
	@ResponseBody
	public List<Map<String, Object>> doComboList(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		List<Map<String, Object>> resList = panelService.doComboList(reqMap);
		
		return resList;		
	};
	
	@RequestMapping(value="/panelSearch.do")
	@ResponseBody
	public Map<String, Object> doSearch(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("pageNo", req.getParameter("pageNo"));
		reqMap.put("panelDiv", 30/*req.getParameter("panelDiv")*/);
		reqMap.put("panelId", req.getParameter("panelId"));
		/*if(req.getParameter("receive") != null && !"".equals(req.getParameter("receive"))){
			reqMap.put("receive", req.getParameter("receive"));
		}*/
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("rows", panelService.doSearch(reqMap));
		return resMap;
	};
	
	@RequestMapping(value="/panelSearchIdx.do")
	@ResponseBody
	public Map<String, Object> doSearchIdx(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("pageNo", req.getParameter("pageNo"));
		reqMap.put("panelId", req.getParameter("panelId"));
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("rows", panelService.doSearchIdx(reqMap));
		return resMap;
	};
	
	@RequestMapping(value="/panelSearchIdxPanel.do")
	@ResponseBody
	public Map<String, Object> doSearchIdxPanel(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("pageNo", req.getParameter("pageNo"));
		reqMap.put("panelId", req.getParameter("panelId"));
		reqMap.put("idxGrpCd", req.getParameter("idxGrpCd"));
		reqMap.put("idxDD", req.getParameter("idxDD"));		
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("rows", panelService.doSearchIdxPanel(reqMap));
		return resMap;
	};
	
	@RequestMapping(value="/panelSearchIdxCenter.do")
	@ResponseBody
	public Map<String, Object> doSearchIdxCenter(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("pageNo", req.getParameter("pageNo"));
		reqMap.put("panelId", req.getParameter("panelId"));
		reqMap.put("idxGrpCd", req.getParameter("idxGrpCd"));	
		reqMap.put("idxDD", req.getParameter("idxDD"));		
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("rows", panelService.doSearchIdxCenter(reqMap));
		return resMap;
	};
	
	@RequestMapping(value="/panelSave.do")
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
		if(null == reqMap.get("USER_ID") || "".equals(reqMap.get("USER_ID"))){
			resMap.put("result", "false");
			resMap.put("resultValue", "id를 입력해주세요");
			return resMap;
		}
		
		int resultCnt = 0;
		resultCnt = panelService.doSave(reqMap);
		if(resultCnt > 0){
			resMap.put("result", "true");
			resMap.put("resultValue", "완료");
		}else{
			resMap.put("result", "false");
			resMap.put("resultValue", "중복되는 ID가 존재합니다.");
		}		
		return resMap;		
	};
	
	
	
}
