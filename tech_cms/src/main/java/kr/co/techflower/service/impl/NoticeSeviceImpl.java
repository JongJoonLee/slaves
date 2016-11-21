package kr.co.techflower.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.techflower.service.NoticeSevice;
import ngel.core.service.AbstractCommonService;

@Service("noticeSevice")
public class NoticeSeviceImpl extends AbstractCommonService implements NoticeSevice {

	@Override
	public List<Map<String, Object>> doSearch(Map<String, Object> map)
			throws Exception {
		return mapper.select("NoticeMapper.selectNoticeList", map);
	}

	@Override
	public List<Map<String, Object>> doComboList(Map<String, Object> map)
			throws Exception {
		return mapper.select("NoticeMapper.selectNoticeParentComboList", map);
	}

	@Override
	public int doSave(Map<String, Object> map) throws Exception {
		int vnResultVal = 0;
		Object vsRowType = map.get("rowType");
		if("D".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			System.out.println(map);
			vnResultVal += mapper.delete("NoticeMapper.deleteNoticeList", map);
		}else if("U".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			System.out.println(map);
			vnResultVal += mapper.update("NoticeMapper.updateNoticeList", map);
		}else if("C".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			System.out.println(map);
			vnResultVal += mapper.insert("NoticeMapper.insertNoticeList", map);
		}else{
			return 0;
		}
		return vnResultVal;
	}

	@Override
	public Map<String, Object> doBoardCdCnt(Map<String, Object> map)
			throws Exception {
		return mapper.selectOne("NoticeMapper.selectHaveIdCnt", map);
	}

}
