package com.example.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.example.bean.ItemVO;

public class ItemDAO extends SqlSessionDaoSupport{
	
	public List<ItemVO> getItemList(int cnt){
		return this.getSqlSession().selectList("Item.getItemList",cnt);
	}

}
