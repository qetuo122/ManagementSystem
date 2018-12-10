package com.bit.ms.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthCheckInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 세션에 로그인 정보 유무 확인
		// -> return true : 정상적인 Controller 실행
		HttpSession session = request.getSession(false);

		if (session != null) {

			Object obj = session.getAttribute("adminSession");
			Object obj2 = session.getAttribute("userSession");

			if (obj != null || obj2 != null) {
				return true;
			}
		}

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter printwriter = response.getWriter();

		printwriter.print(
				"<script>alert('로그인이 필요한 페이지 입니다'); location.replace('" + request.getContextPath() + "/');</script>");

//		printwriter.flush();

//		printwriter.close();

//		response.sendRedirect(request.getContextPath() + "/");

		return false;

	}

}
