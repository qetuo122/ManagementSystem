package com.bit.ms.user.service;

import java.util.Collection;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import org.springframework.stereotype.Service;

@Service
public class UserRedundantLoginService implements HttpSessionBindingListener {

	private static UserRedundantLoginService loginManager = null;

	// 로그인한 접속자를 담기위한 해시테이블
	private static Hashtable loginUsers = new Hashtable();

	/*
	 * 싱글톤 패턴 사용
	 */
	public static synchronized UserRedundantLoginService getInstance() {
		if (loginManager == null) {
			loginManager = new UserRedundantLoginService();
		}
		return loginManager;
	}

	/*
	 * 이 메소드는 세션이 연결되을때 호출된다.(session.setAttribute("login", this)) Hashtable에 세션과
	 * 접속자 아이디를 저장한다.
	 */
	public void valueBound(HttpSessionBindingEvent event) {
		// session값을 put한다.
		loginUsers.put(event.getSession(), event.getName());
		System.out.println(event.getName() + "님이 로그인 하셨습니다.");
		System.out.println("[세션생성] valueBound 현재 접속자 수 : " + getUserCount());
		System.out.println("[세션생성] valueBound 현재 접속자 리스트 : " + loginUsers);
	}

	/*
	 * 이 메소드는 세션이 끊겼을때 호출된다.(invalidate) Hashtable에 저장된 로그인한 정보를 제거해 준다.
	 */
	public void valueUnbound(HttpSessionBindingEvent event) {
		// session값을 찾아서 없애준다.
		loginUsers.remove(event.getSession());
		System.out.println("  " + event.getName() + "님이 로그아웃 하셨습니다.");
		System.out.println("[세션종료] valueUnbound 현재 접속자 수 : " + getUserCount());
		System.out.println("[세션종료] valueUnbound 현재 접속자 리스트 : " + loginUsers);
	}

	/*
	 * 입력받은 아이디를 해시테이블에서 삭제.
	 * 
	 * @param loginId 사용자 아이디
	 * 
	 * @return void
	 */
	public void removeSession(String loginId) {
		Enumeration e = loginUsers.keys();
		HttpSession session = null;

		while (e.hasMoreElements()) {
			session = (HttpSession) e.nextElement();
			if (loginUsers.get(session).equals(loginId)) {
				// 세션이 invalidate될때 HttpSessionBindingListener를
				// 구현하는 클레스의 valueUnbound()함수가 호출된다.
				session.invalidate();
			}
		}
	}

//	public int confirmSession(HttpSession session) { // 실시간 확인
//		Enumeration e = loginUsers.keys();
//		HttpSession hashtableinsession = null;
//
//		int result = 0;
//
//		while (e.hasMoreElements()) {
//			hashtableinsession = (HttpSession) e.nextElement();
//			if (!loginUsers.get(hashtableinsession).equals(session)) {
//				// 세션이 invalidate될때 HttpSessionBindingListener를
//				// 구현하는 클레스의 valueUnbound()함수가 호출된다.
//				result = -1;
//			}
//		}
//		System.out.println("[세션 실시간 확인1] " + result);
//		return result;
//	}

	/*
	 * 사용자가 입력한 ID, PW가 맞는지 확인하는 메소드
	 * 
	 * @param loginId 사용자 아이디
	 * 
	 * @param userPW 사용자 패스워드
	 * 
	 * @return boolean ID/PW가 일치하는 지 여부
	 */
//     public boolean isValid(String loginId, String userPw){
//         
//         /*
//          * 이부분에 Database 로직이 들어간다.
//          */
//         return true;
//     }

	/*
	 * 해당 아이디의 동시 사용을 막기위해서 이미 사용중인 아이디인지를 확인한다.
	 * 
	 * @param loginId 사용자 아이디
	 * 
	 * @return boolean 이미 사용 중인 경우 true, 사용중이 아니면 false
	 */
	public boolean isUsing(String loginId) {
		return loginUsers.containsValue(loginId);
	}

	/*
	 * 로그인을 완료한 사용자의 아이디를 세션에 저장하는 메소드
	 * 
	 * @param session 세션 객체
	 * 
	 * @param loginId 사용자 아이디
	 */
	public void setSession(HttpSession session, String loginId) {
		// 이순간에 Session Binding이벤트가 일어나는 시점
		// name값으로 loginId, value값으로 자기자신(HttpSessionBindingListener를 구현하는 Object)
		session.setAttribute(loginId, this);// login에 자기자신을 집어넣는다.
	}

	/*
	 * 입력받은 세션Object로 아이디를 리턴한다.
	 * 
	 * @param session : 접속한 사용자의 session Object
	 * 
	 * @return String : 접속자 아이디
	 */
	public String getloginId(HttpSession session) {
		return (String) loginUsers.get(session);
	}

	/*
	 * 현재 접속한 총 사용자 수
	 * 
	 * @return int 현재 접속자 수
	 */
	public int getUserCount() {
		return loginUsers.size();
	}

	/*
	 * 현재 접속중인 모든 사용자 아이디를 출력
	 * 
	 * @return void
	 */
	public void printloginUsers() {
		Enumeration e = loginUsers.keys();
		HttpSession session = null;
		System.out.println("===========================================");
		System.out.println("접속자 리스트");
		int i = 0;
		while (e.hasMoreElements()) {
			session = (HttpSession) e.nextElement();
			System.out.println((++i) + ". 접속자 : " + loginUsers.get(session));
		}
		System.out.println("===========================================");
	}

	/*
	 * 현재 접속중인 모든 사용자리스트를 리턴
	 * 
	 * @return list
	 */
	public Collection getUsers() {
		Collection collection = loginUsers.values();
		return collection;
	}
}

/*
 * 거의 대부분의 웹사이트를 보면 브라우저를 열고 로그인후 또다시 다른브라우저를 열고 로그인을 하면 로그인이 되는것을 확인하실수 있습니다.
 * 이는 즉... 여러곳에서 동일한 아이디로 접속을 할수있다는 예입 니다. 이와 반대로 메신저같은경우는 이미 로그인이 되어있을시 다른곳에서
 * 로그인을 하면 접속을 끊을지를 물어보는 기능도 보셨을 겁니다. 이를 웹에 서 구현하여 보았습니다. 본 예제소스는 우리가 구현하려고 예제에서
 * 가장 핵심적인 부분을 맡고있 는 소스입니다. 여기서 HttpSessionBindingListener는 서블릿 컨테이너에서 세션이 끊길때
 * (valueUnBound)와 이를 구현하는 오브젝트가 해당 세션에 setAttribute될 때(valueBound) 호출합니다. 굳이 이를
 * 구현하는이유는 세션이 끊기는 시 점을 정확히 잡아내기 위함입니다. 사용자가 로그아웃버튼을 누를시도 있지 만 세션이 타임아웃되는경우도 세션이
 * 끊겨야 하기 때문입니다. 그리고 브라우저의 닫기버튼, Alt+F4, Ctrl+E버튼 을 누를시 이벤트를 잡는방법도 차근차근 알아보도록
 * 합시다.
 */