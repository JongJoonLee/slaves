package com.its.prj;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.apache.ibatis.session.*;

import com.its.prj.bean.*;
import com.its.prj.mybatis.*;
import com.its.prj.bean.*;
import com.its.prj.mybatis.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String ret = null;

	public LoginServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ret = request.getParameter("ret");

		request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if (ret == null) {
			ret = "index";
		}

		String a = request.getParameter("id");
		String b = request.getParameter("pw");
		// System.out.println(a+b);

		SqlSession sqlsession = SqlMapClient.getSqlSession();
		Member smem = new Member();
		smem.setId(a);
		smem.setPassword(b);

		Member rmem = sqlsession.selectOne("Member.login", smem);
		if (rmem != null) {
			HttpSession session1 = request.getSession();
			session1.setAttribute("_id", rmem.getId());
			session1.setAttribute("_name", rmem.getName());

			response.sendRedirect(ret);

			// System.out.println(a);
		} else {
			System.out.println("에라라라라라");
		}

	}
}