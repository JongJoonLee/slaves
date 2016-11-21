package kr.co.techflower.web;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ngel.core.web.FrameworkController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;

import kr.co.techflower.service.PopupService;

@Controller
public class WebEditorController extends FrameworkController{

	@Autowired
	PopupService popupService;
	
	private static final String linkPath = "C:/MEIC/WEBSITE/UploadFiles/";
	private static final String contextLinkPath = "/resources/uploadFiles/";
	private static final String borderPath = "board/";
	private static final String popupPath = "popup/";
	private static final String bannerPath = "banner/";
	private static final String editorPath = "editor/";
	
	//테스트 서버
	//private static final String testserverMeicPath = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/temp/2-meic#resources#uploadFiles/";
	//private static final String testserverCmsPath = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/temp/0-cms#resources#uploadFiles/";
			
	@RequestMapping(value="/gotoNicPopup.do")
	public String goPopup(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		@SuppressWarnings("unchecked")
		Enumeration<String> parameterNames = req.getParameterNames();
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			String[] paramValues = req.getParameterValues(paramName);
			for (int i = 0; i < paramValues.length; i++) {
				String paramValue = paramValues[i];
				model.addAttribute(paramName, paramValue);
				reqMap.put(paramName, paramValue);
			}
		}
		//팝업관리에서 호출하였다면
		if(null != reqMap.get("POPUP_ID")){
			List<Map<String, Object>> returnList = popupService.doSearchList(reqMap);
			if(!returnList.isEmpty() && returnList.size() > 0){
				model.addAttribute("CONTENTS", returnList.get(0).get("CONTENTS"));
				model.addAttribute("TITLE", returnList.get(0).get("TITLE"));
			}
		}
		if(null != reqMap.get("PAGER")){
			return "cms/niceditorPopup/"+reqMap.get("PAGER");
		}
		return "cms/niceditorPopup/nicPopup";
	}
	
	@RequestMapping(value="/fileupload.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> doFileUploadTest(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> returnMap = new HashMap<String, Object>();		
		Map<String, Object> image = fileUpload((DefaultMultipartHttpServletRequest) req, linkPath, popupPath);

		returnMap.put("upload", image) ;
		return returnMap;
	}
	
	@RequestMapping(value="/fileuploadPopup.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> doFileUploadPopup(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> returnMap = new HashMap<String, Object>();		
		Map<String, Object> image = fileUpload((DefaultMultipartHttpServletRequest) req, linkPath, popupPath);
				
		returnMap.put("upload", image) ;
		return returnMap;
	}
	
	@RequestMapping(value="/fileuploadBanner.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> doFileUploadBanner(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> returnMap = new HashMap<String, Object>();		
		Map<String, Object> image = fileUpload((DefaultMultipartHttpServletRequest) req, linkPath, bannerPath);
		
		returnMap.put("upload", image) ;
		return returnMap;
	}
	
	@RequestMapping(value="/fileuploadBorder.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> doFileUploadBorder(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> returnMap = new HashMap<String, Object>();		
		Map<String, Object> image = fileUpload((DefaultMultipartHttpServletRequest) req, linkPath, borderPath);
		
		returnMap.put("upload", image) ;
		return returnMap;
	}
	
	@RequestMapping(value="/fileuploadEditor.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> doFileUploadEditor(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		Map<String, Object> returnMap = new HashMap<String, Object>();		
		Map<String, Object> image = fileUpload((DefaultMultipartHttpServletRequest) req, linkPath, editorPath);
		
		returnMap.put("upload", image) ;
		return returnMap;
	}
	
	
	/**
	 * 파일 업로드
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("resource")
	public static Map<String, Object> fileUpload(DefaultMultipartHttpServletRequest req, String rootPath, String psPath) throws Exception{
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		Map<String, Object> linksMap = new HashMap<String, Object>();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		Map<String, MultipartFile> testMap = req.getFileMap();
		
		resMap.put("name", null);
		resMap.put("title", null);
		resMap.put("caption", null);
		
		if(!testMap.isEmpty()){
			UUID randomeUUID = UUID.randomUUID();
			InputStream inputStream = null;
			OutputStream outputStream = null;

			try {
				Calendar calendar = Calendar.getInstance();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
				String dateUrl = dateFormat.format(calendar.getTime()) + "/";
				
				inputStream = testMap.get("image").getInputStream();
				File realUploadDir = new File(rootPath+psPath);
				if (!realUploadDir.exists()) {
					realUploadDir.mkdirs();
				}
				String organizedfilePath = rootPath+psPath + randomeUUID + "_"
						+ testMap.get("image").getOriginalFilename();
				outputStream = new FileOutputStream(organizedfilePath);
				int readByte = 0;
				byte[] buffer = new byte[8192];
				while ((readByte = inputStream.read(buffer, 0, 8120)) != -1) {
					outputStream.write(buffer, 0, readByte);
				}
				
				// 임시로 테스트 중========================================================
				/*inputStream = testMap.get("image").getInputStream();
				File realUploadDirMeic = new File(testserverMeicPath+psPath);
				if (!realUploadDirMeic.exists()) {
					realUploadDirMeic.mkdirs();
				}
				String organizedfilePathMeic = testserverMeicPath+psPath + randomeUUID + "_"
						+ testMap.get("image").getOriginalFilename();
				outputStream = new FileOutputStream(organizedfilePathMeic);
				int readByteMeic = 0;
				byte[] bufferMeic = new byte[8192];
				while ((readByteMeic = inputStream.read(bufferMeic, 0, 8120)) != -1) {
					outputStream.write(bufferMeic, 0, readByteMeic);
				}
				
				inputStream = testMap.get("image").getInputStream();
				File realUploadDirCms = new File(testserverCmsPath+psPath);
				if (!realUploadDirCms.exists()) {
					realUploadDirCms.mkdirs();
				}
				String organizedfilePathCms = testserverCmsPath+psPath + randomeUUID + "_"
						+ testMap.get("image").getOriginalFilename();
				outputStream = new FileOutputStream(organizedfilePathCms);
				int readByteCms = 0;
				byte[] bufferCms = new byte[8192];
				while ((readByteCms = inputStream.read(bufferCms, 0, 8120)) != -1) {
					outputStream.write(bufferCms, 0, readByteCms);
				}*/
				//==========================================================
				
				String contextPath = req.getContextPath() + contextLinkPath+psPath + randomeUUID + "_"
						+ testMap.get("image").getOriginalFilename();
				int fileIndex = contextPath.lastIndexOf(".");
				String contextName = contextPath.substring(0, fileIndex);
				
				resMap.put("hash", randomeUUID+ "_"
						+ testMap.get("image").getOriginalFilename());
				resMap.put("deletehash", randomeUUID+ "_"
						+ testMap.get("image").getOriginalFilename());
				linksMap.put("original", contextPath);
				linksMap.put("imgur_page", contextName);
				linksMap.put("delete_page", contextPath);
				linksMap.put("small_square", contextName+".jpg");
				linksMap.put("big_square", contextName+".jpg");
				linksMap.put("small_thumbnail", contextName+".jpg");
				linksMap.put("medium_thumbnail", contextName+".jpg");
				linksMap.put("large_thumbnail", contextName+".jpg");
				linksMap.put("huge_thumbnail", contextName+".jpg");
				
				SimpleDateFormat dateFormatDetail = new SimpleDateFormat("yyyyMMddHHmmss");
				resMap.put("datetime", dateFormatDetail.format(calendar.getTime()));
				//resMap.put("type", "image\\/png");
				resMap.put("type", "image");
				resMap.put("animated", "false");
				
				BufferedImage bimg = ImageIO.read(new File(organizedfilePath));
				resMap.put("width", bimg.getWidth());
				resMap.put("height", bimg.getHeight());
				resMap.put("size", testMap.get("image").getSize());
				
				resMap.put("views", 0);
				resMap.put("bandwidth", 0);
			} catch (Exception e) {
				e.printStackTrace();
				returnMap.put("result", true);
			} finally {
				outputStream.close();
				inputStream.close();
				returnMap.put("result", false);
				
				//src 태그를 통해서 넣어줘야 하기 때문에
				//project 내부에 파일을 위치시켜야 한다.
				//server에 deploy 를 시키게 되면 상관없지만
				//현재 이클립스 workspace rebuild 를 통해서 다시 빌드를 시켜줘야 하기 때문에
				//4초간의 텀을 둬서 빌드가 완료되길 기다려 줌
				Thread.sleep(4000);
			}
			
		}
		
		while(null == returnMap.get("result")){
			try {
			    Thread.sleep(1000);
			} catch(InterruptedException ex) {
				
			}
		}
		returnMap.put("image", resMap);
		returnMap.put("links", linksMap);		
			
		return returnMap;
	};
}
