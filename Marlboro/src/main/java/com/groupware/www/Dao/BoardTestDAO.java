package com.groupware.www.Dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionException;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.groupware.www.Vo.BoardReplyVO;
import com.groupware.www.Vo.BoardVO;
import com.groupware.www.Vo.FileVO;
import com.groupware.www.Vo.SearchVO;
	

@Service
public class BoardTestDAO {

    @Autowired
    private SqlSessionTemplate sqlSession;    
    @Autowired
    private DataSourceTransactionManager txManager;
        
    public Integer selectBoardCount(SearchVO param) {
        return sqlSession.selectOne("selectBoard6Count", param);
    }
    
    public List<?> selectBoardList(SearchVO param) {
        return sqlSession.selectList("selectBoard6List", param);
    }
    
    /**
     * �? ???��.
     */
    public void insertBoard(BoardVO param, List<FileVO> filelist, String[] fileno) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            if (param.getBrdno() == null || "".equals(param.getBrdno())) {
                 sqlSession.insert("insertBoard6", param);
            } else {
                sqlSession.update("updateBoard6", param);
            }
            
            if (fileno != null) {
                HashMap<String, String[]> fparam = new HashMap<String, String[]>();
                fparam.put("fileno", fileno);
                sqlSession.insert("deleteBoard6File", fparam);
            }
            
            for (FileVO f : filelist) {
                f.setParentPK(param.getBrdno());
                sqlSession.insert("insertBoard6File", f);
            }
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            System.out.println("?��?��?�� ???�� ?���?: " + ex.toString());
        }            
    }
 
    public BoardVO selectBoardOne(String param) {
        return sqlSession.selectOne("selectBoard6One", param);
    }
    
    public void updateBoard6Read(String param) {
        sqlSession.insert("updateBoard6Read", param);
    }
    
    public void deleteBoardOne(String param) {
        sqlSession.delete("deleteBoard6One", param);
    }
    
    public List<?> selectBoard6FileList(String param) {
        return sqlSession.selectList("selectBoard6FileList", param);
    }
    
    /* =============================================================== */
    public List<?> selectBoard6ReplyList(String param) {
        return sqlSession.selectList("selectBoard6ReplyList", param);
    }
    
    /**
     * ?���? ???��. 
     */
    public void insertBoardReply(BoardReplyVO param) {
        if (param.getReno() == null || "".equals(param.getReno())) {
            if (param.getReparent() != null) {
                BoardReplyVO replyInfo = sqlSession.selectOne("selectBoard6ReplyParent", param.getReparent());
                param.setRedepth(replyInfo.getRedepth());
                param.setReorder(replyInfo.getReorder() + 1);
                sqlSession.selectOne("updateBoard6ReplyOrder", replyInfo);
            } else {
                Integer reorder = sqlSession.selectOne("selectBoard6ReplyMaxOrder", param.getBrdno());
                param.setReorder(reorder);
            }
            
            sqlSession.insert("insertBoard6Reply", param);
        } else {
            sqlSession.insert("updateBoard6Reply", param);
        }
    }   
    
    /**
     * ?���? ?��?��.
     * ?��?�� ?���??�� ?��?���? ?��?�� ?��?��. 
     */
    public boolean deleteBoard6Reply(String param) {
        Integer cnt = sqlSession.selectOne("selectBoard6ReplyChild", param);
        
        if ( cnt > 0) {
            return false;
        }
        
        sqlSession.update("updateBoard6ReplyOrder4Delete", param);
        
        sqlSession.delete("deleteBoard6Reply", param);
        
        return true;
    }    
}
