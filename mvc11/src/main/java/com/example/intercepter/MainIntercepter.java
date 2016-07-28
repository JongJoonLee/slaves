package com.example.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class MainIntercepter extends HandlerInterceptorAdapter {

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//System.out.print("preHander");
		//세션이 있으냐?
		
		HttpSession session = request.getSession();
		

		//true conteroller가 실행 됨.
		//false 가 되면 중지됨.
		return true;
	}
/*
	 @Override
	    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	        try {
	            //admin이라는 세션key를 가진 정보가 널일경우 로그인페이지로 이동
	            if(request.getSession().getAttribute("jong") == null ){
	                    response.sendRedirect("/"); 
	                    return false;
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        //admin 세션key 존재시 main 페이지 이동
	        return true;
	    }
	 
	    @Override
	    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
	        super.postHandle(request, response, handler, modelAndView);
	    }
	 
	    @Override
	    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
	        super.afterCompletion(request, response, handler, ex);
	    }
	 
	    @Override
	    public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	        super.afterConcurrentHandlingStarted(request, response, handler);
	    }
	*/
}