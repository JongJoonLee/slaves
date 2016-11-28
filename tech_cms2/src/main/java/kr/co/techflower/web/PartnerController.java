package kr.co.techflower.web;



import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.techflower.service.PartnerService;
import ngel.core.web.FrameworkController;

@Controller
public class PartnerController extends FrameworkController {
	
	private static final Logger logger = LoggerFactory.getLogger(PartnerController.class);
	
	@Autowired
	PartnerService partnerService;
	@RequestMapping(value="/cms/partner.do")
	public String doPartnerList(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
	Map<String, Object> list = new HashMap<String, Object>();
	
	partnerService.doPartnerList(list, model);
	
	
	return "tiles.partner";
	
	
		
		
			
	};
	
	
	
	
	

}
