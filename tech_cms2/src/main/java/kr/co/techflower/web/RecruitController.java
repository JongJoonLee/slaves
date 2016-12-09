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

import kr.co.techflower.service.RecruitService;
import ngel.core.web.FrameworkController;

@Controller
public class RecruitController extends FrameworkController{
	
	@Autowired
	RecruitService recruitService;
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@RequestMapping(value="/cms/recruit.do")
	public String doList(Locale locale, Model model, HttpSession session,
			@RequestParam(value = "page", required = false, defaultValue = "1") int cnt) throws Exception{
		
		
		//String mem = (String) session.getAttribute("_name");
		Map<String, Object> list = new HashMap<String, Object>();
		int totgle = recruitService.getTotgl1();
		int bopage = 10;
		int totpage = totgle / bopage + 1;
		model.addAttribute("cont", totpage);
		recruitService.getRecruitList(list, model, cnt);
		
		
		return "tiles.recruit";
	};
	
	@RequestMapping(value = "/cms/recruit_boardsearch.do", method = RequestMethod.GET)
	public String notice_customsearch(Locale locale, Model model, HttpSession session,
			@RequestParam(value = "page", required = false, defaultValue = "1") int cnt,
			@RequestParam(value = "stype") String stype, 
			@RequestParam(value = "stext") String stext)
			throws UnsupportedEncodingException{
		
		
		Map<String, Object> list = new HashMap<String, Object>();
		int totgle = recruitService.getSearchTotgl1(stype, stext);
		int bopage = 10;
		int totpage = totgle / bopage + 1;
		System.out.println("전체글갯수"+totgle);
		
		System.out.println(stext);
		model.addAttribute("cont", totpage);
		recruitService.getRecruitSearch(list, model, cnt, stype, stext);
		model.addAttribute("cnt", cnt);
		return "tiles.recruit";
	}
	
	
	@RequestMapping(value = "/cms/recruit_boardwrite.do", method = RequestMethod.GET)
	public String recruit_BoardWrite(Locale locale, Model model,HttpSession session) {
		
		

		

		// login1.jsp
		return "tiles.recruit_boardwrite";
	}

	@RequestMapping(value = "/cms/recruit_writepost1.do", method = RequestMethod.POST)
	public String notice_boardWritePost(Locale locale, Model model, HttpSession session, String tb_recruit_title,
			String tb_recruit_contents, String tb_recruit_writter ) {
		
		Map<String, Object> bdwrite = new HashMap<String, Object>();
		bdwrite.put("tb_recruit_title", tb_recruit_title);
		bdwrite.put("tb_recruit_contents", tb_recruit_contents);
		bdwrite.put("tb_recruit_writter", tb_recruit_writter);
		
		recruitService.inputRecruit(bdwrite, model);
		
		System.out.println(bdwrite.get("recruit_board_writter"));
		
		//System.out.println(bdwrite.get("notice_board_title"));
		//System.out.println(bdwrite.get("notice_board_contents"));
		/*boardDAO.insertNotice_Board(board);*/
		// System.out.println(board.getContents());
		
		return "redirect:/cms/recruit.do";

		
	}
	
	@RequestMapping(value = "/cms/recruit_boardcontents.do", method = RequestMethod.GET)
	public String notice_boardcontents(Locale locale, Model model, HttpSession session,
			@RequestParam(value = "tb_recruit_no") int tb_recruit_no){
		
		recruitService.getRecruitContents(tb_recruit_no, model) ;
		
		// 조회수증가
		recruitService.updateHit(tb_recruit_no, model);
		
		return "tiles.recruit_boardcontents";
	}

}
