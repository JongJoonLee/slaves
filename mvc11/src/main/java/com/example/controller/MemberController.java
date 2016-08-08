package com.example.controller;

import java.util.Locale;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
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
		
		
		
		
		
		return null;

		
		
	}

}