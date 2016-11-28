package kr.co.techflower.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.techflower.service.BannerService;
import ngel.core.service.AbstractCommonService;

@Service("bannerService")
public class BannerServiceImpl extends AbstractCommonService implements BannerService {

	@Override
	public List<Map<String, Object>> doSearch(Map<String, Object> map)
			throws Exception {
		return mapper.select("BannerMapper.selectBannerDataList", map);
	}

	@Override
	public List<Map<String, Object>> doOneDataSearch(Map<String, Object> map)
			throws Exception {
		return null;
	}

	@Override
	public int doDelete(Map<String, Object> map)
			throws Exception {
		int result = 0;
		result += mapper.delete("BannerMapper.deleteBannerDataList", map);
		result += mapper.delete("BannerMapper.deleteBannerFileDataList", map);
		return result;
	}

	@Override
	public Map<String, Object> doUpdate(Map<String, Object> map)
			throws Exception {
		mapper.update("BannerMapper.updateBannerDataList", map);
		return map;
	}
	
	@Override
	public int doUpdateFile(Map<String, Object> map) throws Exception {
		return mapper.update("BannerMapper.updateBannerFileDataList", map);
	}

	@Override
	public Map<String, Object> doInsert(Map<String, Object> map)
			throws Exception {
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> list = mapper.select("BannerMapper.selectNewBannerId", map);
		if(!list.isEmpty() && list.size() > 0){
			resMap.put("BANNER_ID", list.get(0).get("NEW_BANNER"));
			resMap.put("TBL_PK", list.get(0).get("NEW_BANNER"));
			resMap.put("REG_ID", "ADMIN");
			map.put("BANNER_ID", list.get(0).get("NEW_BANNER"));
			map.put("REG_ID", "ADMIN");
			mapper.insert("BannerMapper.insertBannerDataList", map);
			return resMap;
		}else{
			return resMap;
		}
	}

	@Override
	public int doInsertFile(Map<String, Object> map) throws Exception {
		return mapper.insert("BannerMapper.insertBannerFileDataList", map);
	}

}
