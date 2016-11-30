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
		model.addAttribute("cont", totpage);
		noticeService.getNoticeList(list, model, cnt);
		
		
		return "tiles.notice";
	};
	
	@RequestMapping(value = "/cms/notice_boardsearch.do", method = RequestMethod.GET)
	public String notice_customsearch(Locale locale, Model model, HttpSession session,
			@RequestParam(value = "page", required = false, defaultValue = "1") int cnt,
			@RequestParam(value = "stype") String stype, 
			@RequestParam(value = "stext") String stext)
			throws UnsupportedEncodingException{
		
		
		Map<String, Object> list = new HashMap<String, Object>();
		int totgle = noticeService.getSearchTotgl1(stype, stext);
		int bopage = 10;
		int totpage = totgle / bopage + 1;
		System.out.println("전체글갯수"+totgle);
		
		System.out.println(stext);
		model.addAttribute("cont", totpage);
		noticeService.getNoticeSearch(list, model, cnt, stype, stext);
		model.addAttribute("cnt", cnt);
		return "tiles.notice";
	}
	
	
	@RequestMapping(value = "/cms/notice_boardwrite.do", method = RequestMethod.GET)
	public String notice_BoardWrite(Locale locale, Model model,HttpSession session) {
		
		

		

		// login1.jsp
		return "tiles.notice_boardwrite";
	}

	@RequestMapping(value = "/cms/notice_boardwritepost1.do", method = RequestMethod.POST)
	public String notice_boardWritePost(Locale locale, Model model, HttpSession session, String notice_board_title,
			String notice_board_contents, String notice_board_writter ) {
		
		Map<String, Object> bdwrite = new HashMap<String, Object>();
		bdwrite.put("notice_board_title", notice_board_title);
		bdwrite.put("notice_board_contents", notice_board_contents);
		bdwrite.put("notice_board_writter", notice_board_writter);
		
		noticeService.inputNotice(bdwrite, model);
		
		System.out.println(bdwrite.get("notice_board_writter"));
		
		//System.out.println(bdwrite.get("notice_board_title"));
		//System.out.println(bdwrite.get("notice_board_contents"));
		/*boardDAO.insertNotice_Board(board);*/
		// System.out.println(board.getContents());
		
		return "redirect:/cms/notice.do";

		
	}
	
	@RequestMapping(value = "/cms/notice_boardcontents.do", method = RequestMethod.GET)
	public String notice_boardcontents(Locale locale, Model model, HttpSession session,
			@RequestParam(value = "notice_board_no") int notice_board_no){
		
		noticeService.getBoardContents(notice_board_no, model) ;
		
		
		//model.addAttribute("ctntpre", boardDAO.getNotice_Prev(notice_board_no));
		//model.addAttribute("ctntnext", boardDAO.getNotice_Next(notice_board_no));

		
		// 조회수증가
		//int hit = boardDAO.notice_boardcontents(notice_board_no).getNotice_board_hit();
		//Map<String, Integer> map = new HashMap<String, Integer>();
		//map.put("notice_board_hit", hit + 1);
		//map.put("notice_board_no", notice_board_no);

		//boardDAO.notice_updateHit(map);

		// System.out.println("한글");
		return "tiles.notice_boardcontents";
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
