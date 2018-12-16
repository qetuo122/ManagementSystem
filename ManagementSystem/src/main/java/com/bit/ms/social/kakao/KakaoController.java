package com.bit.ms.social.kakao;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bit.ms.user.model.UserVO;

@Controller
public class KakaoController {

	@Autowired
	KakaoLoginCheckService kakaoService;
	
	// 결과값 초기화
	private int result = 0;
	// 소셜 구분을 위한 변수
	private String divide = "kakao_id";

	JsonNode accessToken;

	@RequestMapping(value = "/kakaologin", produces = "application/json", method = RequestMethod.GET)
	public String kakaoLogin(@RequestParam("code") String code, RedirectAttributes ra, HttpSession session,
			HttpServletResponse response) throws IOException {

		System.out.println("kakao code : " + code);

		// JsonNode트리형태로 토큰받아온다
		JsonNode jsonToken = KakaoAccessToken.getKakaoAccessToken(code);
		// 여러 json객체 중 access_token을 가져온다
		accessToken = jsonToken.get("access_token");

		System.out.println("access_token : " + accessToken);

		// access_token을 통해 사용자 정보 요청
		JsonNode userInfo = KakaoUserInfo.getKakaoUserInfo(accessToken);

		// Get id
		String id = userInfo.path("id").asText();
		String name = null;
		String email = null;

		// 가입되어있는지 카카오아이디로 찾는다
		result = kakaoService.getKakaoLogin(id, divide);

		// 유저정보 카카오에서 가져오기 Get properties
		JsonNode properties = userInfo.path("properties");
		JsonNode kakao_account = userInfo.path("kakao_account");

		name = properties.path("nickname").asText();
		email = kakao_account.path("email").asText();

		System.out.println("id : " + id);
		System.out.println("name : " + name);
		System.out.println("email : " + email);

		// 사용할 카카오아이디와 소셜구분을 세션에 저장
		session.setAttribute("whatid", id);
		session.setAttribute("divide", "kakao_id");

		// 파라메터 저장
		ra.addAttribute("name", name);
		ra.addAttribute("email", email);

		// 카카오 로그인 정보가 존재 할 경우
		if (result == 1) {
			UserVO vo = kakaoService.kakaoLoginPass(id, divide, session);
			
			// 이메일 인증이 되어있는지 확인
			if (!vo.getUser_key().equals("Y")) { // 인증 안하면 로그인페이지로 돌아가서 메시지출력
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('이메일 인증해주세요.');");
				out.println("location.href='/MS'");
				out.println("</script>");
				out.flush();

				return null;

			} else { // 인증이 되어있으면
				return "redirect:/user/storeChoice";
			}
		}
		return "redirect:/user/reg";
	}

	@RequestMapping(value = "/kakaologout", produces = "application/json", method = RequestMethod.GET)
	public String kakaologout() {

		JsonNode userInfo = KakaoLogout.kakaoUserLogout(accessToken);
		// Get id
		String id = userInfo.path("id").asText();

		System.out.println("로그아웃 아이디 : " + id);
		System.out.println(accessToken);

		return "redirect:/";
	}

	@RequestMapping(value = "/kakaounlink", produces = "application/json", method = RequestMethod.GET)
	public void kakaounlink() {

		JsonNode userInfo = KakaoUnlink.kakaoUserUnlink(accessToken);
		// Get id
		String id = userInfo.path("id").asText();

		System.out.println("탈퇴 아이디 : " + id);
		System.out.println(accessToken);
	}
}
