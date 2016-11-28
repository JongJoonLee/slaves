package kr.co.techflower.web;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;

import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.techflower.service.NoticeSevice;

import ngel.core.web.FrameworkController;

@Controller
public class NoticeController extends FrameworkController{
	
	@Autowired
	NoticeSevice noticeService;
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@RequestMapping(value="/cms/notice.do")
	public String doList(Locale locale, Model model, HttpSession session,
			@RequestParam(value = "page", required = false, defaultValue = "1") int cnt) throws Exception{
		
		
		//String mem = (String) session.getAttribute("_name");
		Map<String, Object> list = new HashMap<String, Object>();
	
		
		
		int totgle = noticeService.getTotgl1();
		
		

		int bopage = 10;

		int totpage = totgle / bopage + 1;
		

		// System.out.println(cnt);

		// 1 0
		// 2 10
		// 3 20

		model.addAttribute("cont", totpage);
		noticeService.getNoticeList(list, model, cnt);
		
		
		return "tiles.notice";
	};
	
	@RequestMapping(value = "/cms/notice_boardsearch.do", method = RequestMethod.GET)
	public String notice_customsearch(Locale locale, Model model,
			@RequestParam(value = "page", required = false, defaultValue = "1") int cnt,
			@RequestParam(value = "s_type") String s_type, @RequestParam(value = "s_text") String s_text)
			throws UnsupportedEncodingException {
		
		int tot=0;
		
		tot= noticeService.getNoticeSearch(locale, model, cnt, s_type, s_text);
		noticeService.getNoticeSearch(locale, model, cnt, s_type, s_text);
		int bopage = 10;
		

		int totpage = tot / bopage + 1;
		model.addAttribute("cont", totpage);
		//System.out.println("컨트롤러 s_type : "+s_type);
		System.out.println("cnt : "+cnt);
		System.out.println("s_type : "+s_type);
		System.out.println("s_text : "+s_text);
		System.out.println("totpage : " + totpage);
		
		
		

		return "tiles.notice";
	}
	
	
}
