package com.groupware.www.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CalendarController {
	
	@RequestMapping(value="calendar.do", method=RequestMethod.GET)
	public String home() {
		return "calendar";
	}
	
	
	@RequestMapping(value="carend.do", method=RequestMethod.GET)
	public String carend() {
		return "carend";
	}
}
