package kr.co.techflower.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.techflower.model.MessageResource;
import kr.co.techflower.service.MessageResourceService;
import ngel.core.service.AbstractCommonService;

@Service("messageResourceService")
public class MessageResourceServiceImpl extends AbstractCommonService implements MessageResourceService{
	
	public MessageResourceServiceImpl() {
		// TODO Auto-generated constructor stub
		super();
	}
	
	@Override
	public List<MessageResource> loadAllMessages() {
		// TODO Auto-generated method stub
		return mapper.select("msgMapper.loadAllMessages", null);
	}

	@Override
	public List<Map<String, String>> loadUseLocale() {
		// TODO Auto-generated method stub
		return mapper.select("msgMapper.loadUseLocale", null);
	}
	
}
