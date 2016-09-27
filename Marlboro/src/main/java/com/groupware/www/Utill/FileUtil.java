package com.groupware.www.Utill;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.groupware.www.Vo.FileVO;

public class FileUtil {
    /**
     * ??Ό ?λ‘λ.
     */
    public List<FileVO> saveAllFiles(List<MultipartFile> upfiles) {
        String filePath = "c:\\groupware\\fileupload\\"; 
        List<FileVO> filelist = new ArrayList<FileVO>();

        for (MultipartFile uploadfile : upfiles ) {
            if (uploadfile.getSize() == 0) {
                continue;
            }
            
            String newName = getNewName();
            
            saveFile(uploadfile, filePath + "/" + newName.substring(0,4) + "/", newName);
            
            FileVO filedo = new FileVO();
            filedo.setFilename(uploadfile.getOriginalFilename());
            filedo.setRealname(newName);
            filedo.setFilesize(uploadfile.getSize());
            filelist.add(filedo);
        }
        return filelist;
    }    
    
    /**
     * ??Ό ???₯ κ²½λ‘ ??±.
     */
    public void makeBasePath(String path) {
        File dir = new File(path); 
        if (!dir.exists()) {
            dir.mkdirs();
        }
    }

    /**
     * ?€?  ??Ό ???₯.
     */
    public String saveFile(MultipartFile file, String basePath, String fileName){
        if (file == null || file.getName().equals("") || file.getSize() < 1) {
            return null;
        }
     
        makeBasePath(basePath);
        String serverFullPath = basePath + fileName;
  
        File file1 = new File(serverFullPath);
        try {
            file.transferTo(file1);
        } catch (IllegalStateException ex) {
            System.out.println("IllegalStateException: " + ex.toString());
        } catch (IOException ex) {
            System.out.println("IOException: " + ex.toString());
        }
        
        return serverFullPath;
    }
    
    /**
     * ? μ§λ‘ ?λ‘μ΄ ??Όλͺ? λΆ??¬.
     */
    public String getNewName() {
        SimpleDateFormat ft = new SimpleDateFormat("yyyyMMddhhmmssSSS");
        return ft.format(new Date()) + (int) (Math.random() * 10);
    }
    
    public String getFileExtension(String filename) {
          Integer mid = filename.lastIndexOf(".");
          return filename.substring(mid, filename.length());
    }

    public String getRealPath(String path, String filename) {
        return path + filename.substring(0,4) + "/";
    }
}
