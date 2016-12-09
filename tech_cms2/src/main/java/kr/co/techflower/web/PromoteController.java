package kr.co.techflower.web;


import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.techflower.service.PromoteService;

@Controller
public class PromoteController {
	
	@Autowired
	PromoteService promoteService;
	
	@RequestMapping(value="/cms/promote.do")
	public String doList(Locale locale, Model model, HttpSession session,
			@RequestParam(value = "page", required = false, defaultValue = "1") int cnt) throws Exception{
		
		
		
		Map<String, Object> list = new HashMap<String, Object>();
		int totgle = promoteService.getPromoteCount();
		//System.out.println("토탈글이다다다다다다닫 : "+totgle);
		int bopage = 10;
		int totpage = totgle / bopage + 1;
		model.addAttribute("cont", totpage);
		promoteService.getPromoteList(list, model, cnt);
		
		return "tiles.promote";
	};
	@RequestMapping(value="/cms/promote_contents.do")
	public String getPromoteContents(Locale locale, Model model, HttpSession session
			,@RequestParam(value = "tb_promote_no") int tb_promote_no) throws Exception{
		
			
			promoteService.getPromoteContents(model, tb_promote_no);
			promoteService.updatePromoteHit(tb_promote_no, model);
			
		
		
		return "tiles.promote_contents"	;	
	}
	
	
	@RequestMapping(value = "/cms/promote_write.do", method = RequestMethod.GET)
	public String Promote_Write(Locale locale, Model model,HttpSession session) {
		
		
		return "tiles.promote_write";
	}
	
	@RequestMapping(value = "/cms/promote_writepost1.do", method = RequestMethod.POST)
	public String Promote_WritePost(Locale locale, Model model, HttpSession session, String tb_promote_title,
			String tb_promote_contents) {
		
		Map<String, Object> prwrite = new HashMap<String, Object>();
		prwrite.put("tb_promote_title", tb_promote_title);
		prwrite.put("tb_promote_contents", tb_promote_contents);
		
		
		promoteService.inputPromote(prwrite, model);
		
		
		
		return "redirect:/cms/promote.do";

		
	}
	
	
	@RequestMapping(value = "/cms/promote_search.do", method = RequestMethod.GET)
	public String promote_customsearch(Locale locale, Model model, HttpSession session,
			@RequestParam(value = "page", required = false, defaultValue = "1") int cnt,
			@RequestParam(value = "stype") String stype, 
			@RequestParam(value = "stext") String stext)
			throws UnsupportedEncodingException{
		
		
		Map<String, Object> list = new HashMap<String, Object>();
		int totgle = promoteService.getSearchTotgl1(stype, stext);
		int bopage = 10;
		int totpage = totgle / bopage + 1;
		System.out.println("전체글갯수"+totgle);
		
		System.out.println(stext);
		model.addAttribute("cont", totpage);
		promoteService.getPromoteSearch(list, model, cnt, stype, stext);
		model.addAttribute("cnt", cnt);
		return "tiles.promote";
	}
	
	@RequestMapping(value = "/cms/promote_edit.do", method = RequestMethod.GET)
	public String notice_boardEdit(Locale locale, Model model, HttpSession session,
			@RequestParam(value = "tb_promote_no") int tb_promote_no) throws Exception{
		
		promoteService.getPromoteContents(model, tb_promote_no);
		
		
		
		return "tiles.promote_edit";
	}
	
	
	@RequestMapping(value = "/cms/tb_promoteupdatepost1.do", method = RequestMethod.POST)
	public String tb_promoteupdatepost1(Locale locale, Model model, HttpSession session, String tb_promote_title,
			String tb_promote_contents, int tb_promote_no ) {
		
		Map<String, Object> bdupdate = new HashMap<String, Object>();
		bdupdate.put("tb_promote_title", tb_promote_title);
		bdupdate.put("tb_promote_contents", tb_promote_contents);
		bdupdate.put("tb_promote_no", tb_promote_no);
		
		promoteService.updatePromote(bdupdate, tb_promote_no, model);
		
		
		//System.out.println(bdwrite.get("notice_board_title"));
		//System.out.println(bdwrite.get("notice_board_contents"));
		/*boardDAO.insertNotice_Board(board);*/
		// System.out.println(board.getContents());
		
		return "redirect:/cms/promote.do";

		
	}
	
	
	

}
