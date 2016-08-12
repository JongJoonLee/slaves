package com.example.dao;

import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.example.bean.Member;

public class MemberDao extends SqlSessionDaoSupport {

	public void join(Member mem) {
		//System.out.println(mem.getId());
		this.getSqlSession().insert("Member.addMember", mem);
	}

	public String getCheckUserId(String id) {
		return this.getSqlSession().selectOne("Member.getCheckUserId", id);
	}

	
	public Member login(Member mem) {
		return this.getSqlSession().selectOne("Member.login", mem);
	}
	
	public boolean logintest(Member mem) {
		return this.getSqlSession().selectOne("Member.logintest", mem);
	}

	public Member appGetMemberOne(String id) {
		Member tmp = this.getSqlSession().selectOne("Member.appGetMemberOne", id);
		return tmp;

		// return this.getSqlSession().selectOne("Member.appGetMemberOne", id);
	}

	public int appMemberEdit(Member member) {
		return this.getSqlSession().update("Member.appMemberEdit", member);
	}
	
	public int chkMbId(String mbId) throws Exception {
		  return this.getSqlSession().selectOne("Member.chkMbId", mbId);
		 }
	
	

}
