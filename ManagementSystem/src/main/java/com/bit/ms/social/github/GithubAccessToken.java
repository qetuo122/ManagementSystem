package com.bit.ms.social.github;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;

public class GithubAccessToken {
	public static String getGithubAccessToken(String code) {

		final String RequestUrl = "https://github.com/login/oauth/access_token";
		final List<NameValuePair> postParams = new ArrayList<NameValuePair>();

		postParams.add(new BasicNameValuePair("client_id", "ca3c1f71782ed1d5d649")); // REST API KEY
		postParams.add(new BasicNameValuePair("client_secret", "1b2d340a37575b491a513582617d366ccb89fc9d"));
		postParams.add(new BasicNameValuePair("code", code)); // 로그인 과정중 얻은 code 값

		final HttpClient client = HttpClientBuilder.create().build();
		final HttpPost post = new HttpPost(RequestUrl);
		
		InputStream inputStream = null;
		String returnBody = null;
		String accessToken = null;
		
		try {
			post.setEntity(new UrlEncodedFormEntity(postParams));
			
			final HttpResponse response = client.execute(post);
			final int responseCode = response.getStatusLine().getStatusCode();

			System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
			System.out.println("Post parameters : " + postParams);
			System.out.println("Response Code : " + responseCode);

			inputStream = response.getEntity().getContent();
			
			// inputStream형태를 String으로 변환해준다
			int i;
			StringBuffer buffer = new StringBuffer();
			byte[] b = new byte[4096];
			while ((i = inputStream.read(b)) != -1) {
				buffer.append(new String(b, 0, i));
			}
			returnBody = buffer.toString();

			int from = returnBody.indexOf("=");
			int to = returnBody.indexOf("&");

			// String으로 변환된 값에서 subString을 이용하여 token만 가져온다
			accessToken = returnBody.substring(from + 1, to);
			
			System.out.println("github access_token : " + accessToken);
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// clear resources
		}

		return accessToken;
	}
}
