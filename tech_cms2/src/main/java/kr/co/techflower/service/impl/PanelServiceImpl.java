package kr.co.techflower.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.security.authentication.encoding.MessageDigestPasswordEncoder;
import org.springframework.security.crypto.password.StandardPasswordEncoder;

import ngel.core.service.AbstractCommonService;

import org.springframework.stereotype.Service;

import kr.co.techflower.service.PanelService;

@Service("panelService")
public class PanelServiceImpl extends AbstractCommonService implements PanelService {

	@Override
	public List<Map<String, Object>> doComboList(Map<String, Object> map)
			throws Exception {
		return mapper.selectList("PanelMapper.selectPanelDivList", map);
	}
	
	@Override
	public List<Map<String, Object>> doSearch(Map<String, Object> map)
			throws Exception {
		return mapper.selectList("PanelMapper.selectPanelDataNonPagingList", map);
	}

	@Override
	public int doSave(Map<String, Object> map) throws Exception {
		
		int vnResultVal = 0;
		Object vsRowType = map.get("rowType");
		map.put("MEMBER_CLASS_CD", 30);
		System.out.println(map);
		if("D".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			vnResultVal += mapper.update("PanelMapper.updatePanelDelYnInfoList", map);
			vnResultVal += mapper.update("PanelMapper.updatePanelDelYnIdList", map);
		}else if("U".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			vnResultVal += mapper.update("PanelMapper.updatePanelList", map);
			vnResultVal += mapper.update("PanelMapper.updatePanelInfoList", map);
		}else if("C".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			
			List<Map<String, Object>> cntList = mapper.select("PanelMapper.selectUserIdCnt", map);
			if(Integer.parseInt(String.valueOf(cntList.get(0).get("USER_CNT"))) > 0){
				return 0;
			}
			
			MessageDigestPasswordEncoder encoder = new MessageDigestPasswordEncoder("SHA-256");
			String te = encoder.encodePassword("1", null).toUpperCase();
			map.put("PW", te);
			
			//StandardPasswordEncoder encoder = new StandardPasswordEncoder();
			//map.put("PW", encoder.encode("1"));
			
			vnResultVal += mapper.insert("PanelMapper.insertPanelList", map);
			vnResultVal += mapper.insert("PanelMapper.insertPanelInfoList", map);
		}else{
			return 0;
		}
		return vnResultVal;
	}

	@Override
	public List<Map<String, Object>> doSearchIdx(Map<String, Object> map)
			throws Exception {
		return mapper.selectList("PanelMapper.selectPanelIdxList", map);
	}

	@Override
	public List<Map<String, Object>> doSearchIdxPanel(
			Map<String, Object> map) throws Exception {
		return mapper.selectList("PanelMapper.selectPanelIdxPanelList", map);
	}

	@Override
	public List<Map<String, Object>> doSearchIdxCenter(
			Map<String, Object> map) throws Exception {
		return mapper.selectList("PanelMapper.selectPanelIdxCenterList", map);
	}

}
