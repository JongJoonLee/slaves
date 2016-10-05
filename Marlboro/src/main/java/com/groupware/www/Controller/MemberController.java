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
import org.springframework.web.bind.annotation.RequestParam;
import com.groupware.www.Dao.MemberDao;
import com.groupware.www.Vo.MemberVO;


/**
 * Handles requests for the application home page.
 */
@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Resource(name = "mDao")
	private MemberDao mDao;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "member.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
	
		
		
		
		
		return "member";
	}
	
	@RequestMapping(value = "memberlist.do", method = RequestMethod.GET)
	public String vew1(Locale locale, Model model,HttpSession session,
			@RequestParam(value = "no") int no) {
		logger.info("memberlist.do", locale);
		
		
		
		List<MemberVO> mvo = mDao.memberlist(no);
		
		//System.out.println(mvo);

		// System.out.println(bcp.getCnt());

		model.addAttribute("mlist", mvo);
		
		System.out.println(no);
		
		
		return "memberlist";
	}
}
