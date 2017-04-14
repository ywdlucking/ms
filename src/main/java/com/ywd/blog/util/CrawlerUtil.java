package com.ywd.blog.util;

import java.io.IOException;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class CrawlerUtil {
	
	private static OkHttpClient client = new OkHttpClient();

	
	public static String achieve(String url) throws IOException{
		Request request = new Request.Builder().url(url).build();
		Response response = client.newCall(request).execute();
		return response.body().string();
	}
	
	public static void main(String[] args) throws IOException {
		System.out.println(achieve("https://movie.douban.com/"));
	}

}
