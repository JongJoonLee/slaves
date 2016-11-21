package kr.co.techflower.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ngel.core.web.FrameworkController;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.techflower.service.BannerService;

@Controller
public class BannerController extends FrameworkController{

	private static final Logger logger = LoggerFactory.getLogger(BannerController.class);
	private static final String path = "C:/MEIC/WEBSITE/UploadFiles/banner/";
	private static final String linkPath = "/resources/uploadFiles/banner/";
	
	//private static final String testserverMeicPath = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/temp/2-meic#resources#uploadFiles/banner/";
	//private static final String testserverCmsPath = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/temp/0-cms#resources#uploadFiles/banner/";
	
	@Autowired
	BannerService bannerService;
	
	@RequestMapping(value="/doBannerFileDownload.do")
	public ModelAndView downloadAttachFile(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {
		Map<String, Object> reqMap = new HashMap<String, Object>();
		
		@SuppressWarnings("unchecked")
		Enumeration<String> parameterNames = req.getParameterNames();
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			String[] paramValues = req.getParameterValues(paramName);
			for (int i = 0; i < paramValues.length; i++) {
				String paramValue = paramValues[i];
				reqMap.put(paramName, paramValue);
			}
		};
		if(null != reqMap.get("filename") && !"".equals(reqMap.get("filename"))){			
			File file = new File(path, (String)reqMap.get("filename"));
			
			reqMap.put("file", file);
			reqMap.put("filename", reqMap.get("svg_filename"));
			reqMap.put("temp", false);
			return new ModelAndView("fileDownloadView", "fileParam", reqMap);
		}else{
			return new ModelAndView("fileDownloadView", "fileParam", reqMap);
		}
	};
	
	@RequestMapping(value="/doBannerSearch.do")
	@ResponseBody
	public List<Map<String, Object>> doSearch(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		logger.info("/doBannerSearch.do");
		Map<String, Object> reqMap = new HashMap<String, Object>();
		
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
		
		List<Map<String, Object>> list = bannerService.doSearch(reqMap);
		return list;
	};
	
	@RequestMapping(value="/doBannerSave.do")
	@ResponseBody
	public Map<String, Object> doSave(@RequestParam Map<String, Object> parameter, Model model, DefaultMultipartHttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> resMap = null;
		Object voRowType = parameter.get("rowType");
		String vsRowType = "";
		
		if(null != voRowType && !"".equals(voRowType)){
			vsRowType = (String) voRowType;
		}
		
		logger.info("/doBannerSave.do");
		Map<String, Object> reqMap = new HashMap<String, Object>();
		
		Enumeration<String> parameterNames = req.getParameterNames();
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			String[] paramValues = req.getParameterValues(paramName);
			for (int i = 0; i < paramValues.length; i++) {
				String paramValue = paramValues[i];
				reqMap.put(paramName, paramValue);
			}
		}
		
		int resultCnt = 0;
		//파일은 없어도 우선 신규시 무조건 TB_FILE 테이블에 넣어준다.
		if("C".equals(vsRowType)){
			if("undefined".equals(parameter.get("files"))){
				//파일 선택을 하지 않았기 때문에 TB_BANNER, TB_FILE 테이블의 정보만 신규 등록을 해준다.
				reqMap.put("REG_ID", "ADMIN");
				Map<String, Object> reqDetailMap = bannerService.doInsert(reqMap);
				
				reqMap.put("BANNER_ID", reqDetailMap.get("BANNER_ID"));
				reqMap.put("TBL_PK", reqDetailMap.get("BANNER_ID"));
				reqMap.put("REG_ID", "ADMIN");
				resultCnt = bannerService.doInsertFile(reqMap);
			}else{
				//파일을 선택 하였기 때문에 TB_BANNER, TB_FILE 테이블의 정보를 신규 등록
				//파일 업로드도 같이 수행을 한다.
				//resMap = fileUpload(req);
				Map<String, Object> reqDetailMap = bannerService.doInsert(reqMap); 
				resMap = fileUpload(req);
				resMap.put("BANNER_ID", reqDetailMap.get("BANNER_ID"));
				resMap.put("TBL_PK", reqDetailMap.get("BANNER_ID"));
				resMap.put("REG_ID", "ADMIN");
				resultCnt = bannerService.doInsertFile(resMap);
			}
		}else if("D".equals(vsRowType)){
			//TB_BANNER, TB_FILE 테이블의 데이터 삭제
			bannerService.doDelete(reqMap);
		}else if("U".equals(vsRowType)){
			
			List<MultipartFile> voList = req.getFiles("files");
						
			if("undefined".equals(parameter.get("files")) || voList.isEmpty()){
				//파일 선택을 하지 않았기 때문에 TB_BANNER 테이블의 정보만 업데이트를 해준다.
				bannerService.doUpdate(reqMap);
			}else{
				//파일 선택을 하였기 때문에 TB_FILE 테이블의 정보도 수정, 파일 업로드도 해준다.
				//resMap = fileUpload(req);
				Map<String, Object> reqDetailMap = bannerService.doUpdate(reqMap);
				resMap = fileUpload(req);
				reqDetailMap.put("FILE_SIZE", resMap.get("FILE_SIZE"));
				reqDetailMap.put("FILE_NM", resMap.get("FILE_NM"));
				reqDetailMap.put("SVR_FILE_NM", resMap.get("SVR_FILE_NM"));
				bannerService.doUpdateFile(reqDetailMap);
			}
		}
		
		resMap = new HashMap<String, Object>();
		if(resultCnt > 0){
			resMap.put("resultVal", "success");
		}else{
			resMap.put("resultVal", "fail");
		}
		return resMap;
	};
	
	/**
	 * 파일 업로드
	 * @param req
	 * @return
	 * @throws Exception
	 */
	public static Map<String, Object> fileUpload(DefaultMultipartHttpServletRequest req) throws Exception{
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<MultipartFile> voList = req.getFiles("files");
		
		if (!voList.isEmpty() && voList.size() > 0) {
			returnMap.put("FILE_SIZE", voList.get(0).getSize());
			returnMap.put("FILE_NM", voList.get(0).getOriginalFilename());

			for (int i = 0; i < voList.size(); i++) {
				UUID randomeUUID = UUID.randomUUID();
				InputStream inputStream = null;
				OutputStream outputStream = null;
				/*InputStream inputStream1 = null;
				OutputStream outputStream1 = null;
				InputStream inputStream2 = null;
				OutputStream outputStream2 = null;*/

				try {

					inputStream = voList.get(i).getInputStream();
					File realUploadDir = new File(path);
					if (!realUploadDir.exists()) {
						realUploadDir.mkdirs();
					}
					String organizedfilePath = path + randomeUUID + "_"
							+ voList.get(i).getOriginalFilename();
					returnMap.put("SVR_FILE_NM", randomeUUID + "_"
							+ voList.get(i).getOriginalFilename());
					outputStream = new FileOutputStream(organizedfilePath);
					int readByte = 0;
					byte[] buffer = new byte[8192];
					while ((readByte = inputStream.read(buffer, 0, 8120)) != -1) {
						outputStream.write(buffer, 0, readByte);
					}
					
					//------------------------------------------------------------
					/*inputStream1 = voList.get(i).getInputStream();
					File realUploadDir1 = new File(testserverMeicPath);
					if (!realUploadDir1.exists()) {
						realUploadDir1.mkdirs();
					}
					String organizedfilePath1 = testserverMeicPath + randomeUUID + "_"
							+ voList.get(i).getOriginalFilename();
					outputStream1 = new FileOutputStream(organizedfilePath1);
					int readByte1 = 0;
					byte[] buffer1 = new byte[8192];
					while ((readByte1 = inputStream1.read(buffer1, 0, 8120)) != -1) {
						outputStream1.write(buffer1, 0, readByte1);
					}
					//------------------------------------------------------------
					//------------------------------------------------------------
					inputStream2 = voList.get(i).getInputStream();
					File realUploadDir2 = new File(testserverCmsPath);
					if (!realUploadDir2.exists()) {
						realUploadDir2.mkdirs();
					}
					String organizedfilePath2 = testserverCmsPath + randomeUUID + "_"
							+ voList.get(i).getOriginalFilename();
					outputStream2 = new FileOutputStream(organizedfilePath2);
					int readByte2 = 0;
					byte[] buffer2 = new byte[8192];
					while ((readByte2 = inputStream2.read(buffer2, 0, 8120)) != -1) {
						outputStream2.write(buffer2, 0, readByte2);
					}*/
					//------------------------------------------------------------
				} catch (Exception e) {
					e.printStackTrace();
					returnMap.put("result", true);
				} finally {
					outputStream.close();
					inputStream.close();
					/*outputStream1.close();
					inputStream1.close();
					outputStream2.close();
					inputStream2.close();*/
					returnMap.put("result", false);
				}
			}
		}
		return returnMap;
	}
	
}
