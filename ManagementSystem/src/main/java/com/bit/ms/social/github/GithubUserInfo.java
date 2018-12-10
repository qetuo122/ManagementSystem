package com.bit.ms.social.github;

import java.io.IOException;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;

public class GithubUserInfo {
	public static JsonNode getGithubUserInfo(String accessToken) {

		final String RequestUrl = "https://api.github.com/user";
		final HttpClient client = HttpClientBuilder.create().build();
		
		// get방식으로 요청
		final HttpGet get = new HttpGet(RequestUrl);

		// add header
		get.addHeader("Authorization", "token " + accessToken);
		
		JsonNode returnNode = null;

		try {
			final HttpResponse response = client.execute(get);
			final int responseCode = response.getStatusLine().getStatusCode();

			System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
			System.out.println("Response Code : " + responseCode);

			// JSON 형태 반환값 처리
			ObjectMapper mapper = new ObjectMapper();
			returnNode = mapper.readTree(response.getEntity().getContent());

		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// clear resources
		}

		return returnNode;
	}
}
