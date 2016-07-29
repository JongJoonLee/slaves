package com.example.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.bean.Member;
import com.example.dao.BoardDao;
import com.example.dao.MemberDao;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Resource(name = "bDao")
	private BoardDao bDao;

	@RequestMapping(value = "index.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		
		int cnt=3;
		session.setAttribute("prev", "index.do");

		model.addAttribute("btitle", bDao.notice_boardTitle(cnt));

		// String formattedDate = dateFormat.format(date);
		// model.addAttribute("serverTime", formattedDate);

		return "index";
	}

	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String home1(Locale locale, Model model) {

		return "join";
	}

	@RequestMapping(value = "/formJoin", method = RequestMethod.POST)
	public String home1add(Locale locale, Model model, @RequestParam("id") String id,
			@RequestParam("password") String password, @RequestParam("name") String name) {

		//System.out.println("id : " + id);
		//System.out.println("password : " + password);
		//System.out.println("name : " + password);

		return "join";
	}

	@RequestMapping(value = "/join1", method = RequestMethod.GET)
	public ModelAndView join1() {
		return new ModelAndView("join1", "command", new Member());
	}

	@Resource(name = "mDao")
	private MemberDao mDao;

	@RequestMapping(value = "/formJoin1", method = RequestMethod.POST)
	public String formjoin1(@ModelAttribute() Member mem) {
		//System.out.println("A:" + mem.getId());
		//System.out.println(mem.getPassword());
		//System.out.println(mem.getName());

		mDao.join(mem);

		return "join";
	}
}
