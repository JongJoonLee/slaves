package com.groupware.www.Dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.groupware.www.Vo.MemberVO;

public class MemberDao extends SqlSessionDaoSupport {
	
	public List<MemberVO> memberlist(int no) {
		return this.getSqlSession().selectList("Member.getMemberList",no);	
	}

	public MemberVO login(MemberVO member) {
		return this.getSqlSession().selectOne("Member.login", member);
	}
	
	
	
}
