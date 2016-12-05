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
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	
	@RequestMapping(value="/cms/partnerUpdate.do", method = RequestMethod.POST)
	public String doPartnerUpdate(Model model, HttpServletRequest req, HttpServletResponse res,
			int partner_no, String partner_url, String partner_name) throws Exception{
		
	Map<String, Object> list = new HashMap<String, Object>();
	
	list.put("partner_no", partner_no);
	list.put("partner_url", partner_url);
	list.put("partner_name",partner_name);
	//이미지 차후 추가 
	
	partnerService.updatePartner(list, model);
	
	return "redirect:/cms/partner.do";
	};
	
	
	@RequestMapping(value="/cms/partnerPost.do", method = RequestMethod.POST)
	public String doPartnerInsert(Model model, HttpServletRequest req, HttpServletResponse res,
			String partner_url, String partner_name) throws Exception{
		
	Map<String, Object> list = new HashMap<String, Object>();
	
	
	list.put("partner_url", partner_url);
	list.put("partner_name",partner_name);
	//이미지 차후 추가 
	
	partnerService.insertPartner(list, model);
	
	return "redirect:/cms/partner.do";
	};
	
	
	
	@RequestMapping(value="/cms/partnerDelete.do", method = RequestMethod.POST)
	public String doPartnerDelete(Model model, HttpServletRequest req, HttpServletResponse res,
			int partner_no) throws Exception{
		
	System.out.println("삭제게시물넘버다 : " +partner_no);
	//이미지 차후 추가 
	Map<String, Object> list = new HashMap<String, Object>();
	list.put("partner_no", partner_no);
	partnerService.deletePartner(list, model);
	
	return "redirect:/cms/partner.do";
	};
	
	
	
	
	
	
	
	
	

}
