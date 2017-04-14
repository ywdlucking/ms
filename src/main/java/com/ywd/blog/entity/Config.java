package com.ywd.blog.entity;

import java.io.IOException;
import java.util.Properties;

public class Config {
	
	public static String blog_lucene_path = null;
	public static int tux = 0;
	
	static{
		Properties p = new Properties();
		try {
			p.load(Config.class.getResourceAsStream("/config.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		blog_lucene_path = p.getProperty("blog_lucene_path");
		tux = Integer.parseInt(p.getProperty("tux"));

	}
}
