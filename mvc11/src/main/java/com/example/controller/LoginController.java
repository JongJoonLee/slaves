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
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private String prevURL = null;
	
	
	@Resource(name = "mDao")
	private MemberDao mDao;

	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public ModelAndView login(Locale locale, Model model, HttpSession session,
			@RequestParam(value = "prev", required = false, defaultValue = "index.do") String prev) {
		//prevURL=prev;
		session.setAttribute("prev",prev);
		
		//System.out.println(prevURL);
		Member member = new Member();

		// login1.jsp
		return new ModelAndView("login", "command", member);
	}

	@RequestMapping(value = "/loginpost.do", method = RequestMethod.POST)
	public String loginback(@ModelAttribute Member member, HttpSession session, HttpServletRequest request) {

		//String beforeURL = request.getHeader("referer");

		//System.out.println("a  : " + beforeURL);
		prevURL=(String) session.getAttribute("prev");
		try {
			Member a = mDao.login(member);
			session.setAttribute("_id", a.getId());
			session.setAttribute("_name", a.getName());
			return "redirect:"+prevURL;///index.do";
		} catch (Exception e) {
			e.getMessage();
			System.out.println("로긘실패");
			return "redirect:login.do";
		}

	}

	/*
	 * try{
	 * 
	 * Member a = mDao.login(member); session.setAttribute("_id", a.getId());
	 * session.setAttribute("_name", a.getName()); return "redirect:/index.do";
	 * 
	 * 
	 * }catch(Exception e){
	 * 
	 * e.getMessage(); System.out.println("로긘실패"); return "redirect:login.do";
	 * 
	 * }
	 */

	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		// System.out.println("로가웃성공");
		prevURL=(String) session.getAttribute("prev");
		System.out.println(prevURL);
		session.invalidate();

		return "redirect:"+prevURL;
	}

}
