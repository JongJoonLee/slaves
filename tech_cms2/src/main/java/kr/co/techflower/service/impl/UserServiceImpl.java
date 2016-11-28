package kr.co.techflower.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.techflower.service.UserService;
import ngel.core.service.AbstractCommonService;

@Service("userService")
public class UserServiceImpl extends AbstractCommonService implements UserService {

	@Override
	public List<Map<String, Object>> doComboList(Map<String, Object> map)
			throws Exception {
		return mapper.selectList("UserMapper.selectUserDivList", map);
	}
	
	@Override
	public List<Map<String, Object>> doSearch(Map<String, Object> map)
			throws Exception {
		return mapper.selectList("UserMapper.selectUserDataNonPagingList", map);
	}

	@Override
	public int doSave(Map<String, Object> map) throws Exception {
		int resultVale = 0;
		if(map.get("USER_ID") != null && !"".equals(map.get("USER_ID"))){
			resultVale += mapper.update("UserMapper.updateUserDataList", map);
			resultVale += mapper.update("UserMapper.updateUserInfoDataList", map);			
		}else{
			return resultVale;
		}
		return resultVale;
	}

}
