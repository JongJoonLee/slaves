package kr.co.techflower.service.impl;

import java.util.List;
import java.util.Map;

import ngel.core.service.AbstractCommonService;

import org.springframework.stereotype.Service;

import kr.co.techflower.service.MenuService;

@Service("menuService")
public class MenuServiceImpl extends AbstractCommonService implements MenuService {

	@Override
	public List<Map<String, Object>> selectMenuList(Map<String, Object> map) throws Exception {
		return mapper.selectList("MenuMapper.selectMenuList", map);
	}

	@Override
	public int saveMenuList(Map<String, Object> map) throws Exception {
		int resultVale = 0;
		if(map.get("rowType").equals("C")|| map.get("rowType").equals("U")){
			Object TMPCLASS = map.get("TMPCLASS");
			if (TMPCLASS.equals("IDX")) {
				map.put("IDX_MENU", map.get("TMPCLASSNM")); 
			} else if (TMPCLASS.equals("DESIGNPAGE")) {
				map.put("DESIGN_PAGE_ID", map.get("TMPCLASSNM")); 
			} else if (TMPCLASS.equals("BOARD")) {
				map.put("BOARD_CD", map.get("TMPCLASSNM")); 
			} else if (TMPCLASS.equals("URL")) {
				map.put("URL", map.get("TMPCLASSNM")); 
			}
			resultVale = mapper.update("MenuMapper.saveMenu", map);
			resultVale = mapper.update("MenuMapper.saveConfigSitemap", map);
			System.out.println(map);
			System.out.println(map);
			System.out.println(map);
		}else if(map.get("rowType").equals("D")){
			resultVale = mapper.delete("MenuMapper.deleteMenuAuth", map);	
			resultVale = mapper.delete("MenuMapper.deleteMenu", map);	
			resultVale = mapper.delete("MenuMapper.deleteConfigmap", map);			
		}
		return resultVale;
	}

	@Override
	public List<Map<String, Object>> selectComboList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return mapper.select("MenuMapper.selectComboList", map);
	}
	
}
