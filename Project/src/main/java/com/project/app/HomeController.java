package com.project.app;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "index.do", method = RequestMethod.GET)
	public String index(Locale locale, Model model) {
		logger.info("Welcome! �α��� ������ �Դϴ�", locale);
		
		
		return "index";
	}
	
	@RequestMapping(value = "main.do")
	public String main(Locale locale, Model model) {
		
		
		
		
		/*if(id.equals("admin") && password.equals("admin")){*/
			logger.info("Welcome! ���� ������ �Դϴ�", locale);
			return "main";
/*		}else{
			logger.info("Welcome! �α��� ������ �Դϴ�", locale);
			return "index";
		}*/

		
			
		
		
		

	}
	
}
