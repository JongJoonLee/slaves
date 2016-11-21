package kr.co.techflower.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.techflower.service.ExcelUploadService;
import ngel.core.service.AbstractCommonService;

@Service("excelUploadService")
public class ExcelUploadServiceImpl extends AbstractCommonService implements ExcelUploadService {

	@Override
	public int doSaveOneData(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> userTemp = mapper.selectList("ExcelhMapper.selectUserInfo", map);
		if(!userTemp.isEmpty() && userTemp.size() > 0){
			return mapper.update("ExcelhMapper.savePanelValueList", map);
		}else {
			return 0;
		}
	}

	@Override
	public int doSaveCateIdAvg(Map<String, Object> map) throws Exception {
		return mapper.update("ExcelhMapper.saveAverageList", map);
	}

}
