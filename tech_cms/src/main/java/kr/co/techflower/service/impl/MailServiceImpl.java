package kr.co.techflower.service.impl;

import java.util.List;
import java.util.Map;

import ngel.core.service.AbstractCommonService;

import org.springframework.stereotype.Service;

import kr.co.techflower.service.MailService;

@Service("mailService")
public class MailServiceImpl extends AbstractCommonService implements MailService {

	@Override
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception {
		return mapper.selectList("MailMapper.selectBoardList", map);
	}

	@Override
	public int saveUserList(Map<String, Object> map) throws Exception {
		int resultVale = 0;
		resultVale = mapper.update("MailMapper.saveUserMailReceive", map);			
		return resultVale;
	}

	@Override
	public List<Map<String, Object>> selectUserList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return mapper.select("MailMapper.selectUserList", map);
	}

	@Override
	public List<Map<String, Object>> selectComboList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return mapper.select("MenuMapper.selectComboList", map);
	}
	
}
