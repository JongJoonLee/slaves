package com.example.controller;

import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.junit.runner.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.example.bean.Member;
import com.example.bean.TestVO;
import com.example.dao.BoardDao;
import com.example.dao.MongoDAO;



@Controller
	

public class mongoController {
	/*
	@Resource(name = "mDB")
	private MongoDAO mDB;*/
	
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/mongodbtest.do", method = RequestMethod.GET)
	public String mongohome() {
		
		return "mongodbtest";
		
	}
	


	
	
	@RequestMapping(value = "/mongodbtest.do", method = RequestMethod.POST)
	public String mongodbinsert(Locale locale, Model model){
		
		
		
		
		TestVO tvo = new TestVO();
		
		
		
		
		//mDB.insertTestVO();
				
		return "mongodbtest";
	}
	

		
		


		

	

}