package com.groupware.www.Dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.groupware.www.Vo.NoticeBoardVO;


public class NoticeBoardDao extends SqlSessionDaoSupport {


	
	
	public List<NoticeBoardVO> boardlist() {
		return this.getSqlSession().selectList("Board.getBoardList");	
	}
	public int boardCount() {

		return this.getSqlSession().selectOne("Board.getBoardCount");

	}
/*	public List<NoticeBoardVO> boardTitle(int cnt) {
		return this.getSqlSession().selectList("Board.getBoardTitle", cnt);
	}

	public NoticeBoardVO boardcontents(int no) {

		return this.getSqlSession().selectOne("Board.getBoardContents", no);

	}

	public int getBoardDelete(int no) {

		// this.getSqlSession().delete("Board.getBoardDelete", no);
		return this.getSqlSession().delete("Board.getBoardDelete", no);

	}

	

	


	public int insertBoard(NoticeBoardVO nbd) {
		return this.getSqlSession().insert("Board.insertBoard", nbd);
	}

	public int updateBoard(NoticeBoardVO nbd) {
		return this.getSqlSession().update("Board.updateBoard", nbd);
	}

	public int updateHit(Map<String, Integer> map) {

		return this.getSqlSession().update("Board.updateHit", map);
	}*/
}
