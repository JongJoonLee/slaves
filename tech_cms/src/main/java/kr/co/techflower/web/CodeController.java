package kr.co.techflower.web;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.techflower.service.CodeService;

@RequestMapping(value="/CMS/CODE")
@Controller
public class CodeController extends FrameworkController{

	private static final Logger logger = LoggerFactory.getLogger(CodeController.class);
	
	@Autowired
	CodeService codeService;
	
	@RequestMapping(value="/list.do")
	@ResponseBody
	public List<Map<String, Object>> selectBasicCode(@RequestBody Map<String, Object> reqMap, Model model) throws Exception{
		List<Map<String, Object>> resList = codeService.selectBasicCode(reqMap);
		return resList;		
	};

	@RequestMapping(value="/detailList.do")
	@ResponseBody
	public List<Map<String, Object>> selectDetailCode(HttpServletRequest req, HttpServletResponse res, Model model) throws Exception{
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("PARENTBOM", req.getParameter("BOM_TEXT") != null?req.getParameter("BOM_TEXT"):"/");
		List<Map<String, Object>> resList = codeService.selectBasicCode(reqMap);
		return resList;		
	};

	@RequestMapping(value="/save.do")
	@ResponseBody
	public Map<String, Object> saveBasicCode(@RequestBody Map<String, Object> reqMap, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
//		Map<String, Object> reqMap = new HashMap<String, Object>();
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		int resultCnt = 0;
		resultCnt = codeService.saveBasicCode(reqMap);
		if(resultCnt > 0){
			resMap.put("result", "true");
		}else{
			resMap.put("result", "false");
		}		
		return resMap;			
	};
	
}
