package com.example.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.cache.decorators.SerializedCache.CustomObjectInputStream;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.example.bean.AccountVO;
import com.example.bean.B_Custom;
import com.example.bean.Board;
import com.example.bean.CustomSearchVO;
import com.example.bean.MyaccountVO;

public class CustomDAO extends SqlSessionDaoSupport {

	public void insertBcustom(B_Custom bcustom) {

		this.getSqlSession().insert("Bcustom.addBcustom", bcustom);
	}
	
	public List<B_Custom> customList(int cnt){
		
		return this.getSqlSession().selectList("Bcustom.getCustomList", cnt);
	}
	
	//getSearchList
	
	public List<B_Custom> getSearchList(CustomSearchVO bcp){
		return this.getSqlSession().selectList("Bcustom.getSearchList", bcp);

		
	}
	
	public int getListTot(CustomSearchVO bcp){
		return this.getSqlSession().selectOne("Bcustom.getSearchTot", bcp);
		
	}
	
	
	public void insertmkaccount(AccountVO AVO) {

		this.getSqlSession().insert("Bcustom.insertmkaccount", AVO);
	}
	
/*	public List<MyaccountVO> MyaccountList(int c_id){
		return this.getSqlSession().selectList("Bcustom.getMyaccount");
	}*/
	
	public List<MyaccountVO> MyaccountList(int c_id){
		return this.getSqlSession().selectList("Bcustom.getMyaccount", c_id);
	}
	public int getCustomCount( ){
		
		return this.getSqlSession().selectOne("Bcustom.getCustomCount");
		
	}
	
	
	
	
	
	
}
