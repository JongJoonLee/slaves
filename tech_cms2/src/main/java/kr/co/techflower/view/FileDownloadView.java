package kr.co.techflower.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class FileDownloadView extends AbstractView {

	public FileDownloadView() {
		setContentType("application/download; utf-8");
	}
	
	@Override
	@SuppressWarnings("unchecked")
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Map<String, Object> fileParam = (Map<String, Object>) model.get("fileMap");
		File file = null;
		if (fileParam.get("file") instanceof File) {
			file = (File)fileParam.get("file");
		}else{
			file = new File(fileParam.get("file").toString());
		}
		String filename = (String)fileParam.get("filename");
		boolean isTemp = fileParam.get("temp").equals("true");
		
		response.setContentType(getContentType());
		response.setContentLength((int)file.length());
		
		
		response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(filename, "utf-8") + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        
        OutputStream out = response.getOutputStream();
        FileInputStream fis = null;
        
        try {
            fis = new FileInputStream(file);
            FileCopyUtils.copy(fis, out);
        } catch(Exception e){
            e.printStackTrace();
        }finally{
            if(fis != null){
                try{
                    fis.close();
                }catch(Exception e){}
            }
        }
        
        out.flush();
        if(isTemp){
        	/**
        	 * 첨부파일을 리스트에서 받을 시 파일을 압축하여 다운.
        	 * 전송 후 압축된 파일을 삭제함.
        	 */
        	file.delete();
        }
	}

}
