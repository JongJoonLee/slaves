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

import kr.co.techflower.service.MailService;

@RequestMapping(value="/CMS/MAIL")
@Controller
public class MailController extends FrameworkController{

	private static final Logger logger = LoggerFactory.getLogger(MailController.class);
	
	@Autowired
	MailService mailService;
	
	@RequestMapping(value="/list.do")
	@ResponseBody
	public List<Map<String, Object>> selectBoardList(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		List<Map<String, Object>> resList = mailService.selectBoardList(reqMap);
		
		return resList;		
	};

	@RequestMapping(value="/detailList.do")
	@ResponseBody
	public List<Map<String, Object>> selectUserList(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("BOARD_CD", req.getParameter("BOARD_CD"));
		List<Map<String, Object>> resList = mailService.selectUserList(reqMap);
		
		return resList;		
	};

	@RequestMapping(value="/save.do")
	@ResponseBody
	public Map<String, Object> saveUserList(@RequestBody Map<String, Object> reqMap, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
//		Map<String, Object> reqMap = new HashMap<String, Object>();
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		int resultCnt = 0;
		resultCnt = mailService.saveUserList(reqMap);
		if(resultCnt > 0){
			resMap.put("result", "true");
		}else{
			resMap.put("result", "false");
		}		
		return resMap;			
	};

	@RequestMapping(value="/comboList.do")
	@ResponseBody
	public List<Map<String, Object>> selectComboList(@RequestBody Map<String, Object> reqMap, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		return mailService.selectComboList(reqMap);
	};
}
