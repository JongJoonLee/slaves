package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.bean.ItemVO;
import com.example.bean.Member;
import com.example.dao.ItemDAO;
import com.example.dao.MemberDao;

@Controller
public class AppController {

	private static final Logger logger = LoggerFactory.getLogger(AppController.class);

	@Resource(name = "mDao")
	private MemberDao mDao;
	@Resource(name = "itemDao")
	private ItemDAO itemDao;

	// 127.0.0.1:8080/mvc2/appidcheck
	@RequestMapping(value = "/appidcheck.do")
	public @ResponseBody Map<String, Integer> appidcheck(HttpServletResponse response,
			@RequestParam(value = "id", required = false, defaultValue = "") String userid) {

		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
		response.setHeader("Access-Control-Allow-Origin", "*");

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		// Dao에 함수를 만든다음 id값을 전달해서 id가 존재하는지 구현.

		String retid = mDao.getCheckUserId(userid);

		Map<String, Integer> map = new HashMap<String, Integer>();

		map.put("ret", 1);
		if (retid != null) {
			if (retid.equals(userid)) {
				map.put("ret", 0);
			}
		}

		return map;
	}

	@RequestMapping(value = "/itemlist.do", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody List<ItemVO> itemlist(@RequestParam("start") int start, HttpServletResponse response) {

		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
		response.setHeader("Access-Control-Allow-Origin", "*");

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		return itemDao.getItemList(start);
	}

	@RequestMapping(value = "/app_member_edit", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Map<String, Integer> appMemberEdit(HttpServletResponse response, @RequestParam("id") String id,
			@RequestParam("name") String name, @RequestParam("tel") String tel, @RequestParam("email") String email) {

		// cross domain 지원 - 클라이언트의 주소가 서버의 내부가 아니더라도 데이터전송가능
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		Member member = new Member();
		member.setId(id);
		member.setName(name);
		member.setTel(tel);
		member.setEmail(email);

		int tmp = mDao.appMemberEdit(member);

		Map<String, Integer> map = new HashMap<String, Integer>();

		map.put("ret", 0);
		if (tmp > 0) {
			map.put("ret", 1);
		}

		return map;
	}

	@RequestMapping(value = "/app_get_member_one", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Member appGetMemberOne(HttpServletResponse response, @RequestParam("id") String id) {

		
		// cross domain 지원 - 클라이언트의 주소가 서버의 내부가 아니더라도 데이터전송가능
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		Member tmp = mDao.appGetMemberOne(id);
		return tmp; // 자동적으로 json
	}

}
