package kr.co.techflower.service.impl;

import java.util.List;
import java.util.Map;

import ngel.core.service.AbstractCommonService;

import org.springframework.stereotype.Service;

import kr.co.techflower.service.CodeService;

@Service("codeService")
public class CodeServiceImpl extends AbstractCommonService implements CodeService {

	@Override
	public List<Map<String, Object>> selectBasicCode(Map<String, Object> map) throws Exception {
		return mapper.selectList("CodeMapper.selectBasicCode", map);
	}

	@Override
	public int saveBasicCode(Map<String, Object> map) throws Exception {
		int resultVale = 0;
		if(map.get("rowType").equals("C")|| map.get("rowType").equals("U")){
			resultVale = mapper.update("CodeMapper.saveBasicCode", map);			
		}else if(map.get("rowType").equals("D")){
			resultVale = mapper.delete("CodeMapper.deleteBasicCode", map);			
		}
		return resultVale;
	}
	
}
