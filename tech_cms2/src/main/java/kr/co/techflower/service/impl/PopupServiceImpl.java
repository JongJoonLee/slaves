package kr.co.techflower.service.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ngel.core.service.AbstractCommonService;

import org.springframework.stereotype.Service;

import kr.co.techflower.service.PopupService;

@Service("popupService")
public class PopupServiceImpl extends AbstractCommonService implements
		PopupService {

	private static final String linkPath = "C:/MEIC/WEBSITE/UploadFiles/";
	//private static final String contextLinkPath = "/resources/uploadFiles/";
	private static final String popupPath = "popup/";
	
	@Override
	public List<Map<String, Object>> doSearchList(Map<String, Object> map)
			throws Exception {
		return mapper.select("PopupMapper.selectPopupDataNonPagingList", map);
	}

	@Override
	public int doSave(Map<String, Object> map) throws Exception {
		int vnResultVal = 0;
		Object vsRowType = map.get("rowType");
		map.put("MENU_CD", "M01");
		if("D".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			System.out.println(map);
			vnResultVal += mapper.delete("PopupMapper.deletePopupData", map);
		}else if("U".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			System.out.println(map);
			vnResultVal += mapper.update("PopupMapper.updatePopupData", map);
		}else if("C".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			System.out.println(map);
			vnResultVal += mapper.insert("PopupMapper.insertPopupData", map);
		}else{
			return 0;
		}
		return vnResultVal;
	}

	@Override
	public int doContentsUpdate(Map<String, Object> map) throws Exception {
		System.out.println(map);
		
		Map<String, Object> fileMap = new HashMap<String, Object>();
		Object contents= map.get("CONTENTS");
		String strContents = ""; 
		if(null != contents){
			strContents = (String)contents;
			int strIdx = strContents.indexOf("resources/uploadFiles/popup/");
			if(strIdx != -1){
				String temp = strContents.substring(strIdx);
				int endIdx = temp.indexOf(".");
				temp = temp.substring(0, endIdx+4);
				strIdx = temp.lastIndexOf("/") + 1;
				String fileName = temp.substring(strIdx, endIdx+4);
				
				File realUploadDir = new File(linkPath+popupPath);
				if (!realUploadDir.exists()) {
					realUploadDir.mkdirs();
				}
				
				if(!"".equals(fileName)){
					String organizedfilePath = linkPath+popupPath+fileName;
					File uploadFile = new File(organizedfilePath);
					
					long vnFileSize = uploadFile.length();
					fileMap.put("SVR_FILE_NM", fileName);
					fileMap.put("FILE_NM", fileName);
					fileMap.put("FILE_SIZE", vnFileSize);
					fileMap.put("TBL_NM", "TB_POPUP");
					fileMap.put("TBL_PK", map.get("POPUP_ID"));
					
					Map<String, Object> resultCnt = mapper.selectOne("PopupMapper.selectPopupFileCnt", fileMap);
					if(!resultCnt.isEmpty()){
						if(Integer.parseInt(String.valueOf(resultCnt.get("CNT"))) > 0){
							//업데이트
							Map<String, Object> reqMap = mapper.selectOne("PopupMapper.selectFileSeqlist", fileMap);
							fileMap.put("FILE_SEQ", reqMap.get("FILE_SEQ"));
							mapper.update("PopupMapper.updatePopupFileList", fileMap);
						}else{
							//신규
							mapper.insert("PopupMapper.insertPopupFileList", fileMap);
						}
					}
				}
			}
		}
		return mapper.update("PopupMapper.updatePopupContents", map);
	}

}
