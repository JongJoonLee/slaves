package com.example.controller;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.bean.RedisLoginVO;


@Controller
public class redisController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	
	@Autowired
	RedisTemplate<String, Object> redisTemplate;

	@Resource(name = "redisTemplate")
	private ValueOperations<String, Object> valueOps;

	

	@RequestMapping(value = "/redis", method = RequestMethod.GET)
	public @ResponseBody String redis(){
		String str = new String("test");
		valueOps.set("hss", str);

		String ret = (String)valueOps.get("hss");
		return ret;
	}

	
	@RequestMapping(value = "/redislogin.do", method = RequestMethod.GET)
	public @ResponseBody String redis1(){
		RedisLoginVO rvo = new RedisLoginVO();
		rvo.setId("abc");
		rvo.setPassword("rpw");
		rvo.setName("rname");
		
		
		valueOps.set("mem1", rvo);
		
		RedisLoginVO ret = (RedisLoginVO)valueOps.get("mem1");

		return ret.getId();

	}

}

