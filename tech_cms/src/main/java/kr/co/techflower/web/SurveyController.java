package kr.co.techflower.web;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.techflower.service.SurveyService;
import ngel.core.web.FrameworkController;


@Controller
public class SurveyController extends FrameworkController{

	@Autowired
	SurveyService surveyService;
	
	private static final Logger logger = LoggerFactory.getLogger(SurveyController.class);
	
	@RequestMapping(value="/doSurveyList.do")
	@ResponseBody
	public List<Map<String, Object>> doList(HttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.debug("/doSurveyList.do");
		
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
		return surveyService.doSearch(reqMap);
	};
	
	@RequestMapping(value="/doSurveySave.do")
	@ResponseBody
	public Map<String, Object> doSave(HttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.debug("/doSurveySave.do");
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
		resultCnt = surveyService.doSave(reqMap);
		if(resultCnt > 0){
			resMap.put("result", "true");
			resMap.put("resultValue", "완료");
		}else{
			resMap.put("result", "false");
			resMap.put("resultValue", "실패");
		}
		return resMap;
	};
	
	@RequestMapping(value="/doSurveyDetailList.do"/*, method = RequestMethod.GET*/)
	public String goBoardPage(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
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
		
		model.addAttribute("SURVEY_POSITION", reqMap.get("SURVEY_POSITION"));
		model.addAttribute("SURVEY_ID", reqMap.get("SURVEY_ID"));
		if(!"".equals(reqMap.get("SURVEY_DID"))){
			model.addAttribute("SURVEY_DID", reqMap.get("SURVEY_DID"));
		}else{
			model.addAttribute("SURVEY_DID", "");
		}
		
		if("NOW_UDT".equals(reqMap.get("SURVEY_POSITION"))){
			//현재 페이지 수정
			surveyService.popupUpdate(reqMap, model);
		}else if("BEF_INS".equals(reqMap.get("SURVEY_POSITION"))){
			//이전 추가
			surveyService.popupBefInsert(reqMap, model);
		}else if("AFT_INS".equals(reqMap.get("SURVEY_POSITION"))){
			//다음 추가
			surveyService.popupAftInsert(reqMap, model);
		}else if("END_INS".equals(reqMap.get("SURVEY_POSITION"))){
			//마지막 추가
			surveyService.popupInsert(reqMap, model);
		}else{
			//그외
		}
		
		return "cms/surveyPopup/surveyPopup";
	}
	
	@RequestMapping(value="/doDeleteJustOne.do")
	@ResponseBody
	public Map<String, Object> doDeleteJustOne (Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
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
		
		int result = surveyService.doDeleteJustOne(reqMap);
		if(result > 0){
			resMap.put("result", "success");
		}else{
			resMap.put("result", "fail");
		}
		return resMap;
	};
	
	/**
	 * 설문지 상세 설정 이전 추가 저장
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/doInsertBefDetail.do")
	@ResponseBody
	public Map<String, Object> doInsertBefDetail (Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
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
		int result = surveyService.doInsertBefDetail(reqMap);
		if(result > 0){
			resMap.put("result", "success");
		}else{
			resMap.put("result", "fail");
		}
		return resMap;
	};
	
	/**
	 * 설문지 상세 설정 다음 추가 저장
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/doInsertAftDetail.do")
	@ResponseBody
	public Map<String, Object> doInsertAftDetail (Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{

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
		int result = surveyService.doInsertAftDetail(reqMap);
		if(result > 0){
			resMap.put("result", "success");
		}else{
			resMap.put("result", "fail");
		}
		return resMap;
	};
	
	/**
	 * 설문지 상세 설정 항목 추가 저장
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/doInsertLastDetail.do")
	@ResponseBody
	public Map<String, Object> doInsertLastDetail (Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{

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
		int result = surveyService.doInsertLastDetail(reqMap);
		if(result > 0){
			resMap.put("result", "success");
		}else{
			resMap.put("result", "fail");
		}
		return resMap;
	};
	
	/**
	 * 설문지 상세 설정 수정 저장
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/doUpdateDetail.do")
	@ResponseBody
	public Map<String, Object> doUpdateDetail (Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{

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
		
		int result = surveyService.doUpdateDetail(reqMap);
		if(result > 0){
			resMap.put("result", "success");
		}else{
			resMap.put("result", "fail");
		}
		return resMap;
	};
	
	/**
	 * 설문지 상세 설정 수정 저장
	 * @param model
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/doDeleteAllDetail.do")
	@ResponseBody
	public Map<String, Object> doDeleteAllDetail (Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{

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
		
		int result = surveyService.doDeleteAllDetail(reqMap);
		if(result > 0){
			resMap.put("result", "success");
		}else{
			resMap.put("result", "fail");
		}
		return resMap;
	};
	
	/**
	 * 설문 결과 데이터 엑셀 다운로드
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/doSurveyExcelDownload.do")
	@ResponseBody
	public Map<String, Object> doExcelDownData(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		List<Map<String, Object>> reqList = new ArrayList<Map<String, Object>>();
		Map<String, Object> reqMap = new HashMap<String, Object>();
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		@SuppressWarnings("unchecked")
		Enumeration<String> parameterNames = req.getParameterNames();
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			if("param[]".equals(paramName)){
				String[] paramValues = req.getParameterValues(paramName);
				int temp = paramValues.length;
				for(int j=0; j<temp; j++){
					reqMap = new HashMap<String, Object>();
					reqMap.put("SURVEY_ID", paramValues[j]);
					reqList.add(reqMap);
				}
				break;
			}
		}
		if(!reqList.isEmpty() && reqList.size() > 0){
			Map<String, Object> result = surveyService.doExcelDown(reqList);
			return result;
		}
		
		return resMap;
	};
	
	@RequestMapping(value="/surveyExcelDown")
	public ModelAndView fileDown(@RequestParam Map<String, Object> map) throws Exception{
		return new ModelAndView("fileDownloadView", "fileMap", map);
	}
	
	/**
	 * String JSON 데이터를 List<Map<String, Object>> 형태로 casting
	 * @param json
	 * @return
	 */
	public List<Map<String, Object>> getJSON(String json){
		JSONArray jsonObj = null;
		Map<String, Object> resMap = null;
		List<Map<String, Object>> resList = new ArrayList<Map<String,Object>>();
		
        try {
        	jsonObj = new JSONArray(json);
        	
        	for(int i=0; i<jsonObj.length(); i++){
        		jsonObj.get(i);
				JSONObject jsonObj2 = new JSONObject(jsonObj.get(i).toString());
				
				@SuppressWarnings("rawtypes")
				Iterator itr = jsonObj2.keys();
				resMap = new HashMap<String, Object>();
				while(itr.hasNext()){
					String key = (String) itr.next();
					Object value = jsonObj2.get(key);
					resMap.put(key, value);
				}
				resList.add(resMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
        System.out.println(resList);
		return resList;
	}
	
}
