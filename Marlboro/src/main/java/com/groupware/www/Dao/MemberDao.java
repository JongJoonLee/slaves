package com.groupware.www.Dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.groupware.www.Vo.MemberVO;

public class MemberDao extends SqlSessionDaoSupport {
	
	public MemberVO memberlist() {
		return (MemberVO) this.getSqlSession().selectList("Member.getMemberList");	
	}
	
}
