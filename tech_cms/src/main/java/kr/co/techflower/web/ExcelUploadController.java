package kr.co.techflower.web;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import ngel.core.web.FrameworkController;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.techflower.service.ExcelUploadService;

@Controller
public class ExcelUploadController extends FrameworkController{
	
	private static final Logger logger = LoggerFactory.getLogger(ExcelUploadController.class);
	
	@Autowired
	ExcelUploadService excelUploadService;
	
	@RequestMapping(value="/doExcelUpload.do")
	@ResponseBody
	public Map<String, Object> doUpdate(MultipartHttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.info("/doExcelUpload.do");
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		@SuppressWarnings("unchecked")
		Enumeration<String> parameterNames = req.getParameterNames();
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			String[] paramValues = req.getParameterValues(paramName);
			for (int i = 0; i < paramValues.length; i++) {
				String paramValue = paramValues[i];
				reqMap.put(paramName, paramValue);				
			}
		}
		
		String remoteIp = req.getRemoteAddr();
		if("0:0:0:0:0:0:0:1".equals(remoteIp)){
			reqMap.put("REG_IP", "127.0.0.1");
		}else{
			reqMap.put("REG_IP", remoteIp);
		}
		List<MultipartFile> voList = req.getFiles("files");
		
		//int resultCnt = 0;
		
		if(voList.isEmpty()){
			//파일 선택을 하지 않았기 때문에 TB_BOARD 테이블의 정보만 업데이트를 해준다.
			System.out.println("파일 없음");
		}else{
			System.out.println("파일 있음");
			//파일 선택을 하였기 때문에 TB_FILE 테이블의 정보도 수정, 파일 업로드도 해준다.
			//resMap = excelFileUpload(req);
			resMap = excelFileAvgUpload(req);
			reqMap.put("FILE_SIZE", resMap.get("FILE_SIZE"));
			reqMap.put("FILE_NM", resMap.get("FILE_NM"));
			reqMap.put("SVR_FILE_NM", resMap.get("SVR_FILE_NM"));
		}
		
		resMap.put("result", "true");
		resMap.put("resultValue", "완료");
		/*if(resultCnt > 0){
			resMap.put("result", "true");
			resMap.put("resultValue", "완료");
		}else{
			resMap.put("result", "false");
			resMap.put("resultValue", "실패");
		}*/
		return resMap;	
		
	};
	
	/**
	 * 파일 업로드
	 * @param req
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> excelFileUpload(MultipartHttpServletRequest req) throws Exception{
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<MultipartFile> voList = req.getFiles("files");
		
		if (!voList.isEmpty() && voList.size() > 0) {
			returnMap.put("FILE_SIZE", voList.get(0).getSize());
			returnMap.put("FILE_NM", voList.get(0).getOriginalFilename());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			
			System.out.println(voList.size());
			System.out.println(returnMap);
			
			InputStream fis = voList.get(0).getInputStream();
			HSSFWorkbook hWorkbook;
			XSSFWorkbook xWorkbook;
			
			if(voList.get(0).getName().indexOf(".xlsx") != -1){
				xWorkbook = new XSSFWorkbook(fis);
				XSSFSheet otherSheet = xWorkbook.getSheetAt(0); 
				
				Iterator<Row> rowIter = otherSheet.iterator();
				while(rowIter.hasNext()){
					Row row = rowIter.next();
					System.out.println(row.getCell(0) + " :: " + row.getCell(1) + " :: " + row.getCell(2)
							+ " :: " + row.getCell(3) + " :: " + row.getCell(4));
				}
			}else{
				Map<String, Object> reqDataMap = null;
				hWorkbook = new HSSFWorkbook(fis);
				
				//================================ Capesize 첫번째 시트 ===========================================
				HSSFSheet atenSheet = hWorkbook.getSheetAt(0);
				Iterator<Row> rowIter = atenSheet.iterator();
				while(rowIter.hasNext()){
					Row row = rowIter.next();
					if(row.getRowNum() >= 4 && null != row.getCell(0)){
						// MC1 ~ MC9
						// row는 4부터 데이터가 시작
						// cel 은 
						// 0 = 날짜
						// 2 = MC1 / daesang
						// 3 = MC1 / flaship
						// 4 = MC1 / jangsoos
						// 5 = MC1 / basimchartering
						// 6 = MC1 / 
						// 7 = MC1 / 평균
						// 15 = MC2 / daesang
						// 16 = MC2 / flaship
						// 17 = MC2 / jangsoos
						// 18 = MC2 / basimchartering
						// 19 = MC2
						// 20 = MC2 / 평균
						
						if(!row.getZeroHeight()){
							//MC1 ~ MC9 까지의 평균값
							double firTemp = row.getCell(7) == null ? 0 : Math.round(row.getCell(7).getNumericCellValue()*100.0)/100.0;
							double secTemp = row.getCell(20) == null ? 0 : Math.round(row.getCell(20).getNumericCellValue()*100.0)/100.0;
							double thrTemp = row.getCell(27) == null ? 0 : Math.round(row.getCell(27).getNumericCellValue()*100.0)/100.0;
							double fouTemp = row.getCell(39) == null ? 0 : Math.round(row.getCell(39).getNumericCellValue()*100.0)/100.0;
							double fifTemp = row.getCell(46) == null ? 0 : Math.round(row.getCell(46).getNumericCellValue()*100.0)/100.0;
							double sixTemp = row.getCell(53) == null ? 0 : Math.round(row.getCell(53).getNumericCellValue()*100.0)/100.0;
							double sevTemp = row.getCell(60) == null ? 0 : Math.round(row.getCell(60).getNumericCellValue()*100.0)/100.0;
							double eigTemp = row.getCell(67) == null ? 0 : Math.round(row.getCell(67).getNumericCellValue()*100.0)/100.0;
							double ninTemp = row.getCell(74) == null ? 0 : Math.round(row.getCell(74).getNumericCellValue()*100.0)/100.0;
							String vsIdxDD = sdf.format(row.getCell(0).getDateCellValue());
							System.out.println("날짜 : "+ vsIdxDD + "============================================================");
							
							// ================= MC1 ===================
							//MC1 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC1", row.getSheet().getRow(3).getCell(2), row.getCell(2));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC1 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC1", row.getSheet().getRow(3).getCell(3), row.getCell(3));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC1 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC1", row.getSheet().getRow(3).getCell(4), row.getCell(4));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC1 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC1", row.getSheet().getRow(3).getCell(5), row.getCell(5));
							excelUploadService.doSaveOneData(reqDataMap);
							
							// ================= MC2 ===================
							//MC2 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC2", row.getSheet().getRow(3).getCell(15), row.getCell(15));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC2 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC2", row.getSheet().getRow(3).getCell(16), row.getCell(16));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC2 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC2", row.getSheet().getRow(3).getCell(17), row.getCell(17));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC2 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC2", row.getSheet().getRow(3).getCell(18), row.getCell(18));
							excelUploadService.doSaveOneData(reqDataMap);
							
							// ================= MC3 ===================
							//MC3 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC3", row.getSheet().getRow(3).getCell(22), row.getCell(22));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC3 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC3", row.getSheet().getRow(3).getCell(23), row.getCell(23));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC3 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC3", row.getSheet().getRow(3).getCell(24), row.getCell(24));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC3 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC3", row.getSheet().getRow(3).getCell(25), row.getCell(25));
							excelUploadService.doSaveOneData(reqDataMap);
							
							// ================= MC4 ===================
							//MC4 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC4", row.getSheet().getRow(3).getCell(34), row.getCell(34));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC4 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC4", row.getSheet().getRow(3).getCell(35), row.getCell(35));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC4 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC4", row.getSheet().getRow(3).getCell(36), row.getCell(36));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC4 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC4", row.getSheet().getRow(3).getCell(37), row.getCell(37));
							excelUploadService.doSaveOneData(reqDataMap);
							
							// ================= MC5 ===================
							//MC5 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC5", row.getSheet().getRow(3).getCell(41), row.getCell(41));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC5 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC5", row.getSheet().getRow(3).getCell(42), row.getCell(42));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC5 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC5", row.getSheet().getRow(3).getCell(43), row.getCell(43));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC5 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC5", row.getSheet().getRow(3).getCell(44), row.getCell(44));
							excelUploadService.doSaveOneData(reqDataMap);
							
							// ================= MC6 ===================
							//MC6 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC6", row.getSheet().getRow(3).getCell(48), row.getCell(48));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC6 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC6", row.getSheet().getRow(3).getCell(49), row.getCell(49));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC6 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC6", row.getSheet().getRow(3).getCell(50), row.getCell(50));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC6 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC6", row.getSheet().getRow(3).getCell(51), row.getCell(51));
							excelUploadService.doSaveOneData(reqDataMap);
							
							// ================= MC7 ===================
							//MC7 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC7", row.getSheet().getRow(3).getCell(55), row.getCell(55));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC7 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC7", row.getSheet().getRow(3).getCell(56), row.getCell(56));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC7 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC7", row.getSheet().getRow(3).getCell(57), row.getCell(57));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC7 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC7", row.getSheet().getRow(3).getCell(58), row.getCell(58));
							excelUploadService.doSaveOneData(reqDataMap);
							
							// ================= MC8 ===================
							//MC8 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC8", row.getSheet().getRow(3).getCell(62), row.getCell(62));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC8 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC8", row.getSheet().getRow(3).getCell(63), row.getCell(63));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC8 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC8", row.getSheet().getRow(3).getCell(64), row.getCell(64));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC8 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC8", row.getSheet().getRow(3).getCell(65), row.getCell(65));
							excelUploadService.doSaveOneData(reqDataMap);
							
							// ================= MC9 ===================
							//MC9 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC9", row.getSheet().getRow(3).getCell(69), row.getCell(69));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC9 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC9", row.getSheet().getRow(3).getCell(70), row.getCell(70));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC9 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC9", row.getSheet().getRow(3).getCell(71), row.getCell(71));
							excelUploadService.doSaveOneData(reqDataMap);							
							//MC9 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MC9", row.getSheet().getRow(3).getCell(72), row.getCell(72));
							excelUploadService.doSaveOneData(reqDataMap);
							
							System.out.println("==========================================================================");
						}
					}
				}
				//==========================================================================================
				//================================ Panamax 두번째 시트 ===========================================
				HSSFSheet panaSheet = hWorkbook.getSheetAt(1);
				Iterator<Row> panaRowIter = panaSheet.iterator();
				while(panaRowIter.hasNext()){
					Row row = panaRowIter.next();
					if(row.getRowNum() >= 4 && null != row.getCell(0)){
						if(!row.getZeroHeight()){
							//MP1 ~ MP7 까지의 평균값
							double firTemp = row.getCell(10) == null ? 0 : Math.round(row.getCell(10).getNumericCellValue()*10.0)/10.0;
							double secTemp = row.getCell(19) == null ? 0 : Math.round(row.getCell(19).getNumericCellValue()*10.0)/10.0;
							double thrTemp = row.getCell(29) == null ? 0 : Math.round(row.getCell(29).getNumericCellValue()*10.0)/10.0;
							double fouTemp = row.getCell(38) == null ? 0 : Math.round(row.getCell(38).getNumericCellValue()*10.0)/10.0;
							double fifTemp = row.getCell(47) == null ? 0 : Math.round(row.getCell(47).getNumericCellValue()*10.0)/10.0;
							double sixTemp = row.getCell(58) == null ? 0 : Math.round(row.getCell(58).getNumericCellValue()*10.0)/10.0;
							double sevTemp = row.getCell(69) == null ? 0 : Math.round(row.getCell(69).getNumericCellValue()*10.0)/10.0;
							String vsIdxDD = sdf.format(row.getCell(0).getDateCellValue());
							
							System.out.println("날짜 : "+ vsIdxDD + "============================================================");
							
							// ================= MP1 ===================
							//MP1 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP1", row.getSheet().getRow(3).getCell(2), row.getCell(2));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP1 첫번째 사용자 : "+reqDataMap);
							//MP1 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP1", row.getSheet().getRow(3).getCell(3), row.getCell(3));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP1 두번째 사용자 : "+reqDataMap);
							//MP1 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP1", row.getSheet().getRow(3).getCell(4), row.getCell(4));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP1 세번째 사용자 : "+reqDataMap);
							//MP1 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP1", row.getSheet().getRow(3).getCell(6), row.getCell(6));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP1 네번째 사용자 : "+reqDataMap);
							//MP1 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP1", row.getSheet().getRow(3).getCell(7), row.getCell(7));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP1 다번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+firTemp);
							
							//MP2 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP2", row.getSheet().getRow(3).getCell(12), row.getCell(12));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP2 첫번째 사용자 : "+reqDataMap);
							//MP2 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP2", row.getSheet().getRow(3).getCell(13), row.getCell(13));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP2 두번째 사용자 : "+reqDataMap);
							//MP2 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP2", row.getSheet().getRow(3).getCell(14), row.getCell(14));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP2 세번째 사용자 : "+reqDataMap);
							//MP2 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP2", row.getSheet().getRow(3).getCell(16), row.getCell(16));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP2 네번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+secTemp);
							
							//MP3 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP3", row.getSheet().getRow(3).getCell(21), row.getCell(21));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP3 첫번째 사용자 : "+reqDataMap);
							//MP3 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP3", row.getSheet().getRow(3).getCell(22), row.getCell(22));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP3 두번째 사용자 : "+reqDataMap);
							//MP3 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP3", row.getSheet().getRow(3).getCell(23), row.getCell(23));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP3 세번째 사용자 : "+reqDataMap);
							//MP3 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP3", row.getSheet().getRow(3).getCell(25), row.getCell(25));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP3 네번째 사용자 : "+reqDataMap);
							//MP3 - 다번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP3", row.getSheet().getRow(3).getCell(26), row.getCell(26));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP3 다번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+thrTemp);
							
							//MP4 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP4", row.getSheet().getRow(3).getCell(31), row.getCell(31));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP4 첫번째 사용자 : "+reqDataMap);
							//MP4 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP4", row.getSheet().getRow(3).getCell(32), row.getCell(32));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP4 두번째 사용자 : "+reqDataMap);
							//MP4 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP4", row.getSheet().getRow(3).getCell(33), row.getCell(33));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP4 세번째 사용자 : "+reqDataMap);
							//MP4 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP4", row.getSheet().getRow(3).getCell(35), row.getCell(35));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP4 네번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+fouTemp);
							
							//MP5 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP5", row.getSheet().getRow(3).getCell(40), row.getCell(40));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP5 첫번째 사용자 : "+reqDataMap);
							//MP5 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP5", row.getSheet().getRow(3).getCell(41), row.getCell(41));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP5 두번째 사용자 : "+reqDataMap);
							//MP5 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP5", row.getSheet().getRow(3).getCell(42), row.getCell(42));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP5 세번째 사용자 : "+reqDataMap);
							//MP5 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP5", row.getSheet().getRow(3).getCell(44), row.getCell(44));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP5 네번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+fifTemp);//47
							
							//MP6 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP6", row.getSheet().getRow(3).getCell(49), row.getCell(49));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP6 첫번째 사용자 : "+reqDataMap);
							//MP6 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP6", row.getSheet().getRow(3).getCell(50), row.getCell(50));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP6 두번째 사용자 : "+reqDataMap);
							//MP6 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP6", row.getSheet().getRow(3).getCell(51), row.getCell(51));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP6 세번째 사용자 : "+reqDataMap);
							//MP6 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP6", row.getSheet().getRow(3).getCell(54), row.getCell(54));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP6 네번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+sixTemp);//58
							
							//MP7 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP7", row.getSheet().getRow(3).getCell(60), row.getCell(60));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP7 첫번째 사용자 : "+reqDataMap);
							//MP7 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP7", row.getSheet().getRow(3).getCell(61), row.getCell(61));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP7 두번째 사용자 : "+reqDataMap);
							//MP7 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP7", row.getSheet().getRow(3).getCell(62), row.getCell(62));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP7 세번째 사용자 : "+reqDataMap);
							//MP7 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MP7", row.getSheet().getRow(3).getCell(65), row.getCell(65));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MP7 네번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+sevTemp);//69
						}
					}
				}
				
				// Supramax =================================================
				HSSFSheet supraSheet = hWorkbook.getSheetAt(2);
				Iterator<Row> supraRowIter = supraSheet.iterator();
				while(supraRowIter.hasNext()){
					Row row = supraRowIter.next();
					if(row.getRowNum() >= 4 && null != row.getCell(0)){
						if(!row.getZeroHeight()){
							//MS1 ~ MS7 까지의 평균값
							double firTemp = row.getCell(9) == null ? 0 : Math.round(row.getCell(9).getNumericCellValue());
							double secTemp = row.getCell(17) == null ? 0 : Math.round(row.getCell(17).getNumericCellValue());
							double thrTemp = row.getCell(26) == null ? 0 : Math.round(row.getCell(26).getNumericCellValue());
							double fouTemp = row.getCell(34) == null ? 0 : Math.round(row.getCell(34).getNumericCellValue());
							double fifTemp = row.getCell(44) == null ? 0 : Math.round(row.getCell(44).getNumericCellValue());
							double sixTemp = row.getCell(54) == null ? 0 : Math.round(row.getCell(54).getNumericCellValue());
							double sevTemp = row.getCell(62) == null ? 0 : Math.round(row.getCell(62).getNumericCellValue());
							String vsIdxDD = sdf.format(row.getCell(0).getDateCellValue());
							System.out.println("날짜 : "+ vsIdxDD + "============================================================");
							
							//MS1 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS1", row.getSheet().getRow(3).getCell(1), row.getCell(1));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS1 첫번째 사용자 : "+reqDataMap);
							//MS1 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS1", row.getSheet().getRow(3).getCell(2), row.getCell(2));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS1 두번째 사용자 : "+reqDataMap);
							//MS1 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS1", row.getSheet().getRow(3).getCell(3), row.getCell(3));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS1 세번째 사용자 : "+reqDataMap);
							//MS1 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS1", row.getSheet().getRow(3).getCell(5), row.getCell(5));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS1 네번째 사용자 : "+reqDataMap);
							//MS1 - 다섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS1", row.getSheet().getRow(3).getCell(6), row.getCell(6));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS1 다번째 사용자 : "+reqDataMap);
							//MS1 - 여섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS1", row.getSheet().getRow(3).getCell(7), row.getCell(7));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS1 여섯번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+firTemp);//9
							
							//MS2 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS2", row.getSheet().getRow(3).getCell(10), row.getCell(10));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS2 첫번째 사용자 : "+reqDataMap);
							//MS2 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS2", row.getSheet().getRow(3).getCell(11), row.getCell(11));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS2 두번째 사용자 : "+reqDataMap);
							//MS2 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS2", row.getSheet().getRow(3).getCell(12), row.getCell(12));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS2 세번째 사용자 : "+reqDataMap);
							//MS2 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS2", row.getSheet().getRow(3).getCell(14), row.getCell(14));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS2 네번째 사용자 : "+reqDataMap);
							//MS2 - 다섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS2", row.getSheet().getRow(3).getCell(15), row.getCell(15));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS2 다번째 사용자 : "+reqDataMap);
							//MS2 - 여섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS2", row.getSheet().getRow(3).getCell(16), row.getCell(16));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS2 여섯번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+secTemp);//17
							
							//MS3 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS3", row.getSheet().getRow(3).getCell(18), row.getCell(18));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS3 첫번째 사용자 : "+reqDataMap);
							//MS3 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS3", row.getSheet().getRow(3).getCell(19), row.getCell(19));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS3 두번째 사용자 : "+reqDataMap);
							//MS3 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS3", row.getSheet().getRow(3).getCell(20), row.getCell(20));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS3 세번째 사용자 : "+reqDataMap);
							//MS3 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS3", row.getSheet().getRow(3).getCell(22), row.getCell(22));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS3 네번째 사용자 : "+reqDataMap);
							//MS3 - 다섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS3", row.getSheet().getRow(3).getCell(23), row.getCell(23));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS3 다번째 사용자 : "+reqDataMap);
							//MS3 - 여섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS3", row.getSheet().getRow(3).getCell(24), row.getCell(24));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS3 여섯번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+thrTemp);//26
							
							//MS4 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS4", row.getSheet().getRow(3).getCell(27), row.getCell(27));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS4 첫번째 사용자 : "+reqDataMap);
							//MS4 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS4", row.getSheet().getRow(3).getCell(28), row.getCell(28));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS4 두번째 사용자 : "+reqDataMap);
							//MS4 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS4", row.getSheet().getRow(3).getCell(29), row.getCell(29));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS4 세번째 사용자 : "+reqDataMap);
							//MS4 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS4", row.getSheet().getRow(3).getCell(31), row.getCell(31));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS4 네번째 사용자 : "+reqDataMap);
							//MS4 - 다섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS4", row.getSheet().getRow(3).getCell(32), row.getCell(32));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS4 다번째 사용자 : "+reqDataMap);
							//MS4 - 여섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS4", row.getSheet().getRow(3).getCell(33), row.getCell(33));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS4 여섯번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+fouTemp);//34
							
							//MS5 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS5", row.getSheet().getRow(3).getCell(35), row.getCell(35));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS5 첫번째 사용자 : "+reqDataMap);
							//MS5 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS5", row.getSheet().getRow(3).getCell(36), row.getCell(36));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS5 두번째 사용자 : "+reqDataMap);
							//MS5 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS5", row.getSheet().getRow(3).getCell(37), row.getCell(37));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS5 세번째 사용자 : "+reqDataMap);
							//MS5 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS5", row.getSheet().getRow(3).getCell(39), row.getCell(39));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS5 네번째 사용자 : "+reqDataMap);
							//MS5 - 다섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS5", row.getSheet().getRow(3).getCell(40), row.getCell(40));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS5 다번째 사용자 : "+reqDataMap);
							//MS5 - 여섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS5", row.getSheet().getRow(3).getCell(41), row.getCell(41));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS5 여섯번째 사용자 : "+reqDataMap);
							//MS5 - 일곱번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS5", row.getSheet().getRow(3).getCell(43), row.getCell(43));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS5 일곱번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+fifTemp);//44
							
							//MS6 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS6", row.getSheet().getRow(3).getCell(45), row.getCell(45));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS6 첫번째 사용자 : "+reqDataMap);
							//MS6 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS6", row.getSheet().getRow(3).getCell(46), row.getCell(46));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS6 두번째 사용자 : "+reqDataMap);
							//MS6 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS6", row.getSheet().getRow(3).getCell(47), row.getCell(47));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS6 세번째 사용자 : "+reqDataMap);
							//MS6 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS6", row.getSheet().getRow(3).getCell(49), row.getCell(49));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS6 네번째 사용자 : "+reqDataMap);
							//MS6 - 다섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS6", row.getSheet().getRow(3).getCell(50), row.getCell(50));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS6 다번째 사용자 : "+reqDataMap);
							//MS6 - 여섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS6", row.getSheet().getRow(3).getCell(51), row.getCell(51));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS6 여섯번째 사용자 : "+reqDataMap);
							//MS6 - 일곱번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS6", row.getSheet().getRow(3).getCell(53), row.getCell(53));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS6 일곱번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+sixTemp);//54
							
							//MS7 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS7", row.getSheet().getRow(3).getCell(55), row.getCell(55));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS7 첫번째 사용자 : "+reqDataMap);
							//MS7 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS7", row.getSheet().getRow(3).getCell(56), row.getCell(56));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS7 두번째 사용자 : "+reqDataMap);
							//MS7 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS7", row.getSheet().getRow(3).getCell(57), row.getCell(57));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS7 세번째 사용자 : "+reqDataMap);
							//MS7 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS7", row.getSheet().getRow(3).getCell(59), row.getCell(59));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS7 네번째 사용자 : "+reqDataMap);
							//MS7 - 다섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS7", row.getSheet().getRow(3).getCell(60), row.getCell(60));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS7 다번째 사용자 : "+reqDataMap);
							//MS7 - 여섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MS7", row.getSheet().getRow(3).getCell(61), row.getCell(61));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MS7 여섯번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+sevTemp);//62
						}
					}
				}
				//===========================================================
				// Handysize =================================================
				HSSFSheet handySheet = hWorkbook.getSheetAt(3);
				Iterator<Row> handyRowIter = handySheet.iterator();
				while(handyRowIter.hasNext()){
					Row row = handyRowIter.next();
					if(row.getRowNum() >= 4 && null != row.getCell(0)){
						if(!row.getZeroHeight()){
							//MH1 ~ MH5 까지의 평균값
							double firTemp = row.getCell(8) == null ? 0 : Math.round(row.getCell(8).getNumericCellValue());
							double secTemp = row.getCell(16) == null ? 0 : Math.round(row.getCell(16).getNumericCellValue());
							double thrTemp = row.getCell(24) == null ? 0 : Math.round(row.getCell(24).getNumericCellValue());
							double fouTemp = row.getCell(32) == null ? 0 : Math.round(row.getCell(32).getNumericCellValue());
							double fifTemp = row.getCell(41) == null ? 0 : Math.round(row.getCell(41).getNumericCellValue());
							String vsIdxDD = sdf.format(row.getCell(0).getDateCellValue());
							System.out.println("날짜 : "+ vsIdxDD + "============================================================");
							
							//MH1 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH1", row.getSheet().getRow(3).getCell(1), row.getCell(1));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH1 첫번째 사용자 : "+reqDataMap);
							//MH1 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH1", row.getSheet().getRow(3).getCell(2), row.getCell(2));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH1 두번째 사용자 : "+reqDataMap);
							//MH1 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH1", row.getSheet().getRow(3).getCell(4), row.getCell(4));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH1 세번째 사용자 : "+reqDataMap);
							//MH1 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH1", row.getSheet().getRow(3).getCell(5), row.getCell(5));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH1 네번째 사용자 : "+reqDataMap);
							//MH1 - 다섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH1", row.getSheet().getRow(3).getCell(6), row.getCell(6));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH1 다번째 사용자 : "+reqDataMap);
							//MH1 - 여섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH1", row.getSheet().getRow(3).getCell(7), row.getCell(7));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH1 여섯번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+firTemp);//8
							
							//MH2 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH2", row.getSheet().getRow(3).getCell(9), row.getCell(9));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH2 첫번째 사용자 : "+reqDataMap);
							//MH2 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH2", row.getSheet().getRow(3).getCell(10), row.getCell(10));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH2 두번째 사용자 : "+reqDataMap);
							//MH2 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH2", row.getSheet().getRow(3).getCell(12), row.getCell(12));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH2 세번째 사용자 : "+reqDataMap);
							//MH2 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH2", row.getSheet().getRow(3).getCell(13), row.getCell(13));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH2 네번째 사용자 : "+reqDataMap);
							//MH2 - 다섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH2", row.getSheet().getRow(3).getCell(14), row.getCell(14));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH2 다번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+secTemp);//16
							
							//MH3 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH3", row.getSheet().getRow(3).getCell(17), row.getCell(17));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH3 첫번째 사용자 : "+reqDataMap);
							//MH3 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH3", row.getSheet().getRow(3).getCell(18), row.getCell(18));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH3 두번째 사용자 : "+reqDataMap);
							//MH3 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH3", row.getSheet().getRow(3).getCell(20), row.getCell(20));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH3 세번째 사용자 : "+reqDataMap);
							//MH3 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH3", row.getSheet().getRow(3).getCell(21), row.getCell(21));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH3 네번째 사용자 : "+reqDataMap);
							//MH3 - 다섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH3", row.getSheet().getRow(3).getCell(22), row.getCell(22));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH3 다번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+thrTemp);//24
							
							//MH4 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH4", row.getSheet().getRow(3).getCell(25), row.getCell(25));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH4 첫번째 사용자 : "+reqDataMap);
							//MH4 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH4", row.getSheet().getRow(3).getCell(26), row.getCell(26));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH4 두번째 사용자 : "+reqDataMap);
							//MH4 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH4", row.getSheet().getRow(3).getCell(28), row.getCell(28));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH4 세번째 사용자 : "+reqDataMap);
							//MH4 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH4", row.getSheet().getRow(3).getCell(29), row.getCell(29));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH4 네번째 사용자 : "+reqDataMap);
							//MH4 - 다섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH4", row.getSheet().getRow(3).getCell(30), row.getCell(30));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH4 다번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+fouTemp);//32
							
							//MH5 - 첫번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH5", row.getSheet().getRow(3).getCell(34), row.getCell(34));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH5 첫번째 사용자 : "+reqDataMap);
							//MH5 - 두번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH5", row.getSheet().getRow(3).getCell(35), row.getCell(35));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH5 두번째 사용자 : "+reqDataMap);
							//MH5 - 세번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH5", row.getSheet().getRow(3).getCell(37), row.getCell(37));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH5 세번째 사용자 : "+reqDataMap);
							//MH5 - 네번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH5", row.getSheet().getRow(3).getCell(38), row.getCell(38));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH5 네번째 사용자 : "+reqDataMap);
							//MH5 - 다섯번째 사용자 저장
							reqDataMap = pushMapData(reqDataMap, vsIdxDD, "MH5", row.getSheet().getRow(3).getCell(39), row.getCell(39));
							excelUploadService.doSaveOneData(reqDataMap);//System.out.println("MH5 다번째 사용자 : "+reqDataMap);
							//System.out.println("평균 : "+fifTemp);//41
							
							
						}
					}
				}
				//===========================================================
			}
		}
		return returnMap;
	};
	
	/**
	 * 파일 업로드 (평균값만 삽입)
	 * @param req
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> excelFileAvgUpload(MultipartHttpServletRequest req) throws Exception{
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<MultipartFile> voList = req.getFiles("files");
		
		if (!voList.isEmpty() && voList.size() > 0) {
			returnMap.put("FILE_SIZE", voList.get(0).getSize());
			returnMap.put("FILE_NM", voList.get(0).getOriginalFilename());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			
			System.out.println(voList.size());
			System.out.println(returnMap);
			
			InputStream fis = voList.get(0).getInputStream();
			HSSFWorkbook hWorkbook;
			XSSFWorkbook xWorkbook;
			
			if(voList.get(0).getName().indexOf(".xlsx") != -1){
				Map<String, Object> reqDataMap = null;
				xWorkbook = new XSSFWorkbook(fis);
				
				//================================ Capesize 첫번째 시트 ===========================================
				XSSFSheet atenSheet = xWorkbook.getSheetAt(4);
				Iterator<Row> rowIter = atenSheet.iterator();
				while(rowIter.hasNext()){
					Row row = rowIter.next();
					if(row.getRowNum() >= 1 && null != row.getCell(0).getDateCellValue()){
												
						if(!row.getZeroHeight()){
							String vsIdxDD = sdf.format(row.getCell(0).getDateCellValue());
							System.out.println("날짜 : "+ vsIdxDD + "============================================================");
							
							// ================= 케이프 운임 ===================
							//MC1
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(1), row.getCell(1));
							if(null != row.getCell(1)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MC2
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(3), row.getCell(3));
							if(null != row.getCell(3)){excelUploadService.doSaveCateIdAvg(reqDataMap);};						
							//MC3
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(4), row.getCell(4));
							if(null != row.getCell(4)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MC4
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(5), row.getCell(5));
							if(null != row.getCell(5)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MC5
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(6), row.getCell(6));
							if(null != row.getCell(6)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MC6
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(7), row.getCell(7));
							if(null != row.getCell(7)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MC7
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(8), row.getCell(8));
							if(null != row.getCell(8)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MC8
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(9), row.getCell(9));
							if(null != row.getCell(9)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MC9
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(10), row.getCell(10));
							if(null != row.getCell(10)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
														
							System.out.println("==========================================================================");
						}
					}
				}
				//==========================================================================================
				//================================ Panamax 두번째 시트 ===========================================
				XSSFSheet panaSheet = xWorkbook.getSheetAt(5);
				Iterator<Row> panaRowIter = panaSheet.iterator();
				while(panaRowIter.hasNext()){
					Row row = panaRowIter.next();
					if(row.getRowNum() >= 1 && null != row.getCell(0).getDateCellValue()){
						if(!row.getZeroHeight()){
							String vsIdxDD = sdf.format(row.getCell(0).getDateCellValue());							
							System.out.println("날짜 : "+ vsIdxDD + "============================================================");
							
							// ================= 파나막스 운임 ===================
							//MP1
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(1), row.getCell(1));
							if(null != row.getCell(1)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MP2
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(2), row.getCell(2));
							if(null != row.getCell(2)){excelUploadService.doSaveCateIdAvg(reqDataMap);};						
							//MP3
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(3), row.getCell(3));
							if(null != row.getCell(3)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MP4
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(5), row.getCell(5));
							if(null != row.getCell(5)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MP5
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(6), row.getCell(6));
							if(null != row.getCell(6)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MP6
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(7), row.getCell(7));
							if(null != row.getCell(7)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MP7
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(8), row.getCell(8));
							if(null != row.getCell(8)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
						}
					}
				}
				
				// Supramax =================================================
				XSSFSheet supraSheet = xWorkbook.getSheetAt(6);
				Iterator<Row> supraRowIter = supraSheet.iterator();
				while(supraRowIter.hasNext()){
					Row row = supraRowIter.next();
					if(row.getRowNum() >= 1 && null != row.getCell(0).getDateCellValue()){
						if(!row.getZeroHeight()){
							//MS1 ~ MS7 까지의 평균값
							String vsIdxDD = sdf.format(row.getCell(0).getDateCellValue());
							System.out.println("날짜 : "+ vsIdxDD + "============================================================");
							
							// ================= 수프라막스 운임 ===================
							//MS1
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(2), row.getCell(2));
							if(null != row.getCell(2)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MS2
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(3), row.getCell(3));
							if(null != row.getCell(3)){excelUploadService.doSaveCateIdAvg(reqDataMap);};						
							//MS3
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(4), row.getCell(4));
							if(null != row.getCell(4)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MS4
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(5), row.getCell(5));
							if(null != row.getCell(5)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MS5
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(6), row.getCell(6));
							if(null != row.getCell(6)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MS6
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(7), row.getCell(7));
							if(null != row.getCell(7)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MS7
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(8), row.getCell(8));
							if(null != row.getCell(8)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
						}
					}
				}
				//===========================================================
				// Handysize =================================================
				XSSFSheet handySheet = xWorkbook.getSheetAt(7);
				Iterator<Row> handyRowIter = handySheet.iterator();
				while(handyRowIter.hasNext()){
					Row row = handyRowIter.next();
					if(row.getRowNum() >= 4 && null != row.getCell(0).getDateCellValue()){
						if(!row.getZeroHeight()){
							String vsIdxDD = sdf.format(row.getCell(0).getDateCellValue());
							System.out.println("날짜 : "+ vsIdxDD + "============================================================");
							
							// ================= 수프라막스 운임 ===================
							//MH1
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(1), row.getCell(1));
							if(null != row.getCell(1)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MH2
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(2), row.getCell(2));
							if(null != row.getCell(2)){excelUploadService.doSaveCateIdAvg(reqDataMap);};						
							//MH3
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(3), row.getCell(3));
							if(null != row.getCell(3)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MH4
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(4), row.getCell(4));
							if(null != row.getCell(4)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MH5
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(5), row.getCell(5));
							if(null != row.getCell(5)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
						}
					}
				}
				//===========================================================
			}else{
				Map<String, Object> reqDataMap = null;
				hWorkbook = new HSSFWorkbook(fis);
				
				//================================ Capesize 첫번째 시트 ===========================================
				HSSFSheet atenSheet = hWorkbook.getSheetAt(4);
				Iterator<Row> rowIter = atenSheet.iterator();
				while(rowIter.hasNext()){
					Row row = rowIter.next();
					if(row.getRowNum() >= 1 && null != row.getCell(0).getDateCellValue()){
												
						if(!row.getZeroHeight()){
							String vsIdxDD = sdf.format(row.getCell(0).getDateCellValue());
							System.out.println("날짜 : "+ vsIdxDD + "============================================================");
							
							// ================= 케이프 운임 ===================
							//MC1
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(1), row.getCell(1));
							if(null != row.getCell(1)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MC2
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(3), row.getCell(3));
							if(null != row.getCell(3)){excelUploadService.doSaveCateIdAvg(reqDataMap);};						
							//MC3
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(4), row.getCell(4));
							if(null != row.getCell(4)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MC4
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(5), row.getCell(5));
							if(null != row.getCell(5)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MC5
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(6), row.getCell(6));
							if(null != row.getCell(6)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MC6
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(7), row.getCell(7));
							if(null != row.getCell(7)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MC7
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(8), row.getCell(8));
							if(null != row.getCell(8)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MC8
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(9), row.getCell(9));
							if(null != row.getCell(9)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MC9
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(10), row.getCell(10));
							if(null != row.getCell(10)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
														
							System.out.println("==========================================================================");
						}
					}
				}
				//==========================================================================================
				//================================ Panamax 두번째 시트 ===========================================
				HSSFSheet panaSheet = hWorkbook.getSheetAt(5);
				Iterator<Row> panaRowIter = panaSheet.iterator();
				while(panaRowIter.hasNext()){
					Row row = panaRowIter.next();
					if(row.getRowNum() >= 1 && null != row.getCell(0).getDateCellValue()){
						if(!row.getZeroHeight()){
							String vsIdxDD = sdf.format(row.getCell(0).getDateCellValue());							
							System.out.println("날짜 : "+ vsIdxDD + "============================================================");
							
							// ================= 파나막스 운임 ===================
							//MP1
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(1), row.getCell(1));
							if(null != row.getCell(1)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MP2
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(2), row.getCell(2));
							if(null != row.getCell(2)){excelUploadService.doSaveCateIdAvg(reqDataMap);};						
							//MP3
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(3), row.getCell(3));
							if(null != row.getCell(3)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MP4
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(5), row.getCell(5));
							if(null != row.getCell(5)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MP5
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(6), row.getCell(6));
							if(null != row.getCell(6)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MP6
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(7), row.getCell(7));
							if(null != row.getCell(7)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MP7
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(8), row.getCell(8));
							if(null != row.getCell(8)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
						}
					}
				}
				
				// Supramax =================================================
				HSSFSheet supraSheet = hWorkbook.getSheetAt(6);
				Iterator<Row> supraRowIter = supraSheet.iterator();
				while(supraRowIter.hasNext()){
					Row row = supraRowIter.next();
					if(row.getRowNum() >= 1 && null != row.getCell(0).getDateCellValue()){
						if(!row.getZeroHeight()){
							//MS1 ~ MS7 까지의 평균값
							String vsIdxDD = sdf.format(row.getCell(0).getDateCellValue());
							System.out.println("날짜 : "+ vsIdxDD + "============================================================");
							
							// ================= 수프라막스 운임 ===================
							//MS1
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(2), row.getCell(2));
							if(null != row.getCell(2)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MS2
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(3), row.getCell(3));
							if(null != row.getCell(3)){excelUploadService.doSaveCateIdAvg(reqDataMap);};						
							//MS3
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(4), row.getCell(4));
							if(null != row.getCell(4)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MS4
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(5), row.getCell(5));
							if(null != row.getCell(5)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MS5
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(6), row.getCell(6));
							if(null != row.getCell(6)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MS6
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(7), row.getCell(7));
							if(null != row.getCell(7)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MS7
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(8), row.getCell(8));
							if(null != row.getCell(8)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
						}
					}
				}
				//===========================================================
				// Handysize =================================================
				HSSFSheet handySheet = hWorkbook.getSheetAt(7);
				Iterator<Row> handyRowIter = handySheet.iterator();
				while(handyRowIter.hasNext()){
					Row row = handyRowIter.next();
					if(row.getRowNum() >= 4 && null != row.getCell(0).getDateCellValue()){
						if(!row.getZeroHeight()){
							String vsIdxDD = sdf.format(row.getCell(0).getDateCellValue());
							System.out.println("날짜 : "+ vsIdxDD + "============================================================");
							
							// ================= 수프라막스 운임 ===================
							//MH1
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(1), row.getCell(1));
							if(null != row.getCell(1)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MH2
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(2), row.getCell(2));
							if(null != row.getCell(2)){excelUploadService.doSaveCateIdAvg(reqDataMap);};						
							//MH3
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(3), row.getCell(3));
							if(null != row.getCell(3)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MH4
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(4), row.getCell(4));
							if(null != row.getCell(4)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
							//MH5
							reqDataMap = pushMapAvgData(reqDataMap, vsIdxDD, row.getSheet().getRow(0).getCell(5), row.getCell(5));
							if(null != row.getCell(5)){excelUploadService.doSaveCateIdAvg(reqDataMap);};
						}
					}
				}
				//===========================================================
			}
		}
		return returnMap;
	};
	
	public Map<String, Object> pushMapData(Map<String, Object> map, Object param1, Object param2, Object param3, Cell param4){
		map = new HashMap<String, Object>();
		map.put("IDX_DD", param1.toString());
		map.put("IDX_CATE_ID", param2.toString());
		map.put("PANEL_ID", param3.toString());
		
		String temp = String.valueOf(param4);
		if(StringUtils.isNumeric((CharSequence) temp)){
			map.put("IDX_VALUE", param4.getNumericCellValue());
		}else if(StringUtils.isEmpty((CharSequence) temp)){
			map.put("IDX_VALUE", 0);
		}else if(null == temp || "null" == temp || "" == temp){ 
			map.put("IDX_VALUE", 0);
		}else{
			map.put("IDX_VALUE", param4.getNumericCellValue());
		}
		return map;
	};
	
	public Map<String, Object> pushMapAvgData(Map<String, Object> map, Object param1, Object param2, Cell param4){
		map = new HashMap<String, Object>();
		map.put("IDX_DD", param1.toString());
		map.put("IDX_CATE_ID", param2.toString());
		
		String temp = String.valueOf(param4);
		if(StringUtils.isNumeric((CharSequence) temp)){
			map.put("IDX_VALUE", param4.getNumericCellValue());
		}else if(StringUtils.isEmpty((CharSequence) temp)){
			map.put("IDX_VALUE", 0);
		}else if(null == temp || "null" == temp || "" == temp){ 
			map.put("IDX_VALUE", 0);
		}else{
			map.put("IDX_VALUE", param4.getNumericCellValue());
		}
		return map;
	}

}
