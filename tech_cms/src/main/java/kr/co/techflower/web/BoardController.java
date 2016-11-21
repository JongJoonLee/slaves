package kr.co.techflower.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.techflower.service.BoardService;

@Controller
public class BoardController extends FrameworkController{

	@Autowired
	BoardService boardService; 
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	private static final String ROOT_PATH = "C:/MEIC/WEBSITE/UploadFiles/";
	private static final String path = "C:/MEIC/WEBSITE/UploadFiles/board/";
	private static final String linkPath = "/resources/uploadFiles/board/";
	
	@RequestMapping(value="/doSearchBoardComboList.do")
	@ResponseBody
	public List<Map<String, Object>> doComboSearch(HttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.info("/doSearchBoardComboList.do");
		
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
		
		List<Map<String, Object>> resList = boardService.doComboList(reqMap);
		return resList;
	};
	
	@RequestMapping(value="/doSearchBoardList.do")
	@ResponseBody
	public List<Map<String, Object>> doSearch(HttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.info("/doSearchBoardList.do");
		//client
		System.out.println(req.getRemoteAddr());
		//server
		System.out.println(req.getLocalAddr());
		
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
		System.out.println(reqMap);
		List<Map<String, Object>> resList = boardService.doSearchList(reqMap);
		return resList;
		
	};
	
	@RequestMapping(value="/doSaveBoardList.do")
	@ResponseBody
	public Map<String, Object> doSave(HttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.info("/doSaveBoardList.do");
		
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
		int resultCnt = 0;
		resultCnt = boardService.doSaveList(reqMap);
		if(resultCnt > 0){
			resMap.put("result", "true");
			resMap.put("resultValue", "완료");
		}else{
			resMap.put("result", "false");
			resMap.put("resultValue", "실패");
		}
		return resMap;	
		
	};
	
	@RequestMapping(value="/doUpdateBoardList.do")
	@ResponseBody
	public Map<String, Object> doUpdate(MultipartHttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.info("/doSaveBoardList.do");
		
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
		
		/*Iterator<String> itr =  req.getFileNames();		
		while(itr.hasNext()){
			MultipartFile mpf = req.getFile(itr.next());
		    String originFileName = mpf.getOriginalFilename();
		    
		    System.out.println(originFileName);
		    System.out.println(originFileName);
		    System.out.println(originFileName);
		    System.out.println(originFileName);
		    System.out.println(originFileName);
		    System.out.println(originFileName);
		    System.out.println(originFileName);
		}*/
		
		String remoteIp = req.getRemoteAddr();
		if("0:0:0:0:0:0:0:1".equals(remoteIp)){
			reqMap.put("REG_IP", "127.0.0.1");
		}else{
			reqMap.put("REG_IP", remoteIp);
		}
		List<MultipartFile> voList = req.getFiles("files");
		
		int resultCnt = 0;
		resultCnt = boardService.doUpdateList(reqMap);
		
		if(voList.isEmpty()){
			//파일 선택을 하지 않았기 때문에 TB_BOARD 테이블의 정보만 업데이트를 해준다.
			resultCnt = boardService.doUpdateList(reqMap);
		}else{
			//파일 선택을 하였기 때문에 TB_FILE 테이블의 정보도 수정, 파일 업로드도 해준다.
			//resMap = fileUpload(req);
			resultCnt = boardService.doUpdateList(reqMap);
			resMap = fileUpload(req);
			reqMap.put("FILE_SIZE", resMap.get("FILE_SIZE"));
			reqMap.put("FILE_NM", resMap.get("FILE_NM"));
			reqMap.put("SVR_FILE_NM", resMap.get("SVR_FILE_NM"));
			
			//파일이 있으면 업데이트
			//파일이 없으면 신규로 등록
			boardService.doUpdateFile(reqMap);
		}
		
		if(resultCnt > 0){
			resMap.put("result", "true");
			resMap.put("resultValue", "완료");
		}else{
			resMap.put("result", "false");
			resMap.put("resultValue", "실패");
		}
		return resMap;	
		
	};
	
	@RequestMapping(value="/goBoardPage.do"/*, method = RequestMethod.GET*/)
	public String goBoardPage(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		if(null != req.getParameter("boardDiv")){
			model.addAttribute("SEQ", req.getParameter("boardSeq"));
			if(null != req.getParameter("boardSeq") && !"".equals(req.getParameter("boardSeq"))){
				Map<String, Object> reqMap = new HashMap<String, Object>();
				reqMap.put("SEQ", req.getParameter("boardSeq"));
				List<Map<String, Object>> returnList = boardService.doSearchDetailList(reqMap);
				if(!returnList.isEmpty() && 0 < returnList.size()){
					model.addAttribute("dataList", returnList.get(0));
					List<Map<String, Object>> fileList = boardService.doSearchDetailFileList(reqMap);
					model.addAttribute("dataFileList", fileList);
				}
			}
			return "cms/"+req.getParameter("boardDiv");
		}
		return "cms/board";
	}
	
	@RequestMapping(value="/doFileDownLoad.do")
	public ModelAndView doFileDownLoad(HttpServletRequest req, HttpServletResponse res) throws Exception{
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
			String fullPath = "";
			if(null != reqMap.get("board_cd")){
				fullPath = path + reqMap.get("board_cd") + "/";
			}else{
				fullPath = path;
			}
			File fileFolder = new File(fullPath);
			if(!fileFolder.exists()) {
				fileFolder.mkdirs();
			}
			
			File file = new File(fullPath, (String)reqMap.get("svg_filename"));			
			
			reqMap.put("file", file);
			reqMap.put("filename", reqMap.get("svg_filename"));
			reqMap.put("temp", false);
			return new ModelAndView("fileDownloadView", "fileParam", reqMap);
		}else{
			return new ModelAndView("fileDownloadView", "fileParam", reqMap);
		}
	};
	
	/**
	 * 파일 업로드
	 * @param req
	 * @return
	 * @throws Exception
	 */
	public static Map<String, Object> fileUpload(MultipartHttpServletRequest req) throws Exception{
		
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
					req.getParameter("BOARD_CD");
					inputStream = voList.get(i).getInputStream();
					String fullPath = "";
					if(null != req.getParameter("BOARD_CD")){
						fullPath = path+req.getParameter("BOARD_CD")+"/";
					}else{
						fullPath = path;
					}
					
					File realUploadDir = new File(fullPath);					
					if (!realUploadDir.exists()) {
						realUploadDir.mkdirs();
					}
					String organizedfilePath = fullPath + randomeUUID + "_"
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
