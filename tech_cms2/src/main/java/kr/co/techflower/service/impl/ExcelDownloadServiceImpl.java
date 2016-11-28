package kr.co.techflower.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import kr.co.techflower.service.ExcelDownloadService;
import ngel.core.service.AbstractCommonService;

@Service("excelDownloadService")
public class ExcelDownloadServiceImpl extends AbstractCommonService implements ExcelDownloadService {

	@Override
	public Map<String, Object> createExcelFileUser(Map<String, Object> map) throws Exception {
		
		XSSFWorkbook workBook = new XSSFWorkbook();
		
		CellStyle cellStyle = workBook.createCellStyle();
		cellStyle.setBorderBottom(CellStyle.BORDER_THIN);
		cellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
		cellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setBorderRight(CellStyle.BORDER_THIN);
		cellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setBorderTop(CellStyle.BORDER_THIN);
		cellStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
		
		XSSFSheet sheet = (XSSFSheet)workBook.createSheet("사용자 정보");
		Row row = sheet.createRow(0);
		String[] array = {"사용자 ID","사용자 성명","사용자 구분","집 번호"
				,"폰 번호","회사명","회사구분","회사전화","부서명","직위","메일","탈퇴여부","인증키"
				,"인증일시","메일 수신여부", "가입일자", "탈퇴사유", "탈퇴일자", "상태"};
		RowFilledWithPojoHeader(array, workBook, row);
		
		List<Map<String, Object>> list = mapper.selectList("UserMapper.selectUserDataNonPagingList", map);
		
		if(!list.isEmpty()){
			for(int i = 0; i < list.size(); i++){
				row = sheet.createRow(i+1);
				//A.사용자 ID
				Cell cell = row.createCell(0);
				cell.setCellValue(null != list.get(i).get("USER_ID")?String.valueOf(list.get(i).get("USER_ID")):"");
				//B.사용자 성명
				cell = row.createCell(1);
				cell.setCellValue(null != list.get(i).get("USER_NM")?String.valueOf(list.get(i).get("USER_NM")):"");
				//C.사용자 구분
				
				String member = "";
				if(null != list.get(i).get("MEMBER_CLASS_CD")){
					if("*".equals(list.get(i).get("MEMBER_CLASS_CD"))){
						member = "비회원";
					}else if("00".equals(list.get(i).get("MEMBER_CLASS_CD"))){
						member = "시스템 관리자";
					}else if("10".equals(list.get(i).get("MEMBER_CLASS_CD"))){
						member = "슈퍼 관리자";
					}else if("20".equals(list.get(i).get("MEMBER_CLASS_CD"))){
						member = "일반 관리자";
					}else if("30".equals(list.get(i).get("MEMBER_CLASS_CD"))){
						member = "패널";
					}else if("40".equals(list.get(i).get("MEMBER_CLASS_CD"))){
						member = "유료회원";
					}else if("50".equals(list.get(i).get("MEMBER_CLASS_CD"))){
						member = "무료회원";
					}
				}else{
					member = "";
				};
				
				cell = row.createCell(2);
				cell.setCellValue(member);
				//D.집번호
				cell = row.createCell(3);
				cell.setCellValue(null != list.get(i).get("USER_PHONE")?String.valueOf(list.get(i).get("USER_PHONE")):"");
				//E.폰번호
				cell = row.createCell(4);
				cell.setCellValue(null != list.get(i).get("USER_MOBILE")?String.valueOf(list.get(i).get("USER_MOBILE")):"");
				//F.회사명
				cell = row.createCell(5);
				cell.setCellValue(null != list.get(i).get("COMP_NM")?String.valueOf(list.get(i).get("COMP_NM")):"");
				//G.회사구분
				cell = row.createCell(6);
				cell.setCellValue(null != list.get(i).get("COMP_CLASS_CD")?String.valueOf(list.get(i).get("COMP_CLASS_CD")):"");
				//H.회사전화
				cell = row.createCell(7);
				cell.setCellValue(null != list.get(i).get("COMP_PHONE")?String.valueOf(list.get(i).get("COMP_PHONE")):"");
				//I.부서명
				cell = row.createCell(8);
				cell.setCellValue(null != list.get(i).get("PART_NM")?String.valueOf(list.get(i).get("PART_NM")):"");
				//J.직위
				cell = row.createCell(9);
				cell.setCellValue(null != list.get(i).get("POSITION")?String.valueOf(list.get(i).get("POSITION")):"");
				//K.메일
				cell = row.createCell(10);
				cell.setCellValue(null != list.get(i).get("USER_EMAIL")?String.valueOf(list.get(i).get("USER_EMAIL")):"");
				//L.탈퇴여부
				cell = row.createCell(11);
				cell.setCellValue(null != list.get(i).get("DEL_YN")?String.valueOf(list.get(i).get("DEL_YN")):"");
				//M.인증키
				cell = row.createCell(12);
				cell.setCellValue(null != list.get(i).get("CERTIFY_KEY")?String.valueOf(list.get(i).get("CERTIFY_KEY")):"");
				//N.인증일시
				cell = row.createCell(13);
				cell.setCellValue(null != list.get(i).get("CERTIFY_DT")?String.valueOf(list.get(i).get("CERTIFY_DT")):"");
				//O.메일수신여부
				cell = row.createCell(14);
				cell.setCellValue(null != list.get(i).get("USER_EMAIL_RECEIVE")?String.valueOf(list.get(i).get("USER_EMAIL_RECEIVE")):"");
				//P.가입일자
				cell = row.createCell(15);
				cell.setCellValue(null != list.get(i).get("REG_DT")?String.valueOf(list.get(i).get("REG_DT")):"");
				//Q.탈퇴사유
				cell = row.createCell(16);
				cell.setCellValue(null != list.get(i).get("LEAVE_DESCRIPTION")?String.valueOf(list.get(i).get("LEAVE_DESCRIPTION")):"");
				//R.탈퇴일자
				cell = row.createCell(17);
				cell.setCellValue(null != list.get(i).get("LEAVE_DT")?String.valueOf(list.get(i).get("LEAVE_DT")):"");
				//S.상태
				cell = row.createCell(18);
				cell.setCellValue(null != list.get(i).get("STATUS")?String.valueOf(list.get(i).get("STATUS")):"");
			}
		}
		
		String dateStr = new SimpleDateFormat("yyyyMMdd").format(new Date());
		String fileFullNm = "C:/MEIC/WEBSITE/UploadFiles/board/MEIC_" + dateStr + ".xlsx";
		File realFile = new File(fileFullNm);

		FileOutputStream fos = new FileOutputStream(realFile);
		workBook.write(fos);
		fos.close();
		
		Map<String, Object> fileParam = new HashMap<String, Object>();
		fileParam.put("filename", "MEIC_"+ dateStr + ".xlsx");
		fileParam.put("file", realFile);
		fileParam.put("temp", true);
		return fileParam;
	};
	
	private static Row RowFilledWithPojoHeader(String[] pojoObject, Workbook wb, Row row) throws IllegalAccessException, IllegalArgumentException, InvocationTargetException, NoSuchMethodException, SecurityException {
		CellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		cellStyle.setBorderBottom(CellStyle.BORDER_DOUBLE);
		cellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
		cellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		cellStyle.setBorderRight(CellStyle.BORDER_THIN);
		cellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
		
		int objLength = pojoObject.length;
		for (int i = 0; i < objLength; i++) {
			String cellValue = pojoObject[i].toUpperCase();
			row.setHeightInPoints(25);
			Cell cell = row.createCell(i);
			convertDataType(cell, cellValue);
			//cell.setCellValue(cellValue);
			cell.setCellStyle(cellStyle);
		}
		return row;
	};
	
	/**
	 * value 값 셋팅
	 * @param cell
	 * @param data
	 */
	public static void convertDataType (Cell cell, Object data){
		if(StringUtils.isBlank((CharSequence) data)){
			cell.setCellValue((String) data);
		}else if(StringUtils.isNumeric((CharSequence) data)){
			cell.setCellValue(Double.parseDouble(String.valueOf(data)));
		}else if(StringUtils.isEmpty((CharSequence) data)){
			cell.setCellValue("");
		}else if(data instanceof Double){
			cell.setCellValue((Double)data);
		}else if(data instanceof Float){
			cell.setCellValue((Float)data);
		}else{
			cell.setCellValue((String) data);
		}
	};

}
