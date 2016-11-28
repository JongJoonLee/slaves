package kr.co.techflower.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ngel.core.service.AbstractCommonService;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.Region;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.co.techflower.service.SurveyService;

@Service("surveySevice")
public class SurveyServiceImpl extends AbstractCommonService implements SurveyService {

	@Override
	public List<Map<String, Object>> doSearch(Map<String, Object> map)
			throws Exception {
		return mapper.select("SurveyMapper.selectSurveyList", map);
	}

	@Override
	public List<Map<String, Object>> doSearchDetail(Map<String, Object> map)
			throws Exception {
		return mapper.select("SurveyMapper.selectSurveyDetailList", map);
	}
	
	@Override
	public List<Map<String, Object>> doSearchDetailExcample(
			Map<String, Object> map) throws Exception {
		return mapper.select("SurveyMapper.selectSurveyDetailExampleList", map);
	}

	@Override
	public int doSave(Map<String, Object> map) throws Exception {
		int vnResultVal = 0;
		Object vsRowType = map.get("rowType");
		if("D".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			System.out.println(map);
			vnResultVal += mapper.delete("SurveyMapper.deleteSurveyList", map);
		}else if("U".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			System.out.println(map);
			vnResultVal += mapper.update("SurveyMapper.updateSurveyList", map);
		}else if("C".equals(vsRowType)){
			System.out.println(vsRowType + " 입니다.");
			System.out.println(map);
			vnResultVal += mapper.insert("SurveyMapper.insertSurveyList", map);
		}else{
			return 0;
		}
		return vnResultVal;
	}

	@Override
	public int doSaveDetail(Map<String, Object> map) throws Exception {
		return 0;
	}

	/**
	 * 설문지 상세 설정 해당 항목만 삭제
	 */
	@Override
	public int doDeleteJustOne(Map<String, Object> map) throws Exception {
		int result = 0;
		if(!"".equals(map.get("SURVEY_ID")) && !"".equals(map.get("SURVEY_DID"))){
			Map<String, Object> resMap = mapper.selectOne("SurveyMapper.selectSurveyDetailList", map);
			if(!resMap.isEmpty()){
				System.out.println(resMap.get("SURVEY_NO"));
				System.out.println(resMap.get("SURVEY_DNO"));
				//해당 SURVEY_NO, SURVEY_DNO 을 바탕으로 대상 조회
				
				//--------------------------------------------------------------------------
				//0. 삭제하고자 하는 항목의 대문항 번호가 자기 자신 뿐이라면 
				List<Map<String, Object>> returnListZero = mapper.selectList("SurveysaveMapper.selectDetailZeroList", resMap);
				
				if(returnListZero.isEmpty()){
					return 0;
				}else if(!returnListZero.isEmpty() && returnListZero.size() == 1){
					//자신과 EXAMPLE 테이블의 데이터만  지운다.
					result += mapper.update("SurveysaveMapper.deleteCaseZeroMe", resMap);
					result += mapper.update("SurveysaveMapper.deleteChildAll", resMap);
					//자신보다 높은 대문항의 값들을 모두 -1 해준다.
					result += mapper.update("SurveysaveMapper.deleteCaseZero", resMap);
				}else if(!returnListZero.isEmpty() && returnListZero.size() > 1){
					//대문항 번호가 같고, 소문항이 여러개 존재 한다면
					
					//1-1. 삭제하고자 하는 항목의 소문항번호가 더 높은 후속 항목이 있다면 후속 소문항 항목의 번호를 모두 -1 로 update
					List<Map<String, Object>> returnList = mapper.selectList("SurveysaveMapper.selectDetailOneList", resMap);
					//나보다 큰 소문항을 가진 동일레벨의 대문항을 가진 항목이 있다면
					if(!returnList.isEmpty() && returnList.size() > 0){
						//1-1. 삭제하고자 하는 항목의 소문항번호가 더 높은 후속 항목이 있다면
						//자기자식과 자신을 삭제
						result = mapper.update("SurveysaveMapper.deleteCaseOneMe", resMap);
						result += mapper.update("SurveysaveMapper.deleteChildAll", resMap);
						
						//후속 소문항 항목의 번호를 모두 -1 로 update
						result = mapper.update("SurveysaveMapper.deleteCaseOne", resMap);
					}else{
						result = mapper.update("SurveysaveMapper.deleteCaseOneMe", resMap);
						result += mapper.update("SurveysaveMapper.deleteChildAll", resMap);
					}
				}				
			}else{
				return 0;
			}
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> goSurveyPopup(Map<String, Object> map,
			Model model) throws Exception {
		model.addAttribute("surveyId", map.get("SURVEY_ID"));
		model.addAttribute("surveyDId", map.get("SURVEY_DID"));
		model.addAttribute("SURVEY_ID", map.get("SURVEY_ID"));
		model.addAttribute("SURVEY_DID", map.get("SURVEY_DID"));
		List<Map<String, Object>> dataList = mapper.select("SurveyMapper.selectSurveyDetailList", map);
		
		if(!dataList.isEmpty() && dataList.size() > 0){
			model.addAttribute("SURVEY_NO", dataList.get(0).get("SURVEY_NO"));
			model.addAttribute("SURVEY_DNO", dataList.get(0).get("SURVEY_DNO"));
			for(int i = 0; i < dataList.size(); i++){
				dataList.get(i).put("exampleList", mapper.select("SurveyMapper.selectSurveyDetailExampleList", dataList.get(i)));
			}
		}
		model.addAttribute("detailList", dataList);
		return dataList;
	}

	@Override
	public List<Map<String, Object>> popupBefInsert(Map<String, Object> map,
			Model model) throws Exception {
		List<Map<String, Object>> resList = new ArrayList<Map<String,Object>>();
		Map<String, Object> resMap = new HashMap<String, Object>();
		model.addAttribute("STATUS", "BI");
		/**
		 * 
			======================================================================
			이전 추가는 현재 문항을 따라간다.
			
			1. 현재 문항이 x.0 이라면 이전 문항을 확인
 			-> x-1.0 or x-1.y-1 선택 가능
			2. 현재 문항이 x.1 이상의 소문항 이라면 소문항만 추가
			======================================================================
		 */
		List<Map<String, Object>> dataList = mapper.select("SurveyMapper.selectSurveyDetailList", map);
		int vnDno = 0;
		if(!dataList.isEmpty() && dataList.size() > 0){
			model.addAttribute("SURVEY_NO", dataList.get(0).get("SURVEY_NO"));
			model.addAttribute("SURVEY_DNO", dataList.get(0).get("SURVEY_DNO"));
			if(!"".equals(dataList.get(0).get("SURVEY_DNO")) && null != dataList.get(0).get("SURVEY_DNO")){
				vnDno = Integer.parseInt(String.valueOf(dataList.get(0).get("SURVEY_DNO")));
			}
			if(vnDno > 0){
				//현재 문항이 이전문항이 된다. 
				//나중에 저장을 하게 된다면 해당 항목을 저장하기 이전에 해당 항목의 이후 소문항을 모두 +1 해준다.
				resMap.put("LABEL", "소문항 추가");
				resMap.put("NO", dataList.get(0).get("SURVEY_NO"));
				resMap.put("DNO", dataList.get(0).get("SURVEY_DNO"));
				resList.add(resMap);
			}else{
				if("1".equals(dataList.get(0).get("SURVEY_NO").toString())){
					resMap.put("LABEL", "대문항 추가");
					resMap.put("NO", 1);
					resMap.put("DNO", 0);
					resList.add(resMap);
				}else{
					//현재 문항이 x.0 이 된다.
					//이는 이전 항목에 소문항이 있을 경우 이전 소문항 +1 or 현재 대문항.0 이 된다.
					//사항은 유저 몫으로 남긴다.
					Map<String, Object> reqMap = new HashMap<String, Object>();
					reqMap.put("SURVEY_NO", Integer.parseInt(String.valueOf(dataList.get(0).get("SURVEY_NO")))-1);
					reqMap.put("SURVEY_ID", map.get("SURVEY_ID"));
					List<Map<String, Object>> list = mapper.selectList("SurveysaveMapper.selectMaxSmallList", reqMap);
					
					resMap = new HashMap<String, Object>();
					resMap.put("LABEL", "소문항 추가");
					resMap.put("NO", list.get(0).get("SURVEY_NO"));
					resMap.put("DNO", Integer.parseInt(String.valueOf(list.get(0).get("SURVEY_DNO")))+1);
					resList.add(resMap);
					
					resMap = new HashMap<String, Object>();
					resMap.put("LABEL", "대문항 추가");
					resMap.put("NO", dataList.get(0).get("SURVEY_NO"));
					resMap.put("DNO", dataList.get(0).get("SURVEY_DNO"));
					resList.add(resMap);
				}
			}
			model.addAttribute("selList", resList);
		}
		return resList;
	}

	@Override
	public List<Map<String, Object>> popupAftInsert(Map<String, Object> map,
			Model model) throws Exception {
		List<Map<String, Object>> resList = new ArrayList<Map<String,Object>>();
		Map<String, Object> resMap = new HashMap<String, Object>();
		model.addAttribute("STATUS", "AI");
		/**
		 * 
			======================================================================
			이전 추가는 현재 문항을 따라간다.
			-> x.y+1 or x+1.0 선택 가능
			======================================================================
		 */
		List<Map<String, Object>> dataList = mapper.select("SurveyMapper.selectSurveyDetailList", map);
		//int vnDno = 0;
		if(!dataList.isEmpty() && dataList.size() > 0){
			model.addAttribute("SURVEY_NO", dataList.get(0).get("SURVEY_NO"));
			model.addAttribute("SURVEY_DNO", dataList.get(0).get("SURVEY_DNO"));
			if(!"".equals(dataList.get(0).get("SURVEY_DNO")) && null != dataList.get(0).get("SURVEY_DNO")){
				//vnDno = Integer.parseInt(String.valueOf(dataList.get(0).get("SURVEY_DNO")));
				
				resMap = new HashMap<String, Object>();
				resMap.put("LABEL", "소문항 추가");
				resMap.put("NO", dataList.get(0).get("SURVEY_NO"));
				resMap.put("DNO", Integer.parseInt(String.valueOf(dataList.get(0).get("SURVEY_DNO")))+1);
				resList.add(resMap);
				
				resMap = new HashMap<String, Object>();
				resMap.put("LABEL", "대문항 추가");
				resMap.put("NO", Integer.parseInt(String.valueOf(dataList.get(0).get("SURVEY_NO")))+1);
				resMap.put("DNO", 0);
				resList.add(resMap);
			}
			model.addAttribute("selList", resList);
		}
		return resList;
	}

	@Override
	public List<Map<String, Object>> popupInsert(Map<String, Object> map,
			Model model) throws Exception {
		List<Map<String, Object>> resList = new ArrayList<Map<String,Object>>();
		Map<String, Object> resMap = new HashMap<String, Object>();
		model.addAttribute("STATUS", "LI");
		/**
		 * 
			======================================================================
			마지막 추가는 제일 마지막 항목을 따라간다.
			
			1. 제일 마지막 문항의 대문항 번호 x+1.0 or 제일 마지막 문항의 소문항 번호 x.y+1 선택가능
			2. 데이터가 없다면 1.0 
			======================================================================
		 */
		List<Map<String, Object>> dataList = mapper.select("SurveyMapper.selectSurveyDetailMaxNoList", map);
		if(!dataList.isEmpty() && dataList.size() > 0){
			model.addAttribute("SURVEY_NO", "");
			model.addAttribute("SURVEY_DNO", "");
							
			resMap = new HashMap<String, Object>();
			resMap.put("LABEL", "소문항 추가");
			resMap.put("NO", dataList.get(0).get("SURVEY_NO"));
			resMap.put("DNO", Integer.parseInt(String.valueOf(dataList.get(0).get("SURVEY_DNO")))+1);
			resList.add(resMap);
				
			resMap = new HashMap<String, Object>();
			resMap.put("LABEL", "대문항 추가");
			resMap.put("NO", Integer.parseInt(String.valueOf(dataList.get(0).get("SURVEY_NO")))+1);
			resMap.put("DNO", 0);
			resList.add(resMap);
			
			model.addAttribute("selList", resList);
		}else{
			model.addAttribute("SURVEY_NO", 1);
			model.addAttribute("SURVEY_DNO", 0);
			
			resMap = new HashMap<String, Object>();
			resMap.put("LABEL", "대문항 추가");
			resMap.put("NO", 1);
			resMap.put("DNO", 0);
			resList.add(resMap);
			
			model.addAttribute("selList", resList);
		}
		return resList;
	}

	@Override
	public List<Map<String, Object>> popupUpdate(Map<String, Object> map,
			Model model) throws Exception {
		model.addAttribute("surveyId", map.get("SURVEY_ID"));
		model.addAttribute("surveyDId", map.get("SURVEY_DID"));
		model.addAttribute("SURVEY_ID", map.get("SURVEY_ID"));
		model.addAttribute("SURVEY_DID", map.get("SURVEY_DID"));
		model.addAttribute("STATUS", "U");
		List<Map<String, Object>> dataList = mapper.select("SurveyMapper.selectSurveyDetailList", map);
		
		if(!dataList.isEmpty() && dataList.size() > 0){
			model.addAttribute("SURVEY_NO", dataList.get(0).get("SURVEY_NO"));
			model.addAttribute("SURVEY_DNO", dataList.get(0).get("SURVEY_DNO"));
			for(int i = 0; i < dataList.size(); i++){
				dataList.get(i).put("exampleList", mapper.select("SurveyMapper.selectSurveyDetailExampleList", dataList.get(i)));
			}
		}
		model.addAttribute("detailList", dataList);
		return dataList;
	}

	@Override
	public int doInsertBefDetail(Map<String, Object> map) throws Exception {
		int result = 0;
		if(null == map.get("SURVEY_ID") || "".equals(map.get("SURVEY_ID"))){
			return result;
		}
		
		int vnCnt = Integer.parseInt(String.valueOf(map.get("COUNT")));
		int vnSmallNum = Integer.parseInt(String.valueOf(map.get("SURVEY_DNO")));
		
		if(vnSmallNum == 0){
			result += mapper.update("SurveysaveMapper.updateBefInsertOriginBigData", map);
		}else if(vnSmallNum > 0){
			result += mapper.update("SurveysaveMapper.updateBefInsertOriginSmallData", map);
		}else {
			return result;
		}
		
		if("MO".equals(map.get("SURVEY_TYPE"))){
			//TB_SURVEY_DETAIL 추가
			result += mapper.insert("SurveysaveMapper.insertLastInsertDetail", map);
			
			//생성된 SURVEY_DID 를 조회
			Map<String, Object> keyMap = mapper.selectOne("SurveysaveMapper.selectMaxNewDataDetail", map);
			
			//해당 SURVEY_DID, SURVEY_ID 값을 이용하여 COUNT 만큼 TB_SURVEY_DETAIL_EXAMPLE 에 보기를 추가
			if(vnCnt > 0){
				map.put("SURVEY_DID", keyMap.get("SURVEY_DID"));
				for(int i = 0; i < vnCnt; i++){
					map.put("SURVEY_DE_NO", i+1);
					map.put("SURVEY_CONTENT", map.get("ipbAns"+(i+1)));
					result += mapper.insert("SurveysaveMapper.insertTbSurveyDetailExampleInData", map);
				}
			}
		}else if("S".equals(map.get("SURVEY_TYPE"))){
			//TB_SURVEY_DETAIL 추가
			result += mapper.insert("SurveysaveMapper.insertLastInsertDetail", map);
				
			//생성된 SURVEY_DID 를 조회
			Map<String, Object> keyMap = mapper.selectOne("SurveysaveMapper.selectMaxNewDataDetail", map);
				
			//주관식 이기 때문에 보기 번호를 1로 하여 보기 하나만 생성
			map.put("SURVEY_DID", keyMap.get("SURVEY_DID"));
			map.put("SURVEY_DE_NO", 1);
			result += mapper.insert("SurveysaveMapper.insertTbSurveyDetailExampleInData", map);
		}else if("MM".equals(map.get("SURVEY_TYPE"))){
			//TB_SURVEY_DETAIL 추가
			result += mapper.insert("SurveysaveMapper.insertLastInsertDetail", map);
			
			//생성된 SURVEY_DID 를 조회
			Map<String, Object> keyMap = mapper.selectOne("SurveysaveMapper.selectMaxNewDataDetail", map);
			
			//해당 SURVEY_DID, SURVEY_ID 값을 이용하여 COUNT 만큼 TB_SURVEY_DETAIL_EXAMPLE 에 보기를 추가
			if(vnCnt > 0){
				map.put("SURVEY_DID", keyMap.get("SURVEY_DID"));
				for(int i = 0; i < vnCnt; i++){
					map.put("SURVEY_DE_NO", i+1);
					map.put("SURVEY_CONTENT", map.get("ipbMulAns"+(i+1)));
					result += mapper.insert("SurveysaveMapper.insertTbSurveyDetailExampleInData", map);
				}	
			}
		}
		return result;
	}

	@Override
	public int doInsertAftDetail(Map<String, Object> map) throws Exception {
		int result = 0;
		if(null == map.get("SURVEY_ID") || "".equals(map.get("SURVEY_ID"))){
			return result;
		}
		
		int vnCnt = Integer.parseInt(String.valueOf(map.get("COUNT")));
		int vnSmallNum = Integer.parseInt(String.valueOf(map.get("SURVEY_DNO")));
		
		if(vnSmallNum == 0){
			result += mapper.update("SurveysaveMapper.updateAftInsertOriginBigData", map);
		}else if(vnSmallNum > 0){
			result += mapper.update("SurveysaveMapper.updateAftInsertOriginSmallData", map);
		}else {
			return result;
		}
		
		if("MO".equals(map.get("SURVEY_TYPE"))){
			//TB_SURVEY_DETAIL 추가
			result += mapper.insert("SurveysaveMapper.insertLastInsertDetail", map);
			
			//생성된 SURVEY_DID 를 조회
			Map<String, Object> keyMap = mapper.selectOne("SurveysaveMapper.selectMaxNewDataDetail", map);
			
			//해당 SURVEY_DID, SURVEY_ID 값을 이용하여 COUNT 만큼 TB_SURVEY_DETAIL_EXAMPLE 에 보기를 추가
			if(vnCnt > 0){
				map.put("SURVEY_DID", keyMap.get("SURVEY_DID"));
				for(int i = 0; i < vnCnt; i++){
					map.put("SURVEY_DE_NO", i+1);
					map.put("SURVEY_CONTENT", map.get("ipbAns"+(i+1)));
					result += mapper.insert("SurveysaveMapper.insertTbSurveyDetailExampleInData", map);
				}	
			}
		}else if("S".equals(map.get("SURVEY_TYPE"))){
			//TB_SURVEY_DETAIL 추가
			result += mapper.insert("SurveysaveMapper.insertLastInsertDetail", map);
			
			//생성된 SURVEY_DID 를 조회
			Map<String, Object> keyMap = mapper.selectOne("SurveysaveMapper.selectMaxNewDataDetail", map);
			
			//주관식 이기 때문에 보기 번호를 1로 하여 보기 하나만 생성
			map.put("SURVEY_DID", keyMap.get("SURVEY_DID"));
			map.put("SURVEY_DE_NO", 1);
			result += mapper.insert("SurveysaveMapper.insertTbSurveyDetailExampleInData", map);
		}else if("MM".equals(map.get("SURVEY_TYPE"))){
			//TB_SURVEY_DETAIL 추가
			result += mapper.insert("SurveysaveMapper.insertLastInsertDetail", map);
			
			//생성된 SURVEY_DID 를 조회
			Map<String, Object> keyMap = mapper.selectOne("SurveysaveMapper.selectMaxNewDataDetail", map);
			
			//해당 SURVEY_DID, SURVEY_ID 값을 이용하여 COUNT 만큼 TB_SURVEY_DETAIL_EXAMPLE 에 보기를 추가
			if(vnCnt > 0){
				map.put("SURVEY_DID", keyMap.get("SURVEY_DID"));
				for(int i = 0; i < vnCnt; i++){
					map.put("SURVEY_DE_NO", i+1);
					map.put("SURVEY_CONTENT", map.get("ipbMulAns"+(i+1)));
					result += mapper.insert("SurveysaveMapper.insertTbSurveyDetailExampleInData", map);
				}	
			}
		}
		
		return result;
	}

	@Override
	public int doInsertLastDetail(Map<String, Object> map) throws Exception {
		int result = 0;
		if(null == map.get("SURVEY_ID") || "".equals(map.get("SURVEY_ID"))){
			return result;
		}
		
		int vnCnt = Integer.parseInt(String.valueOf(map.get("COUNT")));
		if("MO".equals(map.get("SURVEY_TYPE"))){
			//TB_SURVEY_DETAIL 추가
			result += mapper.insert("SurveysaveMapper.insertLastInsertDetail", map);
			
			//생성된 SURVEY_DID 를 조회
			Map<String, Object> keyMap = mapper.selectOne("SurveysaveMapper.selectMaxNewDataDetail", map);
			
			//해당 SURVEY_DID, SURVEY_ID 값을 이용하여 COUNT 만큼 TB_SURVEY_DETAIL_EXAMPLE 에 보기를 추가
			if(vnCnt > 0){
				map.put("SURVEY_DID", keyMap.get("SURVEY_DID"));
				for(int i = 0; i < vnCnt; i++){
					map.put("SURVEY_DE_NO", i+1);
					map.put("SURVEY_CONTENT", map.get("ipbAns"+(i+1)));
					result += mapper.insert("SurveysaveMapper.insertTbSurveyDetailExampleInData", map);
				}	
			}
		}else if("S".equals(map.get("SURVEY_TYPE"))){
			//TB_SURVEY_DETAIL 추가
			result += mapper.insert("SurveysaveMapper.insertLastInsertDetail", map);
			
			//생성된 SURVEY_DID 를 조회
			Map<String, Object> keyMap = mapper.selectOne("SurveysaveMapper.selectMaxNewDataDetail", map);
			
			//주관식 이기 때문에 보기 번호를 1로 하여 보기 하나만 생성
			map.put("SURVEY_DID", keyMap.get("SURVEY_DID"));
			map.put("SURVEY_DE_NO", 1);
			result += mapper.insert("SurveysaveMapper.insertTbSurveyDetailExampleInData", map);
		}else if("MM".equals(map.get("SURVEY_TYPE"))){
			//TB_SURVEY_DETAIL 추가
			result += mapper.insert("SurveysaveMapper.insertLastInsertDetail", map);
			
			//생성된 SURVEY_DID 를 조회
			Map<String, Object> keyMap = mapper.selectOne("SurveysaveMapper.selectMaxNewDataDetail", map);
			
			//해당 SURVEY_DID, SURVEY_ID 값을 이용하여 COUNT 만큼 TB_SURVEY_DETAIL_EXAMPLE 에 보기를 추가
			if(vnCnt > 0){
				map.put("SURVEY_DID", keyMap.get("SURVEY_DID"));
				for(int i = 0; i < vnCnt; i++){
					map.put("SURVEY_DE_NO", i+1);
					map.put("SURVEY_CONTENT", map.get("ipbMulAns"+(i+1)));
					result += mapper.insert("SurveysaveMapper.insertTbSurveyDetailExampleInData", map);
				}	
			}
		}else{
			return result;
		}
		return result;
	}

	@Override
	public int doUpdateDetail(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> originList = mapper.selectList("SurveysaveMapper.selectOriginData", map);
		int result = 0;
		//데이터 수정만 하기 때문에 대문항, 소문항 번호에 대한 수정은 없다.
		if(originList.isEmpty() || null == originList){
			return result;
		}else{
			String orgType = (String)originList.get(0).get("SURVEY_TYPE");
			if(orgType.equals(map.get("SURVEY_TYPE"))){
				//같은 타입이라면 굳이 데이터를 삭제하지 않아도 된다.
				//TB_SURVEY_DETAIL_EXAMPLE 에 있는 기존 데이터 보다 신규 데이터가 많다면 추가로 등록
				//TB_SURVEY_DETAIL_EXAMPLE 에 있는 기존 데이터 보다 신규 데이터가 적다면 COUNT 를 많은 항목을 삭제처리
				//같다면 주관식일 경우 PASS, 객관형 일 경우 SURVEY_CONTENT 만 수정
				if("S".equals(map.get("SURVEY_TYPE"))){
					result += mapper.update("SurveysaveMapper.updateTbSurveyDetailContent", map);
				}else if("MO".equals(map.get("SURVEY_TYPE")) || "MM".equals(map.get("SURVEY_TYPE"))){
					List<Map<String, Object>> resultList = mapper.selectList("SurveysaveMapper.selectTbSurveyDetailExampleList", map);
					if(resultList.isEmpty() || null == resultList){
						return result;
					}
					int vnUpdateCnt = Integer.parseInt(String.valueOf(map.get("COUNT")));
					int vnOriginCnt = resultList.size();
					if(vnUpdateCnt == vnOriginCnt){
						result += mapper.update("SurveysaveMapper.updateTbSurveyDetailContent", map);
						if("MO".equals(map.get("SURVEY_TYPE"))){
							for(int i = 0; i < vnUpdateCnt; i++){
								map.put("E_SURVEY_CONTENT", map.get("ipbAns"+(i+1)));
								map.put("SURVEY_DE_ID", map.get("hidden"+(i+1)));
								result += mapper.update("SurveysaveMapper.updateTbSurveyDetailExampleEqu", map);
							}
						}else{
							for(int i = 0; i < vnUpdateCnt; i++){
								map.put("E_SURVEY_CONTENT", map.get("ipbMulAns"+(i+1)));
								map.put("SURVEY_DE_ID", map.get("hiddenMul"+(i+1)));
								result += mapper.update("SurveysaveMapper.updateTbSurveyDetailExampleEqu", map);
							}
						}
					}else if(vnUpdateCnt > vnOriginCnt){
						result += mapper.update("SurveysaveMapper.updateTbSurveyDetailContent", map);
						//수정 항목이 기존 항목보다 많을 경우
						//SURVEY_DE_ID 의 값이 있을 경우 데이터 수정
						//SURVEY_DE_ID 의 값이 null 인 항목만 추가로 등록 해준다.
						if("MO".equals(map.get("SURVEY_TYPE"))){
							for(int i = 0; i < vnUpdateCnt; i++){
								if("".equals(map.get("hidden"+(i+1))) || null == map.get("hidden"+(i+1))){
									// 신규 등록
									map.put("E_SURVEY_CONTENT", map.get("ipbAns"+(i+1)));
									result += mapper.insert("SurveysaveMapper.insertTbSurveyDetailExample", map);
								}else{
									map.put("E_SURVEY_CONTENT", map.get("ipbAns"+(i+1)));
									map.put("SURVEY_DE_ID", map.get("hidden"+(i+1)));
									result += mapper.update("SurveysaveMapper.updateTbSurveyDetailExampleEqu", map);
								}
							}
						}else{
							for(int i = 0; i < vnUpdateCnt; i++){
								if("".equals(map.get("hiddenMul"+(i+1))) || null == map.get("hiddenMul"+(i+1))){
									// 신규 등록
									map.put("E_SURVEY_CONTENT", map.get("ipbMulAns"+(i+1)));
									result += mapper.insert("SurveysaveMapper.insertTbSurveyDetailExample", map);
								}else{
									map.put("E_SURVEY_CONTENT", map.get("ipbMulAns"+(i+1)));
									map.put("SURVEY_DE_ID", map.get("hiddenMul"+(i+1)));
									result += mapper.update("SurveysaveMapper.updateTbSurveyDetailExampleEqu", map);
								}
							}
						}
					}else if(vnUpdateCnt < vnOriginCnt){
						//수정 항목이 기존 항목보다 적을 경우
						//넘어오지 않은 데이터를 삭제처리
						//넘어온 데이터는 수정 처리
						result += mapper.update("SurveysaveMapper.updateTbSurveyDetailContent", map);
						if("MO".equals(map.get("SURVEY_TYPE"))){
							List<Object> list = new ArrayList<Object>();
							Map<String, Object> reqMap = new HashMap<String, Object>();
							for(int i = 0; i < vnUpdateCnt; i++){
								reqMap = new HashMap<String, Object>();
								reqMap.put("SURVEY_DE_ID", map.get("hidden"+(i+1)));
								list.add(reqMap);
							}
							map.put("list", list);
							List<Map<String, Object>> notDeIdList = mapper.selectList("SurveysaveMapper.selectTbSurveyDetailExampleNotList", map);
							if(!notDeIdList.isEmpty() && null != notDeIdList){
								for(int j = 0; j < notDeIdList.size(); j++){
									result += mapper.update("SurveysaveMapper.deleteTbSurveyDetailExample", notDeIdList.get(j));
								}
							}
							for(int i = 0; i < vnUpdateCnt; i++){
								map.put("E_SURVEY_CONTENT", map.get("ipbAns"+(i+1)));
								map.put("SURVEY_DE_ID", map.get("hidden"+(i+1)));
								result += mapper.update("SurveysaveMapper.updateTbSurveyDetailExampleEqu", map);
							}
						}else{
							List<Object> list = new ArrayList<Object>();
							Map<String, Object> reqMap = new HashMap<String, Object>();
							for(int i = 0; i < vnUpdateCnt; i++){
								reqMap = new HashMap<String, Object>();
								reqMap.put("SURVEY_DE_ID", map.get("hiddenMul"+(i+1)));
								list.add(reqMap);
							}
							map.put("list", list);
							List<Map<String, Object>> notDeIdList = mapper.selectList("SurveysaveMapper.selectTbSurveyDetailExampleNotList", map);
							if(!notDeIdList.isEmpty() && null != notDeIdList){
								for(int j = 0; j < notDeIdList.size(); j++){
									result += mapper.update("SurveysaveMapper.deleteTbSurveyDetailExample", notDeIdList.get(j));
								}
							}
							for(int i = 0; i < vnUpdateCnt; i++){
								map.put("E_SURVEY_CONTENT", map.get("ipbMulAns"+(i+1)));
								map.put("SURVEY_DE_ID", map.get("hiddenMul"+(i+1)));
								result += mapper.update("SurveysaveMapper.updateTbSurveyDetailExampleEqu", map);
							}
						}
					}
				}else{
					return result;
				}
			}else{
				//다른 타입이라면 기존에 등록되어 있는 TB_SURVEY_DETAIL_EXAMPLE 를 모두 삭제처리 하고 재등록 한다.
				//TYPE 변경
				result += mapper.update("SurveysaveMapper.updateTbSurveyDetailTypeAndContent", map);
				
				//보기항목 모두 삭제처리
				result += mapper.update("SurveysaveMapper.deleteTbSurveyDetailExampleFilter", map);
				
				if("S".equals(map.get("SURVEY_TYPE"))){
					//주관식 항목 하나만 신규 등록
					
				}else if("MO".equals(map.get("SURVEY_TYPE")) || "MM".equals(map.get("SURVEY_TYPE"))){
					int vnUpdateCnt = Integer.parseInt(String.valueOf(map.get("COUNT")));
					for(int i = 0; i < vnUpdateCnt; i++){
						//등록된 보기항목 만큼 신규 등록
						if("MO".equals(map.get("SURVEY_TYPE"))){
							map.put("SURVEY_CONTENT", map.get("ipbAns"+(i+1)));
						}else if("MM".equals(map.get("SURVEY_TYPE"))){
							map.put("SURVEY_CONTENT", map.get("ipbMulAns"+(i+1)));
						}
						map.put("SURVEY_DE_NO",i+1);
						result += mapper.insert("SurveysaveMapper.insertTbSurveyDetailExampleInData", map);
					}
				}
			}
		}
		return result;
	}

	@Override
	public int doDeleteAllDetail(Map<String, Object> map) throws Exception {
		int result = 0;
		if(null != map.get("SURVEY_ID") || !"".equals(map.get("SURVEY_ID"))){
			result += mapper.update("SurveysaveMapper.deleteTbSurveyDetailExampleAll", map);
			result += mapper.update("SurveysaveMapper.deleteTbSurveyDetailAll", map);
		}		
		return result;
	}

	@Override
	public Map<String, Object> doExcelDown(List<Map<String, Object>> list) throws Exception {
		Map<String, Object> reqMap = null;
		Map<String, Object> resMap = null;
		Map<String, Object> tbUserDetailMap = null;
		List<Map<String, Object>> tbUserInsertDatelList = null;
		
		if(!list.isEmpty() && list.size() > 0){
			
			Workbook workBook = new HSSFWorkbook();
			HSSFSheet sheet;
			
			for(int i = 0; i < list.size(); i++){
				reqMap = new HashMap<String, Object>();
				tbUserDetailMap = new HashMap<String, Object>();
				tbUserInsertDatelList = new ArrayList<Map<String, Object>>();
				
				//시트정보
				reqMap = mapper.selectOne("SurveyMapper.selectSurveyList", list.get(i));
				//총 응답 인구와 설문작성 사용자 명단 확보
				tbUserDetailMap = mapper.selectOne("SurveyMapper.selectCntUserResultList", list.get(i));
				//총 응답 인구의 작성 사용자 명단 및 작성시간 확보
				tbUserInsertDatelList = mapper.selectList("SurveyMapper.selectUserResultInsertList", list.get(i));
				
				//조회된 정보를 토대로 엑셀 파일을 생성 하면서 시트를 완성해 나간다.
				sheet = (HSSFSheet) workBook.createSheet((String)reqMap.get("SURVEY_NM"));
				Row row = sheet.createRow(0);
				row.setHeightInPoints(25);
				Cell cell = row.createCell(0);
				cell.setCellValue("설문 제목");
				cell.setCellStyle(RowFilledWithHeaderStyle(workBook, sheet, row));
				
				Cell cell1 = row.createCell(1);
				cell1.setCellValue("설문 설명");
				cell1.setCellStyle(RowFilledWithHeaderStyle(workBook, sheet, row));
				
				Cell cell2 = row.createCell(2);
				cell2.setCellValue("설문 대상");
				cell2.setCellStyle(RowFilledWithHeaderStyle(workBook, sheet, row));
								
				Cell cell3 = row.createCell(3);
				cell3.setCellValue("설문 시작일자");
				cell3.setCellStyle(RowFilledWithHeaderStyle(workBook, sheet, row));
				
				Cell cell4 = row.createCell(4);
				cell4.setCellValue("설문 종료일자");
				cell4.setCellStyle(RowFilledWithHeaderStyle(workBook, sheet, row));
				
				Cell cell5 = row.createCell(5);
				cell5.setCellValue("설문 작성 인구");
				cell5.setCellStyle(RowFilledWithHeaderStyle(workBook, sheet, row));
				
				Cell cell6 = row.createCell(6);
				cell6.setCellValue("설문 작성자 목록");
				cell6.setCellStyle(RowFilledWithHeaderStyle(workBook, sheet, row));
				
				Row row1 = sheet.createRow(1);
				row1.setHeightInPoints(25);
				
				Cell cellOne = row1.createCell(0);
				cellOne.setCellValue(String.valueOf(reqMap.get("SURVEY_NM")));
				cellOne.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
				
				Cell cellOne1 = row1.createCell(1);
				cellOne1.setCellValue(String.valueOf(reqMap.get("SURVEY_CONT")));
				cellOne1.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
				
				Cell cellOne2 = row1.createCell(2);
				cellOne2.setCellValue(String.valueOf(reqMap.get("SURVEY_TARGET")));
				cellOne2.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
								
				Cell cellOne3 = row1.createCell(3);
				cellOne3.setCellValue(String.valueOf(reqMap.get("SURVEY_STARTDT")));
				cellOne3.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
				
				Cell cellOne4 = row1.createCell(4);
				cellOne4.setCellValue(String.valueOf(reqMap.get("SURVEY_ENDDT")));
				cellOne4.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
				
				Cell cellOne5 = row1.createCell(5);
				cellOne5.setCellValue(String.valueOf(tbUserDetailMap.get("CNT")) + " 명");
				cellOne5.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
				
				Cell cellOne6 = row1.createCell(6);
				cellOne6.setCellValue(String.valueOf(tbUserDetailMap.get("USER_NMS")));
				cellOne6.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
				
				Row rowQuestOne = sheet.createRow(3);
				rowQuestOne.setHeightInPoints(25);
				
				Cell cellQuestOne1 = rowQuestOne.createCell(0);
				cellQuestOne1.setCellValue("설문 작성자");
				cellQuestOne1.setCellStyle(RowFilledWithHeaderStyle(workBook, sheet, row));
				
				Cell cellQuestOne2 = rowQuestOne.createCell(1);
				cellQuestOne2.setCellValue("설문 작성 시간");
				cellQuestOne2.setCellStyle(RowFilledWithHeaderStyle(workBook, sheet, row));
				
				int initNum = 4;
				
				if(!tbUserInsertDatelList.isEmpty() && tbUserInsertDatelList.size() > 0){
					Row rowQuestUserList = null; 
					Cell cellQuestUserList = null;
					Cell cellQuestInsertList = null;
					for(int z = 0; z < tbUserInsertDatelList.size(); z++){
						rowQuestUserList = sheet.createRow(initNum+z);
						rowQuestUserList.setHeightInPoints(25);
						
						cellQuestUserList = rowQuestUserList.createCell(0);
						cellQuestUserList.setCellValue(String.valueOf(tbUserInsertDatelList.get(z).get("SURVEY_USER_ID")));
						cellQuestUserList.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
						
						cellQuestInsertList = rowQuestUserList.createCell(1);
						cellQuestInsertList.setCellValue(String.valueOf(tbUserInsertDatelList.get(z).get("INS_DATE")));
						cellQuestInsertList.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
					}
					initNum = initNum + (tbUserInsertDatelList.size()+3);
				}else{
					initNum = initNum + 4;
				}
				
				//sheet.addMergedRegion(new Region(0, (short)0, 1, (short)0));
				/**
				 * 실질적 설문 문항과 보기자료를 보여주면서 count 값을 엑셀에 그려주는 부분
				 */
				//문항값 조회
				/*List<Map<String, Object>> bogiList = mapper.selectList("SurveyMapper.selectSurveyDetailAllList", list.get(i));
				if(!bogiList.isEmpty() && bogiList.size() > 0){
					Row rowQuestList = null; 
					Cell cellQuestList = null;
					for(int o = 0; o < bogiList.size(); o++){
						rowQuestList = sheet.createRow(initNum+o);
						rowQuestList.setHeightInPoints(25);
						
						String contentType = "MO".equals(String.valueOf(bogiList.get(o).get("SURVEY_TYPE")))?"(객관식)":
							"MM".equals(String.valueOf(bogiList.get(o).get("SURVEY_TYPE")))?"(다중선택 객관식)":
							"(주관식)";
						cellQuestList = rowQuestList.createCell(0);
						cellQuestList.setCellValue(
							String.valueOf(bogiList.get(o).get("SURVEY_NO")) + "." +
							String.valueOf(bogiList.get(o).get("SURVEY_DNO")) + " " +
							String.valueOf(bogiList.get(o).get("SURVEY_CONTENT")) + " " +
							contentType
						);
						cellQuestList.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
					}
					initNum = initNum + (bogiList.size()+3);
				}else{
					initNum = initNum + 4;
				}*/
				
				List<Map<String, Object>> bogiList = mapper.selectList("SurveyMapper.selectSurveyUserAnswerAllList", list.get(i));
				if(!bogiList.isEmpty() && bogiList.size() > 0){
					Row rowQuestList = null;
					Row rowQuestNextList = null; 
					Cell cellQuestZero = null;
					Cell cellQuestList = null;
					Cell cellQuestNextList = null;
					String vsIdAndDid = "";
					String vsContentTitle = "";
					String contentType = "";
					Object vsBefType = "";
					int initCellIdx = 1;
					for(int o = 0; o < bogiList.size(); o++){
						contentType = "MO".equals(String.valueOf(bogiList.get(o).get("SURVEY_TYPE")))?"(객관식)":
							"MM".equals(String.valueOf(bogiList.get(o).get("SURVEY_TYPE")))?"(다중선택 객관식)":
							"(주관식)";						
						
						if(o == 0){
							//첫 시작은 우선 해당 데이터에 대한 로우 생성
							rowQuestList = sheet.createRow(initNum);
							rowQuestList.setHeightInPoints(25);
							
							//비교를 위한 ID, DID 를 저장
							vsIdAndDid = String.valueOf(bogiList.get(o).get("SURVEY_ID")) + "" + String.valueOf(bogiList.get(o).get("SURVEY_DID"));
							vsContentTitle = (String)bogiList.get(o).get("SURVEY_CONTENT");
							
							//첫번째 cell 을 생성
							cellQuestList = rowQuestList.createCell(0);
							//첫번째 cell 에 해당 문항의 번호와 문항을 작성
							cellQuestList.setCellValue(
								String.valueOf(bogiList.get(o).get("SURVEY_NO")) + "." +
								String.valueOf(bogiList.get(o).get("SURVEY_DNO")) + " " +
								String.valueOf(bogiList.get(o).get("SURVEY_CONTENT")) + " " +
								contentType
							);
							cellQuestList.setCellStyle(RowFilledWithAnswerHeaderStyle(workBook, sheet, row));
							
							//만일 객관식이라면 
							if("MO".equals(String.valueOf(bogiList.get(o).get("SURVEY_TYPE")))){
								//다음 cell 에 (기본 베이스 1으로 세팅) 셀을 생성 한다.
								cellQuestList = rowQuestList.createCell(initCellIdx);
								
								//생성된 cell 에 보기 1번을 넣는다.
								if(null != bogiList.get(o).get("E_SURVEY_CONTENT") || !"".equals(bogiList.get(o).get("E_SURVEY_CONTENT"))){
									cellQuestList.setCellValue(
										String.valueOf(bogiList.get(o).get("E_SURVEY_CONTENT"))
									);
									cellQuestList.setCellStyle(RowFilledWithAnswerHeaderStyle(workBook, sheet, row));
									
									//문항이 따로 로우로 나오는 것이 아니라 
									//문항의 보기 기준으로 데이터가 select 되기 때문에 
									//바로 보기에 대한 보기 1번 항목도 셋팅을 한다.
									rowQuestNextList = sheet.createRow(initNum+1);
									rowQuestNextList.setHeightInPoints(25);
									
									cellQuestZero = rowQuestNextList.createCell(0);
									cellQuestZero.setCellValue("총 " + String.valueOf(bogiList.get(o).get("U_CNT")) + " 명 응답");
									cellQuestZero.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
									
									cellQuestNextList = rowQuestNextList.createCell(initCellIdx);
									cellQuestNextList.setCellValue(
										"("+String.valueOf(bogiList.get(o).get("CNT"))+") 명 선택"
									);
									cellQuestNextList.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
									
								};
							}else if("MM".equals(String.valueOf(bogiList.get(o).get("SURVEY_TYPE")))){
								//다음 cell 에 (기본 베이스 1으로 세팅) 셀을 생성 한다.
								cellQuestList = rowQuestList.createCell(initCellIdx);
								
								//생성된 cell 에 보기 1번을 넣는다.
								if(null != bogiList.get(o).get("E_SURVEY_CONTENT") || !"".equals(bogiList.get(o).get("E_SURVEY_CONTENT"))){
									cellQuestList.setCellValue(
										String.valueOf(bogiList.get(o).get("E_SURVEY_CONTENT"))
									);
									cellQuestList.setCellStyle(RowFilledWithAnswerHeaderStyle(workBook, sheet, row));
									
									//문항이 따로 로우로 나오는 것이 아니라 
									//문항의 보기 기준으로 데이터가 select 되기 때문에 
									//바로 보기에 대한 보기 1번 항목도 셋팅을 한다.
									rowQuestNextList = sheet.createRow(initNum+1);
									rowQuestNextList.setHeightInPoints(25);
									
									cellQuestZero = rowQuestNextList.createCell(0);
									cellQuestZero.setCellValue("총 " + String.valueOf(bogiList.get(o).get("U_CNT")) + " 명 응답");
									cellQuestZero.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
									
									cellQuestNextList = rowQuestNextList.createCell(initCellIdx);
									cellQuestNextList.setCellValue(
										"("+String.valueOf(bogiList.get(o).get("CNT"))+") 명 선택"
									);
									cellQuestNextList.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
									
								};
							}else if("S".equals(String.valueOf(bogiList.get(o).get("SURVEY_TYPE")))){
								cellQuestList = rowQuestList.createCell(initCellIdx);
								
								cellQuestList.setCellValue(
									String.valueOf(bogiList.get(o).get("PLAYERS"))
								);
								cellQuestList.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
							};
							initCellIdx++;
						}else{
							//같은 보기문항이라면  (주관식은 같은 보기문항이 나올 수가 없다)
							if(vsIdAndDid.equals(String.valueOf(bogiList.get(o).get("SURVEY_ID")) + "" + String.valueOf(bogiList.get(o).get("SURVEY_DID")))){
								cellQuestList = rowQuestList.createCell(initCellIdx);
								
								if(null != bogiList.get(o).get("E_SURVEY_CONTENT") || !"".equals(bogiList.get(o).get("E_SURVEY_CONTENT"))){
									cellQuestList.setCellValue(
										String.valueOf(bogiList.get(o).get("E_SURVEY_CONTENT"))
									);
									cellQuestList.setCellStyle(RowFilledWithAnswerHeaderStyle(workBook, sheet, row));
									
									cellQuestNextList = rowQuestNextList.createCell(initCellIdx);
									cellQuestNextList.setCellValue(
										"("+String.valueOf(bogiList.get(o).get("CNT"))+") 명 선택"
									);
									cellQuestNextList.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
								};
								initCellIdx++;
							}else{
								//다른 보기가 시작 된다면 
								initCellIdx = 1;
								if("MO".equals(String.valueOf(bogiList.get(o).get("SURVEY_TYPE")))){
									initNum = initNum+2;
								}else if("MM".equals(String.valueOf(bogiList.get(o).get("SURVEY_TYPE")))){
									initNum = initNum+2;
								}else if("S".equals(String.valueOf(bogiList.get(o).get("SURVEY_TYPE")))){
									if(vsBefType.equals(bogiList.get(o).get("SURVEY_TYPE"))){
										initNum = initNum+2;
									}else{
										initNum = initNum+3;
									}
								}else{
									initNum = initNum+2;
								};
								
								//첫 시작은 우선 해당 데이터에 대한 로우 생성
								rowQuestList = sheet.createRow(initNum);
								rowQuestList.setHeightInPoints(25);
								
								//비교를 위한 ID, DID 를 저장
								vsIdAndDid = String.valueOf(bogiList.get(o).get("SURVEY_ID")) + "" + String.valueOf(bogiList.get(o).get("SURVEY_DID"));
								vsContentTitle = (String)bogiList.get(o).get("SURVEY_CONTENT");
								
								//첫번째 cell 을 생성
								cellQuestList = rowQuestList.createCell(0);
								//첫번째 cell 에 해당 문항의 번호와 문항을 작성
								cellQuestList.setCellValue(
									String.valueOf(bogiList.get(o).get("SURVEY_NO")) + "." +
									String.valueOf(bogiList.get(o).get("SURVEY_DNO")) + " " +
									String.valueOf(bogiList.get(o).get("SURVEY_CONTENT")) + " " +
									contentType
								);
								cellQuestList.setCellStyle(RowFilledWithAnswerHeaderStyle(workBook, sheet, row));
								
								//만일 객관식이라면 
								if("MO".equals(String.valueOf(bogiList.get(o).get("SURVEY_TYPE")))){
									//다음 cell 에 (기본 베이스 1으로 세팅) 셀을 생성 한다.
									cellQuestList = rowQuestList.createCell(initCellIdx);
									
									//생성된 cell 에 보기 1번을 넣는다.
									if(null != bogiList.get(o).get("E_SURVEY_CONTENT") || !"".equals(bogiList.get(o).get("E_SURVEY_CONTENT"))){
										cellQuestList.setCellValue(
											String.valueOf(bogiList.get(o).get("E_SURVEY_CONTENT"))
										);
										cellQuestList.setCellStyle(RowFilledWithAnswerHeaderStyle(workBook, sheet, row));
										
										//문항이 따로 로우로 나오는 것이 아니라 
										//문항의 보기 기준으로 데이터가 select 되기 때문에 
										//바로 보기에 대한 보기 1번 항목도 셋팅을 한다.
										rowQuestNextList = sheet.createRow(initNum+1);
										rowQuestNextList.setHeightInPoints(25);
										
										cellQuestZero = rowQuestNextList.createCell(0);
										cellQuestZero.setCellValue("총 " + String.valueOf(bogiList.get(o).get("U_CNT")) + " 명 응답");
										cellQuestZero.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
										
										cellQuestNextList = rowQuestNextList.createCell(initCellIdx);
										cellQuestNextList.setCellValue(
											"("+String.valueOf(bogiList.get(o).get("CNT"))+") 명 선택"
										);
										cellQuestNextList.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
										
									};
								}else if("MM".equals(String.valueOf(bogiList.get(o).get("SURVEY_TYPE")))){
									//다음 cell 에 (기본 베이스 1으로 세팅) 셀을 생성 한다.
									cellQuestList = rowQuestList.createCell(initCellIdx);
									
									//생성된 cell 에 보기 1번을 넣는다.
									if(null != bogiList.get(o).get("E_SURVEY_CONTENT") || !"".equals(bogiList.get(o).get("E_SURVEY_CONTENT"))){
										cellQuestList.setCellValue(
											String.valueOf(bogiList.get(o).get("E_SURVEY_CONTENT"))
										);
										cellQuestList.setCellStyle(RowFilledWithAnswerHeaderStyle(workBook, sheet, row));
										
										//문항이 따로 로우로 나오는 것이 아니라 
										//문항의 보기 기준으로 데이터가 select 되기 때문에 
										//바로 보기에 대한 보기 1번 항목도 셋팅을 한다.
										rowQuestNextList = sheet.createRow(initNum+1);
										rowQuestNextList.setHeightInPoints(25);
										
										cellQuestZero = rowQuestNextList.createCell(0);
										cellQuestZero.setCellValue("총 " + String.valueOf(bogiList.get(o).get("U_CNT")) + " 명 응답");
										cellQuestZero.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
										
										cellQuestNextList = rowQuestNextList.createCell(initCellIdx);
										cellQuestNextList.setCellValue(
											"("+String.valueOf(bogiList.get(o).get("CNT"))+") 명 선택"
										);
										cellQuestNextList.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
										
									};
								}else if("S".equals(String.valueOf(bogiList.get(o).get("SURVEY_TYPE")))){
									cellQuestList = rowQuestList.createCell(initCellIdx);
									
									cellQuestList.setCellValue(
										String.valueOf(bogiList.get(o).get("PLAYERS"))
									);
									cellQuestList.setCellStyle(RowFilledWithHeaderContentStyle(workBook, sheet, row));
								};
								initCellIdx++;
							}
						}
						vsBefType = bogiList.get(o).get("SURVEY_TYPE");
					}
					initNum = initNum + (bogiList.size()+3);
				}else{
					initNum = initNum + 4;
				}
												
				//컬럼의 가로 길이 변경
				for(int j=0; j <= 6; j++){
					sheet.autoSizeColumn((short)j);
					//sheet.setColumnWidth(j, (sheet.getColumnWidth(j))+5000 );  // 윗줄만으로는 컬럼의 width 가 부족하여 더 늘려야 함.
				}				
			}
			
			String dateStr = new SimpleDateFormat("yyyyMMdd").format(new Date());
			String fileFullNm = "C:/surveyExcelDownload/" + "Meic_" + dateStr + ".xls";
			// 해당 폴더가 없으면 생성한다.
			File realFolder = new File("C:/surveyExcelDownload/");
			if (!realFolder.exists()) {
				realFolder.mkdirs();
			}

			// 파일 생성
			File realFile = new File(fileFullNm);
			FileOutputStream fos = new FileOutputStream(realFile);
			workBook.write(fos);
			fos.close();

			Map<String, Object> fileParam = new HashMap<String, Object>();
			fileParam.put("filename", "Meic_" + dateStr + ".xls");
			fileParam.put("filePath", "C:/surveyExcelDownload/");
			fileParam.put("file", realFile);
			fileParam.put("temp", true);
			return fileParam;
		}else {
			return resMap;
		}
	};
	
	/**
	 * 전체 설문지의 정보 헤더 스타일 세팅
	 * @param wb
	 * @param sheet
	 * @param row
	 * @return
	 * @throws Exception
	 */
	private static CellStyle RowFilledWithHeaderStyle(Workbook wb, HSSFSheet sheet, Row row) throws Exception {
		CellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		cellStyle.setBorderBottom(CellStyle.BORDER_DOUBLE);
		cellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
		cellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setBorderRight(CellStyle.BORDER_THIN);
		cellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setBorderTop(CellStyle.BORDER_THIN);
		cellStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setFillForegroundColor(HSSFColor.BRIGHT_GREEN.index);
		cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		return cellStyle;
	};
	
	/**
	 * 설문지의 문항 스타일 지정
	 * @param wb
	 * @param sheet
	 * @param row
	 * @return
	 * @throws Exception
	 */
	private static CellStyle RowFilledWithAnswerHeaderStyle(Workbook wb, HSSFSheet sheet, Row row) throws Exception {
		CellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		cellStyle.setBorderBottom(CellStyle.BORDER_DOUBLE);
		cellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
		cellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setBorderRight(CellStyle.BORDER_THIN);
		cellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setBorderTop(CellStyle.BORDER_THIN);
		cellStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setFillForegroundColor(HSSFColor.AQUA.index);
		cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		return cellStyle;
	};
	
	/**
	 * 설문지의 내용 스타일 지정
	 * @param wb
	 * @param sheet
	 * @param row
	 * @return
	 * @throws Exception
	 */
	private static CellStyle RowFilledWithHeaderContentStyle(Workbook wb, HSSFSheet sheet, Row row) throws Exception {
		CellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		cellStyle.setBorderBottom(CellStyle.BORDER_DOUBLE);
		cellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
		cellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setBorderRight(CellStyle.BORDER_THIN);
		cellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setBorderTop(CellStyle.BORDER_THIN);
		cellStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
		return cellStyle;
	};
	
	/**
	 * value 값 셋팅
	 * @param cell
	 * @param data
	 */
	public static void convertDataType (Cell cell, Object data){
		data = String.valueOf(data);
		
		if(StringUtils.isNumeric((CharSequence) data)){
			cell.setCellValue(Integer.parseInt(String.valueOf(data)));
		}else if(StringUtils.isEmpty((CharSequence) data)){
			cell.setCellValue("");
		}else if(data instanceof Double){
			cell.setCellValue((Double)data);
		}else if(data instanceof Float){
			cell.setCellValue((Float)data);
		}else if(null == data || "null" == data || "" == data){ 
			cell.setCellValue(" - ");
		}else{
			cell.setCellValue((String) data);
		}
	};

}
