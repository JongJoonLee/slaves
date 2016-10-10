package com.groupware.www.Controller;

import java.util.List;
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
import org.springframework.web.servlet.ModelAndView;


import com.groupware.www.Dao.MemberDao;
import com.groupware.www.Dao.TimelineDao;
import com.groupware.www.Vo.MasterVO;
import com.groupware.www.Vo.MemberVO;
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


	
	private String prevURL = null;
		
	

	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public ModelAndView login(Locale locale, Model model, HttpSession session,
			@RequestParam(value = "prev", required = false, defaultValue = "index.do") String prev) {
		//prevURL=prev;
		session.setAttribute("prev",prev);
		
		//System.out.println(prevURL);
		MemberVO member = new MemberVO();

		// login1.jsp
		return new ModelAndView("login", "command", member);
	}

	@RequestMapping(value = "/loginpost.do", method = RequestMethod.POST)
	public String loginback(@ModelAttribute MemberVO member, HttpSession session, HttpServletRequest request) {

		
		//String beforeURL = request.getHeader("referer");

		//System.out.println("a  : " + beforeURL);
		//prevURL=(String) session.getAttribute("prev");
		try {
			MemberVO a = mDao.login(member);
			session.setAttribute("_id", a.getMem_id());
			session.setAttribute("_name", a.getMem_name());
			session.setAttribute("_mem_no", a.getMem_no());
			System.out.println(a.getMem_id());
			return "redirect:index.do";//index.do";
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
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
		/*prevURL=(String) session.getAttribute("prev");
		if(prevURL.equals(null)){
			prevURL="index.do";
		}*/
		//System.out.println(prevURL);
		session.invalidate();

		return "redirect:login.do";
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
