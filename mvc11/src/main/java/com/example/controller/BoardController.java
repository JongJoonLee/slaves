package com.example.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.bean.B_Custom;
import com.example.bean.Board;
import com.example.bean.CustomSearchVO;
import com.example.bean.Member;
import com.example.dao.BoardDao;

@Controller
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Resource(name = "bDao")
	private BoardDao bDao;

	@RequestMapping(value = "/boardlist.do", method = RequestMethod.GET)
	public String boardlists(Locale locale, Model model, HttpSession session,
			@RequestParam(value = "page", required = false, defaultValue = "1") int cnt) {
		
		session.setAttribute("prev", "boardlist.do");
		System.out.println(session.getAttribute("prev"));
		int totgle = bDao.boardCount();
		int bopage = 20;
		
		int totpage = totgle / bopage+1;
		
		System.out.println(cnt);
		
		//1 0
		//2 10
		//3 20
		
		model.addAttribute("cont", totpage);
		model.addAttribute("blist", bDao.boardlist((cnt-1)*20));
		return "boardlist";
	}

	@RequestMapping(value = "/boardcontent.do", method = RequestMethod.GET)
	public String boardcontents(Locale locale, Model model, @RequestParam(value = "no") int no) {

		model.addAttribute("ctnt", bDao.boardcontents(no));
		model.addAttribute("ctntpre", bDao.boardcontents(no-1));
		model.addAttribute("ctntnext", bDao.boardcontents(no+1));

		return "boardcontent";

	}

	@RequestMapping(value = "/upload", method = RequestMethod.GET)
	public String upload() {

		return "upload"; // upload.jsp표시
	}

	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public @ResponseBody String upload1(@RequestParam("file") MultipartFile file, HttpServletRequest request) {

		// 파일이 비어 있지 않다면
		if (!file.isEmpty()) {
			try {
				String filename = file.getOriginalFilename();
				String root = request.getSession().getServletContext().getRealPath("/");
				
				System.out.println(root);

				// root디렉토리/upload디렉토리 밑에 생성
				File dir = new File(root + File.separator + "upload");

				// 디렉토리가 없으면 디렉토리 생성함.
				if (!dir.exists()) {
					dir.mkdirs();
				}

				byte[] bytedata = file.getBytes();

				File serverFile = new File(dir.getAbsolutePath() + File.separator + filename);
				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				stream.write(bytedata);
				stream.close();

				System.out.println(filename);
				System.out.println(root);
				return "upload ok";

			} catch (Exception e) {
				return "upload fail";
			}
		}
		else{
			return "upload fail";
		}
	}
	
	
	@RequestMapping(value = "/boardsearch.do", method = RequestMethod.GET)
	public String customsearch(Locale locale, Model model, 
				@RequestParam(value = "page", required = false, defaultValue = "1") int cnt,
				@RequestParam(value = "s_type") String s_type,
				@RequestParam(value = "s_text") String s_text) {
		
		CustomSearchVO bcp = new CustomSearchVO();
		bcp.setCnt((cnt-1)*20);
		bcp.setTxt(s_text);  //7
		bcp.setType(s_type);//c_id

	   
		List<Board> list = bDao.getBoardSearch(bcp);
		
		System.out.println(bcp.getCnt());
		
		model.addAttribute("blist", list);

		int tot = bDao.getListTot(bcp);
		model.addAttribute("cont", (tot/20)+1);

		model.addAttribute("type", s_type);
		model.addAttribute("txt", s_text);
	
		
	return "boardlist";
	}
	
	
	
	
	
	@RequestMapping(value = "/boardwrite.do", method = RequestMethod.GET)
	public ModelAndView BoardWrite(Locale locale, Model model) {
		
		
		
		Board board = new Board();

		// login1.jsp
		return new ModelAndView("boardwrite", "command", board);
	}
	
	
	
	
	@RequestMapping(value = "/boardwritepost1.do", method = RequestMethod.POST)
	public String BoardWritePost(Board board) {
		bDao.insertBoard(board);
		System.out.println(board.getContents());
		
		return "redirect:boardlist.do";
		
		//System.out.println(idid);
	
		/*try{
		bDao.insertBoard(board);
		return "boardlist";
		}
		catch(Exception e){
			System.out.println(e.getMessage());
		return "boardwrite";
		}*/
	}
	
	
	
	@RequestMapping(value = "/boardedit.do", method = RequestMethod.GET)
	public ModelAndView Boardedit(Locale locale, Model model,@RequestParam(value = "no") int no) {
				
		Board board = new Board();
		model.addAttribute("ctnt", bDao.boardcontents(no));

		// login1.jsp
		return new ModelAndView("boardedit", "command", board);
	}
	
	@RequestMapping(value = "/boardeditpost1.do", method = RequestMethod.POST)
	public String boardeditpost1(Board board,@RequestParam(value = "no") int no) {
		bDao.updateBoard(board);
		System.out.println(board.getNo());
		//System.out.println(no);
		
		return "redirect:boardcontent.do?no="+board.getNo();
	
	}
	
	
	
	@RequestMapping(value = "/boarddelete.do", method = RequestMethod.GET)
	public String deleteboardcontent(@RequestParam(value = "no") int no) {
		
		
		bDao.getBoardDelete(no);
		return "redirect:boardlist"; 
	}
	
	
	
	
	
	
	///////////////////// 공지사항 보드 ////////////////////////////////
	
	
	@RequestMapping(value = "/notice_boardlist.do", method = RequestMethod.GET)
	public String notice_boardlists(Locale locale, Model model, HttpSession session,
			@RequestParam(value = "page", required = false, defaultValue = "1") int cnt) {
		
		session.setAttribute("prev", "notice_boardlist.do");
		System.out.println(session.getAttribute("prev"));
		int totgle = bDao.notice_boardCount();
		int bopage = 20;
		
		int totpage = totgle / bopage+1;
		
		System.out.println(cnt);
		
		//1 0
		//2 10
		//3 20
		
		model.addAttribute("cont", totpage);
		model.addAttribute("blist", bDao.notice_boardlist((cnt-1)*20));
		return "notice_boardlist";
	}

	@RequestMapping(value = "/notice_boardcontent.do", method = RequestMethod.GET)
	public String notice_boardcontents(Locale locale, Model model, @RequestParam(value = "no") int no) {

		model.addAttribute("ctnt", bDao.notice_boardcontents(no));
		model.addAttribute("ctntpre", bDao.notice_boardcontents(no-1));
		model.addAttribute("ctntnext", bDao.notice_boardcontents(no+1));

		return "notice_boardcontent";

	}
	
	
	@RequestMapping(value = "/notice_boardsearch.do", method = RequestMethod.GET)
	public String notice_customsearch(Locale locale, Model model, 
				@RequestParam(value = "page", required = false, defaultValue = "1") int cnt,
				@RequestParam(value = "s_type") String s_type,
				@RequestParam(value = "s_text") String s_text) {
		
		CustomSearchVO bcp = new CustomSearchVO();
		bcp.setCnt((cnt-1)*20);
		bcp.setTxt(s_text);  //7
		bcp.setType(s_type);//c_id

	   
		List<Board> list = bDao.getNotice_BoardSearch(bcp);
		
		//System.out.println(bcp.getCnt());
		
		model.addAttribute("blist", list);

		int tot = bDao.getNotice_ListTot(bcp);
		model.addAttribute("cont", (tot/20)+1);

		model.addAttribute("type", s_type);
		model.addAttribute("txt", s_text);
	
		
	return "notice_boardlist";
	}
	
	
	
	
	
	@RequestMapping(value = "/notice_boardwrite.do", method = RequestMethod.GET)
	public ModelAndView notice_BoardWrite(Locale locale, Model model) {
		
		
		
		Board board = new Board();

		// login1.jsp
		return new ModelAndView("notice_boardwrite", "command", board);
	}
	
	
	
	
	@RequestMapping(value = "/notice_boardwritepost1.do", method = RequestMethod.POST)
	public String notice_oardWritePost(Board board) {
		bDao.insertNotice_Board(board);
		//System.out.println(board.getContents());
		
		return "redirect:notice_boardlist.do";
		
		//System.out.println(idid);
	
		/*try{
		bDao.insertBoard(board);
		return "boardlist";
		}
		catch(Exception e){
			System.out.println(e.getMessage());
		return "boardwrite";
		}*/
	}
	
	
	
	@RequestMapping(value = "/notice_boardedit.do", method = RequestMethod.GET)
	public ModelAndView notice_Boardedit(Locale locale, Model model,@RequestParam(value = "no") int no) {
				
		Board board = new Board();
		model.addAttribute("ctnt", bDao.notice_boardcontents(no));

		// login1.jsp
		return new ModelAndView("notice_boardedit", "command", board);
	}
	
	@RequestMapping(value = "/notice_boardeditpost1.do", method = RequestMethod.POST)
	public String notice_boardeditpost1(Board board,@RequestParam(value = "no") int no) {
		bDao.updateNotice_Board(board);
		System.out.println(board.getNo());
		//System.out.println(no);
		
		return "redirect:notice_boardcontent.do?no="+board.getNo();
	
	}
	
	
	
	
	////////////////////공지사항 보드 끝 ///////////////////////////////
	
	
	
	
}