package com.groupware.www.Dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;


import com.groupware.www.Vo.MasterVO;

import com.groupware.www.Vo.TimelineVO;

public class TimelineDao extends SqlSessionDaoSupport {
	
	public List<TimelineVO> timelinelist() {
		return this.getSqlSession().selectList("Timeline.getTimelineList");	
	}
	

	public List<MasterVO> timelinelistfinal() {
		return this.getSqlSession().selectList("Timeline.getTimelineFinal");	
	}
	
	public int insertTimeline(TimelineVO tvo) {
		return this.getSqlSession().insert("Timeline.insertTimeline", tvo);
	}

}
