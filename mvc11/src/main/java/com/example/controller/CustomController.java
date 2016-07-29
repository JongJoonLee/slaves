package com.example.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Locale;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.runner.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.bean.AccountVO;
import com.example.bean.B_Custom;
import com.example.bean.CustomSearchVO;
import com.example.dao.CustomDAO;
import com.example.dao.MongoDAO;

@Controller
public class CustomController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Resource(name = "cDao")
	private CustomDAO cDao;

	@RequestMapping(value = "/bcustom.do", method = RequestMethod.GET)
	public ModelAndView bcustom() {

		return new ModelAndView("bcustom", "command3", new B_Custom());
	}

	@Resource(name = "mongoDAO")
	private MongoDAO mongoDAO;

	@RequestMapping(value = "/bcustompost.do", method = RequestMethod.POST)
	public String bcustompost(@ModelAttribute("command3") B_Custom bcustom) {

		// System.out.println(bcustom.getC_name());

		cDao.insertBcustom(bcustom);
		/*
		 * @SuppressWarnings("deprecation") MongoOperations mongoOps = new
		 * MongoTemplate(new Mongo(), "test");
		 * 
		 * try{ mongoOps.insert(new TestVO()); System.out.println("성공"); }
		 * catch(Exception e){ System.out.println(e.getMessage()); }
		 */

		// mongoDAO.insertTestVO();
		// mongoOperation

		return "bcustom";
	}

	@RequestMapping(value = "/customlist.do", method = RequestMethod.GET)
	public String customlists(Locale locale, Model model,
			@RequestParam(value = "page", required = false, defaultValue = "1") int cnt ) {
		
		int totgle = cDao.getCustomCount();
		int bopage = 10;
		
		int totpage = totgle / bopage+1;
		//System.out.println("/////////////////////////////////");
		//System.out.println("customlist totpage : " + totpage);
		//System.out.println("/////////////////////////////////");
		//1 0
		//2 10
		//3 20
		
		model.addAttribute("cont", totpage);
		
		
		
		
		model.addAttribute("clist", cDao.customList((cnt-1)*10));

		return "customlist";
	}

	@RequestMapping(value = "/mkaccount.do", method = RequestMethod.GET)
	public ModelAndView mkaccounts(Locale locale, Model model, @RequestParam(value = "c_id") String c_id) {

		// System.out.println(c_id);
		Random random = new Random();
		int ra1 = random.nextInt(10);
		int ra2 = random.nextInt(10);
		int ra3 = random.nextInt(10);
		int ra4 = random.nextInt(10);
		int ra5 = random.nextInt(10);
		int ra6 = random.nextInt(10);
		int ra7 = random.nextInt(10);
		int ra8 = random.nextInt(10);
		int ra9 = random.nextInt(10);
		int ra10 = random.nextInt(10);
		int ra11 = random.nextInt(10);
		int ra12 = random.nextInt(10);

		String a1 = String.valueOf(ra1);
		String a2 = String.valueOf(ra2);
		String a3 = String.valueOf(ra3);
		String a4 = String.valueOf(ra4);
		String a5 = String.valueOf(ra5);
		String a6 = String.valueOf(ra6);
		String a7 = String.valueOf(ra7);
		String a8 = String.valueOf(ra8);
		String a9 = String.valueOf(ra9);
		String a10 = String.valueOf(ra10);
		String a11 = String.valueOf(ra11);
		String a12 = String.valueOf(ra12);

		String ano = a1 + a2 + a3 + a4 + "-" + a5 + a6 + a7 + a8 + "-" + a9 + a10 + a11 + a12;

		model.addAttribute("cid", c_id);
		model.addAttribute("ano", ano);

		return new ModelAndView("mkaccount", "command", new AccountVO());

	}

	@RequestMapping(value = "/mkaccountpost.do", method = RequestMethod.POST)
	public String mkaccountspost(@ModelAttribute("command") AccountVO AVO) {
	
	
	
		//System.out.println(AVO.getC_id());
		
		
		try {

			cDao.insertmkaccount(AVO);
			//return "myaccount.do?c_id="+AVO.getC_id() ;   
			
		} 
		catch (Exception e) {
			//System.out.println(e.getMessage());
		}

		
		return "redirect:myaccount.do?c_id="+AVO.getC_id();
	}
	
	
	@RequestMapping(value = "/myaccount.do", method = RequestMethod.GET)
	public String myaccounts(Locale locale, Model model, @RequestParam(value = "c_id") int c_id) {

		/*model.addAttribute("clist", cDao.customList());*/
		model.addAttribute("calist", cDao.MyaccountList(c_id));

		
		
		
		
		/*return "redirect:myaccount.do?c_id="+c_id;*/
		return "myaccount";
	}
	
	@RequestMapping(value = "/customsearch.do", method = RequestMethod.GET)
	public String customsearch(Locale locale, Model model, 
				@RequestParam(value = "page", required = false, defaultValue = "1") int cnt,
				@RequestParam(value = "s_type") String s_type,
				@RequestParam(value = "s_text") String s_text) {
		
		CustomSearchVO bcp = new CustomSearchVO();
		bcp.setCnt((cnt-1)*10);
		bcp.setTxt(s_text);  //7
		bcp.setType(s_type);//c_id

	   
		List<B_Custom> list = cDao.getSearchList(bcp);
		model.addAttribute("clist", list);

		int tot = cDao.getListTot(bcp);
		model.addAttribute("cont", (tot/10)+1);

		model.addAttribute("type", s_type);
		model.addAttribute("txt", s_text);
		/*
		int totgle = cDao.getCustomCount();
		int bopage = 10;
		
		int totpage = totgle / bopage+1;
		System.out.println("/////////////////////////////////");
		System.out.println("customlist totpage : " + totpage);
		System.out.println("/////////////////////////////////");
		//1 0
		//2 10
		//3 20

		System.out.println("-//--//--//--//검색//--//--//-");
		System.out.println("s-type : " + s_type);
		System.out.println("s-text : " + s_text);
		System.out.println("-//--//--//--//--//--//--//-");
		
		
		
		model.addAttribute("cont", totpage);
	*/
		
	return "customlist";
	}
	
	

}
