package kr.co.techflower.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.techflower.service.WebeditorService;
import ngel.core.service.AbstractCommonService;

@Service("webeditorService")
public class WebeditorServiceImpl extends AbstractCommonService implements
		WebeditorService {

	@Override
	public List<Map<String, Object>> doCombo(Map<String, Object> map)
			throws Exception {
		return mapper.select("WebeditorMapper.selectEditorComboList", map);
	}
	
	@Override
	public List<Map<String, Object>> doSearch(Map<String, Object> map)
			throws Exception {
		return mapper.select("WebeditorMapper.selectEditorList", map);
	}

	@Override
	public List<Map<String, Object>> doDetailSearch(Map<String, Object> map)
			throws Exception {
		return mapper.select("WebeditorMapper.selectEditorDetailList", map);
	}

	@Override
	public int doSave(Map<String, Object> map) throws Exception {
		int vnResultVal = 0;
		Object vsRowType = map.get("rowType");
		System.out.println(map);
		if("D".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			Map<String, Object> toData = mapper.selectOne("WebeditorMapper.selectEditorDetailList", map);
			if(!toData.isEmpty()){
				//mapper.insert("WebeditorMapper.insertBackupEditorList", toData);
				vnResultVal += mapper.delete("WebeditorMapper.deleteEditorList", map);
			}
		}else if("U".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			Map<String, Object> toData = mapper.selectOne("WebeditorMapper.selectEditorDetailList", map);
			if(!toData.isEmpty()){
				//mapper.insert("WebeditorMapper.insertBackupEditorList", toData);
				vnResultVal += mapper.update("WebeditorMapper.updateEditorList", map);
			}
		}else if("C".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			Map<String, Object> idMap =  mapper.selectOne("WebeditorMapper.selectMaxIdList");
			if(null != idMap.get("DESIGN_PAGE_ID")){
				map.put("DESIGN_PAGE_ID", idMap.get("DESIGN_PAGE_ID"));
				List<Map<String, Object>> localeList = mapper.select("WebeditorMapper.selectEditorComboList", null);
				if(!localeList.isEmpty() && localeList.size() > 0){
					for(int i = 0; i < localeList.size(); i++){
						map.put("DESIGN_LOCALE", localeList.get(i).get("COM_CD"));
						vnResultVal += mapper.insert("WebeditorMapper.insertEditorList", map);
					}
				}
			}
		}else{
			return 0;
		}
		return vnResultVal;
	}

	@Override
	public Map<String, Object> doContentSave(Map<String, Object> map)
			throws Exception {
		int vnResultVal = 0;
		System.out.println(map);
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		Map<String, Object> toData = mapper.selectOne("WebeditorMapper.selectEditorDetailList", map);
		
		if(!toData.isEmpty()){
			//mapper.insert("WebeditorMapper.insertBackupEditorList", toData);
			vnResultVal += mapper.update("WebeditorMapper.updateEditorList", map);
		}
		if(vnResultVal > 0){
			resMap.put("result", true);
			resMap.put("resultVal", "완료");
		}else{
			resMap.put("result", false);
			resMap.put("resultVal", "실패");
		}
		return resMap;
	}

}
