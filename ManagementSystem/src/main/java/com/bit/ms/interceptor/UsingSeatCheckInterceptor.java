package com.bit.ms.interceptor;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bit.ms.member.model.SeatVO;
import com.bit.ms.user.model.UserVO;
import com.bit.ms.user.service.UserTimeService;

public class UsingSeatCheckInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	UserTimeService service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		// 좌석 사용 여부 검사
		// -> return true : 정상적인 Controller 실행
		HttpSession session = request.getSession(false);
		
		if (session != null) {
			UserVO userVO = (UserVO)session.getAttribute("userSession");
			
			List<SeatVO> seatList = service.getSeatListAll(userVO.getStore_id());
			
			for(int i=0; i < seatList.size(); i++) {
				String usingId = seatList.get(i).getUser_id();
				
				if(usingId != null) {
					if(usingId.equals(userVO.getUser_id())) {
						return true;
					}
				}
			}
		}
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter printwriter = response.getWriter();
		printwriter.print(
				"<script>alert('좌석 선택 후 주문 가능합니다.'); location.replace('" + request.getContextPath() + "/user/main');</script>");
		
		return false;
	}
}
