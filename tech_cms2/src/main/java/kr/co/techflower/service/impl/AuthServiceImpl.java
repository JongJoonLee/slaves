package kr.co.techflower.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.co.techflower.service.AuthService;
import ngel.core.service.AbstractCommonService;

@Service("authService")
public class AuthServiceImpl extends AbstractCommonService implements AuthService {

	@Override
	public List<Map<String, Object>> doComboList(Map<String, Object> map)
			throws Exception {
		return mapper.selectList("AuthMapper.selectAuthComboList", map);
	}
	
	@Override
	public List<Map<String, Object>> doMenuList(Map<String, Object> map)
			throws Exception {
		return mapper.selectList("AuthMapper.selectMenuList", map);
	}

	@Override
	public List<Map<String, Object>> doMenuInAuthList(Map<String, Object> map)
			throws Exception {
		return mapper.selectList("AuthMapper.selectMenuAuthList", map);
	}

	@Override
	public int doSave(Map<String, Object> map) throws Exception {
		//return mapper.update("AuthMapper.updateAuthList", map);
		
		int vnResultVal = 0;
		Object vsRowType = map.get("rowType");
		System.out.println(map);
		System.out.println(vsRowType+"=======================================================");
		List<Map<String, Object>> boardList = mapper.selectList("AuthMapper.selectBoardCdList", map);
		
		if("D".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			vnResultVal += mapper.delete("AuthMapper.deleteAuthList", map);
			if(null != map.get("MENU_CD") && !"".equals(map.get("MENU_CD"))){
				if(!boardList.isEmpty() && boardList.size() > 0){
					for(int i = 0; i < boardList.size(); i++){
						map.put("BOARD_CD", boardList.get(i).get("BOARD_CD"));
						vnResultVal += mapper.delete("AuthMapper.deleteBoardAuthList", map);
					}
				}
			}
		}else if("U".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			vnResultVal += mapper.update("AuthMapper.updateAuthList", map);
			if(null != map.get("MENU_CD") && !"".equals(map.get("MENU_CD"))){
				if(!boardList.isEmpty() && boardList.size() > 0){
					for(int i = 0; i < boardList.size(); i++){
						map.put("BOARD_CD", boardList.get(i).get("BOARD_CD"));
						vnResultVal += mapper.update("AuthMapper.saveBoardAuthList", map);
					}
				}
			}
		}else if("C".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			Map<String, Object> resMap = mapper.selectOne("AuthMapper.selectOneList", map);
			if(!resMap.isEmpty() && null != resMap.get("CNT")){
				if(Integer.parseInt(String.valueOf(resMap.get("CNT"))) > 0){
					return -1;
				}
			}
			vnResultVal += mapper.insert("AuthMapper.insertAuthList", map);
			if(null != map.get("MENU_CD") && !"".equals(map.get("MENU_CD"))){
				System.out.println(11);
				if(!boardList.isEmpty() && boardList.size() > 0){
					System.out.println(22);
					for(int i = 0; i < boardList.size(); i++){
						System.out.println("응?? :: "+i);
						System.out.println(boardList.get(i));
						map.put("BOARD_CD", boardList.get(i).get("BOARD_CD"));
						vnResultVal += mapper.update("AuthMapper.saveBoardAuthList", map);
					}
				}
			}
		}else{
			return 0;
		}
		return vnResultVal;		
	}

}
