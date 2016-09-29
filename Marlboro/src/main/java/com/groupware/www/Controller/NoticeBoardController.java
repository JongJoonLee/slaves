package com.groupware.www.Controller;

import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.groupware.www.Dao.NoticeBoardDao;
import com.groupware.www.Vo.NoticeBoardVO;

@Controller
public class NoticeBoardController {

	@Resource(name = "bDao")
	private NoticeBoardDao bDao;

	@RequestMapping(value = "index1.do", method = RequestMethod.GET)
	public String notice_board_test(Locale locale, Model model) {

		/*model.addAttribute("blist", bDao.boardlist());*/
		List<NoticeBoardVO> list = bDao.boardlist();

		// System.out.println(bcp.getCnt());

		model.addAttribute("blist", list);
		System.out.println();

		return "notice_board_test";
	}
	
	
	

}
