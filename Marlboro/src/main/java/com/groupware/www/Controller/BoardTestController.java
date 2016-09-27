package com.groupware.www.Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.groupware.www.Dao.BoardTestDAO;
import com.groupware.www.Utill.FileUtil;
import com.groupware.www.Vo.BoardReplyVO;
import com.groupware.www.Vo.BoardVO;
import com.groupware.www.Vo.FileVO;
import com.groupware.www.Vo.SearchVO;



@Controller 
public class BoardTestController {

    @Autowired
    private BoardTestDAO boardDao;
    
    /**
     * Î¶¨Ïä§?ä∏.
     */
    @RequestMapping(value = "/board7List")
    public String boardList(SearchVO searchVO, ModelMap modelMap) {

        searchVO.pageCalculate( boardDao.selectBoardCount(searchVO) ); // startRow, endRow

        List<?> listview  = boardDao.selectBoardList(searchVO);
        
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("searchVO", searchVO);
        
        return "board7/BoardList";
    }
    
    /** 
     * Í∏? ?ì∞Í∏?. 
     */
    @RequestMapping(value = "/board7Form")
    public String boardForm(HttpServletRequest request, ModelMap modelMap) {
        String brdno = request.getParameter("brdno");
        if (brdno != null) {
            BoardVO boardInfo = boardDao.selectBoardOne(brdno);
            List<?> listview = boardDao.selectBoard6FileList(brdno);
        
            modelMap.addAttribute("boardInfo", boardInfo);
            modelMap.addAttribute("listview", listview);
        }
        
        return "board7/BoardForm";
    }
    
    /**
     * Í∏? ???û•.
     */
    @RequestMapping(value = "/board7Save")
    public String boardSave(HttpServletRequest request, BoardVO boardInfo) {
        String[] fileno = request.getParameterValues("fileno");
        
        FileUtil fs = new FileUtil();
        List<FileVO> filelist = fs.saveAllFiles(boardInfo.getUploadfile());

        boardDao.insertBoard(boardInfo, filelist, fileno);

        return "redirect:/board7List";
    }

    /**
     * Í∏? ?ùΩÍ∏?.
     */
    @RequestMapping(value = "/board7Read")
    public String board7Read(HttpServletRequest request, ModelMap modelMap) {
        
        String brdno = request.getParameter("brdno");
        
        boardDao.updateBoard6Read(brdno);
        BoardVO boardInfo = boardDao.selectBoardOne(brdno);
        List<?> listview = boardDao.selectBoard6FileList(brdno);
        List<?> replylist = boardDao.selectBoard6ReplyList(brdno);
        
        modelMap.addAttribute("boardInfo", boardInfo);
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("replylist", replylist);
        
        return "board7/BoardRead";
        //return "board7/BoardReadAjax";
    }
    
    /**
     * Í∏? ?Ç≠?†ú.
     */
    @RequestMapping(value = "/board7Delete")
    public String boardDelete(HttpServletRequest request) {
        
        String brdno = request.getParameter("brdno");
        
        boardDao.deleteBoardOne(brdno);
        
        return "redirect:/board7List";
    }

    /* ===================================================================== */
    
    /**
     * ?åìÍ∏? ???û•.
     */
    @RequestMapping(value = "/board7ReplySave")
    public String board7ReplySave(HttpServletRequest request, BoardReplyVO boardReplyInfo) {
        
        boardDao.insertBoardReply(boardReplyInfo);

        return "redirect:/board7Read?brdno=" + boardReplyInfo.getBrdno();
    }
    
    /**
     * ?åìÍ∏? ???û• with Ajax.
     */
    @RequestMapping(value = "/board7ReplySaveAjax")
    public void board7ReplySaveAjax(HttpServletResponse response, BoardReplyVO boardReplyInfo) {
        ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json;charset=UTF-8");
        
        boardDao.insertBoardReply(boardReplyInfo);
        
        try {
            response.getWriter().print( mapper.writeValueAsString(boardReplyInfo.getReno()));
        } catch (IOException ex) {
            System.out.println("?ò§Î•?: ?åìÍ∏? ???û•?óê Î¨∏Ï†úÍ∞? Î∞úÏÉù?ñà?äµ?ãà?ã§.");
        }
    }

    /**
     * ?åìÍ∏? ???û•  with Ajax2.
     */
    @RequestMapping(value = "/board7ReplySaveAjax4Reply")
    public String board7ReplySaveAjax4Reply(BoardReplyVO boardReplyInfo, ModelMap modelMap) {
        
        boardDao.insertBoardReply(boardReplyInfo);

        modelMap.addAttribute("replyInfo", boardReplyInfo);
        
        return "board7/BoardReadAjax4Reply";
    }
    
    /**
     * ?åìÍ∏? ?Ç≠?†ú.
     */
    @RequestMapping(value = "/board7ReplyDelete")
    public String board7ReplyDelete(BoardReplyVO boardReplyInfo) {
        
        if (!boardDao.deleteBoard6Reply(boardReplyInfo.getReno()) ) {
            return "board7/BoardFailure";
        }
        return "redirect:/board7Read?brdno=" + boardReplyInfo.getBrdno();
    }
    
    /**
     * ?åìÍ∏? ?Ç≠?†ú with Ajax.
     */
    @RequestMapping(value = "/board7ReplyDeleteAjax")
    public void board7ReplyDeleteAjax(HttpServletResponse response, BoardReplyVO boardReplyInfo) {
        ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json;charset=UTF-8");
        
        try {
            if (!boardDao.deleteBoard6Reply(boardReplyInfo.getReno()) ) {
                response.getWriter().print(mapper.writeValueAsString("Fail"));
            } else {
                response.getWriter().print(mapper.writeValueAsString("OK"));
            }
        } catch (IOException ex) {
            System.out.println("?ò§Î•?: ?åìÍ∏? ?Ç≠?†ú?óê Î¨∏Ï†úÍ∞? Î∞úÏÉù?ñà?äµ?ãà?ã§.");
        }
    }
    
}
