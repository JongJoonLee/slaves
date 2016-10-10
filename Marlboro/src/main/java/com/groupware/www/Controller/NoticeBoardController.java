package com.groupware.www.Controller;

import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.groupware.www.Dao.NoticeBoardDao;
import com.groupware.www.Vo.NoticeBoardVO;

@Controller
public class NoticeBoardController {

	@Resource(name = "bDao")
	private NoticeBoardDao bDao;

	@RequestMapping(value = "notice_board_test.do", method = RequestMethod.GET)
	public String notice_board_test(Locale locale, Model model) {

		/*model.addAttribute("blist", bDao.boardlist());*/
		List<NoticeBoardVO> list = bDao.boardlist();

		// System.out.println(bcp.getCnt()); 

		model.addAttribute("blist", list);
		System.out.println();

		return "notice_board_test";
	}
	
	
	
	@RequestMapping(value = "/boardwrite.do", method = RequestMethod.GET)
	public ModelAndView BoardWrite(Locale locale, Model model) {

		NoticeBoardVO board = new NoticeBoardVO();

		// login1.jsp
		return new ModelAndView("boardwrite", "command", board);
	}

	@RequestMapping(value = "/boardwritepost1.do", method = RequestMethod.POST)
	public String BoardWritePost(NoticeBoardVO board) {
		bDao.insertBoard(board);
		// System.out.println(board.getContents());

		return "redirect:boardlist.do";

		// System.out.println(idid);

		/*
		 * try{ bDao.insertBoard(board); return "boardlist"; } catch(Exception
		 * e){ System.out.println(e.getMessage()); return "boardwrite"; }
		 */
	}

	@RequestMapping(value = "/boardedit.do", method = RequestMethod.GET)
	public ModelAndView Boardedit(Locale locale, Model model, @RequestParam(value = "no") int no) {

		NoticeBoardVO board = new NoticeBoardVO();
		model.addAttribute("ctnt", bDao.boardcontents(no));

		// login1.jsp
		return new ModelAndView("boardedit", "command", board);
	}

	@RequestMapping(value = "/boardeditpost1.do", method = RequestMethod.POST)
	public String boardeditpost1(NoticeBoardVO board, @RequestParam(value = "no") int no) {

		bDao.updateBoard(board);
		// System.out.println(board.getNo());
		// System.out.println(no);

		return "redirect:boardcontent.do?no=" + board.getNo();

	}

	@RequestMapping(value = "/boarddelete.do", method = RequestMethod.GET)
	public String deleteboardcontent(@RequestParam(value = "no") int no) {

		int res = 0;

		res = bDao.getBoardDelete(no);
		return "redirect:boardlist.do";
	}
	
	
	

}
