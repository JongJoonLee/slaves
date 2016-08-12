package com.example.controller;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.bean.Member;
import com.example.dao.MemberDao;

@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Resource(name = "mDao")
	private MemberDao mDao;

	@RequestMapping(value = "/joinpage.do", method = RequestMethod.GET)
	public ModelAndView joinpage(Locale locale, Model model) {

		Member member = new Member();

		return new ModelAndView("joinpage", "command", member);
	}

	@RequestMapping(value = "/joinpagepost.do", method = RequestMethod.POST)
	public String joinpagepost(@ModelAttribute Member member, HttpSession session, HttpServletRequest request) {
		
		mDao.join(member);
		
		
		return "redirect:index.do";

		
		
	}
	
	
	
	
	
	
	
	 @RequestMapping(value = "/chkMbId.do", method = RequestMethod.POST)
	 @ResponseBody
	 public Map<String, String> chkMbId(String mbId) throws Exception {
	  
	  Map<String, String> resultMap = new HashMap<String, String>();
	  
	  int resultCnt = mDao.chkMbId(mbId);
	  String result = "";
	  String resultMsg = "";
	  if ( resultCnt == 0 ){
	   result = "success";
	   resultMsg = ""
	   		+ "사용가능한 아이디입니다.";
	  } else {
	   result = "failure";
	   resultMsg = "이미 사용중인 아이디입니다.";
	  }
	  
	  resultMap.put("result", result);
	  resultMap.put("resultMsg", resultMsg);
	  
	  return resultMap;
	 } 
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	

}