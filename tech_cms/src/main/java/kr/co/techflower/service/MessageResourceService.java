package kr.co.techflower.service;

import java.util.List;
import java.util.Map;

import kr.co.techflower.model.MessageResource;

public interface MessageResourceService{
	public List<MessageResource> loadAllMessages();
	public List<Map<String, String>> loadUseLocale();
}
