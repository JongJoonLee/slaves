package com.its.prj.mybatis;

import java.io.*;

import org.apache.ibatis.io.*;
import org.apache.ibatis.session.*;

public class SqlMapClient {
	private static SqlSession session;

	static {
		try {
			String resource = "myConfig.xml";
			Reader reader = Resources.getResourceAsReader(resource);
			SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);

			session = sqlMapper.openSession();

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static SqlSession getSqlSession() {
		return session;
	}
}
