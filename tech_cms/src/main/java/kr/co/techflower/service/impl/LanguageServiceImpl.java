package kr.co.techflower.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.techflower.service.LanguageService;
import ngel.core.service.AbstractCommonService;

@Service("languageService")
public class LanguageServiceImpl extends AbstractCommonService implements
		LanguageService {

	@Override
	public List<Map<String, Object>> doComboList(Map<String, Object> map)
			throws Exception {
		return mapper.select("LanguageMapper.selectLocaleDivList", map);
	}
	
	@Override
	public List<Map<String, Object>> doSearch(Map<String, Object> map)
			throws Exception {
		return mapper.select("LanguageMapper.selectLangDataList", map);
	}

	@Override
	public int doDelete(Map<String, Object> map) throws Exception {
		return mapper.delete("LanguageMapper.deleteLangDataList", map);
	}

	@Override
	public int doUpdate(Map<String, Object> map) throws Exception {
		return mapper.update("LanguageMapper.updateLangDataList", map);
	}

	@Override
	public int doInsert(Map<String, Object> map) throws Exception {
		return mapper.insert("LanguageMapper.insertLangDataList", map);
	}

}
