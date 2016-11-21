package kr.co.techflower.web;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ngel.core.web.FrameworkController;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.rte.fdl.security.userdetails.EgovUserDetails;
import kr.co.techflower.service.HomeService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController extends FrameworkController{
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	HomeService homeService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletRequest req) throws Exception {
		model.addAttribute("locale", locale);
		
		String referer = req.getHeader("Referer");
		req.getSession().setAttribute("prevPage", referer);
		
		if("anonymousUser".equals(SecurityContextHolder.getContext().getAuthentication().getPrincipal()) 
				|| null == SecurityContextHolder.getContext().getAuthentication().getPrincipal()
				|| "".equals(SecurityContextHolder.getContext().getAuthentication().getPrincipal())){
			return "body.login";
		}		
		return "tiles.menu";
		
	}
	
	@RequestMapping(value = "/goPage.do", method = RequestMethod.GET)
	public String goPage(Locale locale, Model model, HttpServletRequest req) throws Exception {
		
		Map<String, Object> reqMap = new HashMap<String, Object>();		
		reqMap.put("pageId", req.getParameter("menuId"));
		reqMap.put("surveyId", req.getParameter("surveyId"));
		homeService.getPageLoad(reqMap, model);
		
		return "tiles."+req.getParameter("menuId");
		//return "cms/"+req.getParameter("menuId");
	}
	
	@RequestMapping(value = "/Login")
	public String login(Locale locale, Model model, HttpServletRequest request) throws Exception {
		model.addAttribute("locale", locale);
		
		String referer = request.getHeader("Referer");
		request.getSession().setAttribute("prevPage", referer);
		
		return "body.login";
		//return "login/Login";
	};
	
	@RequestMapping(value = "/main")
	public String loginSuccess(HttpSession session) {
		EgovUserDetails userDetails = (EgovUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		session.setAttribute("userBeans", userDetails.getEgovUserVO());
		
		if(userDetails.isEnabled()){
			return "tiles.menu";
		}else{
			return "body.login";
		}
		//return "/template/template";
	};
	
}
