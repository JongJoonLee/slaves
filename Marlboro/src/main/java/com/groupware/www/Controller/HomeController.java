package com.groupware.www.Controller;

import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.groupware.www.Dao.MemberDao;
import com.groupware.www.Dao.TimelineDao;
import com.groupware.www.Vo.MasterVO;
import com.groupware.www.Vo.TimelineVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Resource(name = "mDao")
	private MemberDao mDao;
	@Resource(name = "tDao")
	private TimelineDao tDao;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	/*
	 * @RequestMapping(value = "index.do", method = RequestMethod.GET) public
	 * String home(Locale locale, Model model,HttpSession session) {
	 * 
	 * 
	 * 
	 * return "index"; }
	 */

	@RequestMapping(value = "login.do", method = RequestMethod.GET)
	public String login(Locale locale, Model model) {
		logger.info("로그인 페이지 입니다.", locale);
		logger.debug("인터셉터 테스트");
		return "login";
	}

	@RequestMapping(value = "login_En.do", method = RequestMethod.GET)
	public String loginEn(Locale locale, Model model) {
		logger.info("로그인 페이지 영어 버전 입니다.", locale);
		logger.debug("인터셉터 테스트");
		return "login_en";
	}

	@RequestMapping(value = "index.do")
	public ModelAndView index(Locale locale, Model model) {
		logger.info("인덱스 페이지 입니다", locale);
		logger.debug("인터셉터 테스트");

		List<MasterVO> tvo = tDao.timelinelistfinal();

		model.addAttribute("timeline", tvo);

		TimelineVO tvo2 = new TimelineVO();

		return new ModelAndView("index", "command", tvo2);

	}

	/*
	 * @RequestMapping(value = "timelinetest.do", method = RequestMethod.GET)
	 * public ModelAndView home2(Locale locale, Model model,HttpSession session)
	 * {
	 * 
	 * 
	 * 
	 * 
	 * 
	 * }
	 */

	@RequestMapping(value = "timelinepost.do", method = RequestMethod.POST)
	public String tline(Locale locale, Model model, HttpSession session, TimelineVO tvo2) {
		
		
		System.out.println(tvo2.getTime_contents());
		tDao.insertTimeline(tvo2);

		return "redirect:index.do";
	}

}
