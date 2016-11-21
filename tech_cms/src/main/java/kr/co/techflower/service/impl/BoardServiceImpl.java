package kr.co.techflower.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.security.authentication.encoding.MessageDigestPasswordEncoder;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.co.techflower.service.BoardService;
import ngel.core.service.AbstractCommonService;

@Service("boardService")
public class BoardServiceImpl extends AbstractCommonService implements
		BoardService {

	@Override
	public List<Map<String, Object>> doComboList(Map<String, Object> map)
			throws Exception {
		return mapper.select("BoardMapper.selectBoardComboDataList", map);
	}

	@Override
	public List<Map<String, Object>> doSearchList(Map<String, Object> map)
			throws Exception {
		return mapper.select("BoardMapper.selectBoardDataList", map);
	}

	@Override
	public List<Map<String, Object>> doSearchDetailList(Map<String, Object> map)
			throws Exception {
		return mapper.select("BoardMapper.selectBoardDetailDataList", map) ;
	}
	
	@Override
	public int doSaveList(Map<String, Object> map)
			throws Exception {
		int vnResultVal = 0;
		Object vsRowType = map.get("rowType");
		System.out.println(map);
		if("D".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			vnResultVal += mapper.delete("BoardMapper.deleteBoardDataList", map);
		}else if("U".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			vnResultVal += mapper.update("BoardMapper.updateBoardDataList", map);
		}else if("C".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			MessageDigestPasswordEncoder encoder = new MessageDigestPasswordEncoder("SHA-256");
			String te = encoder.encodePassword("1", null).toUpperCase();
			map.put("PW", te);
			
			//StandardPasswordEncoder encoder = new StandardPasswordEncoder();
			//map.put("PW", encoder.encode("1"));
			vnResultVal += mapper.insert("BoardMapper.insertBoardDataList", map);
		}else{
			return 0;
		}
		return vnResultVal;
	}

	@Override
	public List<Map<String, Object>> doSearchDetailFileList(
			Map<String, Object> map) throws Exception {
		return mapper.select("BoardMapper.selectBoardFileDataList", map) ;
	}

	@Override
	public int doUpdateList(Map<String, Object> map) throws Exception {
		System.out.println(map);
		return mapper.update("BoardMapper.updateBoardDataList", map);
	}

	@Override
	public int doUpdateFile(Map<String, Object> map) throws Exception {
		map.put("SEQ", map.get("BOARD_SEQ"));
		map.put("TBL_PK", map.get("BOARD_SEQ"));
		List<Map<String, Object>> resultList = mapper.select("BoardMapper.selectBoardFileDataList", map) ;
		if(resultList.isEmpty()){
			return mapper.insert("BoardMapper.insertBoardFileDataList", map);
		}else{
			Map<String, Object> resultMap = resultList.get(0);
			map.put("FILE_SEQ", resultMap.get("FILE_SEQ"));
			return mapper.insert("BoardMapper.updateBoardFileDataList", map);
		}
	}

}
