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

import com.groupware.www.Dao.MemberDao;
import com.groupware.www.Dao.TimelineDao;
import com.groupware.www.Vo.MasterVO;

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
	@RequestMapping(value = "index.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model,HttpSession session) {
		
		List<MasterVO> tvo = tDao.timelinelistfinal();
		
		model.addAttribute("timeline", tvo);
		
		
		
		
		
		
		return "index";
	}
	
	
	
	
	@RequestMapping(value = "timelinetest.do", method = RequestMethod.GET)
	public String home2(Locale locale, Model model,HttpSession session) {
		
			
		
		
		
		return "timelinetest";
	}
	
	
	
}
