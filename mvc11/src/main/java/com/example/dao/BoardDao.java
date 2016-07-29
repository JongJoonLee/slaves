package com.example.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.example.bean.B_Custom;
import com.example.bean.Board;
import com.example.bean.CustomSearchVO;
import com.example.bean.Member;


public class BoardDao extends SqlSessionDaoSupport {
	
	public List<Board> boardlist(int cnt){
		return this.getSqlSession().selectList("Board.getBoardList",cnt);
	}
	
	public List<Board> boardTitle(int cnt){
		return this.getSqlSession().selectList("Board.getBoardTitle",cnt);
	}
	
	
	public Board boardcontents(int no){
		
		return this.getSqlSession().selectOne("Board.getBoardContents",no);
		
	}
	
	public int getBoardDelete(int no){
		
		//this.getSqlSession().delete("Board.getBoardDelete", no);
			return this.getSqlSession().delete("Board.getBoardDelete", no);
		
	}
	
	
	

	
	public int boardCount( ){
		
		return this.getSqlSession().selectOne("Board.getBoardCount");
		
	}
	
	public List<Board> getBoardSearch(CustomSearchVO bsearch){
		return this.getSqlSession().selectList("Board.getBoardSearch", bsearch);

		
	}
	
	public int getListTot(CustomSearchVO bcp){
		return this.getSqlSession().selectOne("Board.getSearchTot", bcp);
		
	}
	
	public int insertBoard(Board nbd){
		return this.getSqlSession().insert("Board.insertBoard", nbd);
	}
	
	
	public int updateBoard(Board nbd){
		return this.getSqlSession().update("Board.updateBoard", nbd);
	}
	
	
	///////////////////// 공지사항 ////////////////////////////
	
	
	public List<Board> notice_boardlist(int cnt){
		return this.getSqlSession().selectList("Board.getNotice_BoardList",cnt);
	}
	
	public List<Board> notice_boardTitle(int cnt){
		return this.getSqlSession().selectList("Board.getNotice_BoardTitle",cnt);
	}
	
	
	public Board notice_boardcontents(int no){
		
		return this.getSqlSession().selectOne("Board.getNotice_BoardContents",no);
		
	}
	

	
	public int notice_boardCount( ){
		
		return this.getSqlSession().selectOne("Board.getNotice_BoardCount");
		
	}
	
	public List<Board> getNotice_BoardSearch(CustomSearchVO bsearch){
		return this.getSqlSession().selectList("Board.getNotice_BoardSearch", bsearch);

		
	}
	
	public int getNotice_ListTot(CustomSearchVO bcp){
		return this.getSqlSession().selectOne("Board.getNotice_SearchTot", bcp);
		
	}
	
	public int insertNotice_Board(Board nbd){
		return this.getSqlSession().insert("Board.insertNotice_Board", nbd);
	}
	
	
	public int updateNotice_Board(Board nbd){
		return this.getSqlSession().update("Board.updateNotice_Board", nbd);
	}
	
	
	public int getNotice_BoardDelete(int no){
		
		//this.getSqlSession().delete("Board.getBoardDelete", no);
			return this.getSqlSession().delete("Board.getNotice_BoardDelete", no);
		
	}
	
	
	
	/////////////////////공지사항끝////////////////////////////
	

	
	
}