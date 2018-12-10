package com.bit.ms.social.github;

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
import com.bit.ms.user.service.UserLoginService;

@Controller
public class GithubController {

	@Autowired
	GithubLoginCheckService githubService;

	@Autowired
	UserLoginService userService;

	// 결과값 초기화
	private int result = 0;
	// 소셜 구분을 위한 변수
	private String divide = "github_id";

	@RequestMapping(value = "/githublogin", produces = "application/json", method = RequestMethod.GET)
	public String githubLogin(@RequestParam("code") String code, RedirectAttributes ra, HttpSession session,
			HttpServletResponse response) throws IOException {

		System.out.println("github code : " + code);

		String accessToken = GithubAccessToken.getGithubAccessToken(code);

		// access_token을 통해 사용자 정보 요청
		JsonNode userInfo = GithubUserInfo.getGithubUserInfo(accessToken);

		// 유저정보를 가져온다
		String id = userInfo.path("id").asText();
		String name = userInfo.path("name").asText();
		String email = userInfo.path("email").asText();

		// 가입되어있는지 GitHub아이디로 찾는다
		result = githubService.getGithubLogin(id, divide);

		System.out.println("id : " + id);
		System.out.println("name : " + name);
		System.out.println("email : " + email);

		// 사용할 깃헙아이디와 소셜구분을 세션에 저장
		session.setAttribute("whatid", id);
		session.setAttribute("divide", "github_id");

		// 파라메터 저장
		ra.addAttribute("name", name);
		ra.addAttribute("email", email);

		if (result == 1) {
			UserVO vo = githubService.githubLoginPass(id, divide, session);

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
}
