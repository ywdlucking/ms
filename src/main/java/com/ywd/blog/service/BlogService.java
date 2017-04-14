package com.ywd.blog.service;

import java.util.List;
import java.util.Map;

import com.ywd.blog.entity.Blog;

public interface BlogService {

	public List<Blog> countList();
	
	/**
	 * 查询推荐博客
	 * @param map
	 * @return
	 */
	public List<Blog> listRecommend(Map<String, Object> map);
	
	/**
	 * 查询最新博客
	 * @param map
	 * @return
	 */
	public List<Blog> listNew(Map<String, Object> map);
	
	/**
	 * 分页查询博客
	 * @param map
	 * @return
	 */
	public List<Blog> list(Map<String, Object> map);
	
	/**
	 * 获取总记录数
	 * @param map
	 * @return
	 */
	public Long getTotal(Map<String, Object> map);
	
	/**
	 * 通过id查找博客文章
	 * @param id
	 * @return
	 */
	public Blog findById(Integer id);
	
	/**
	 * 更新博客
	 * @param blog
	 */
	public Integer update(Blog blog);
	
	/**
	 * 获取上一个博客
	 * @param id
	 * @return
	 */
	public Blog getLastBlog(Integer id);
	
	/**
	 * 获取下一个博客
	 * @param id
	 * @return
	 */
	public Blog getNextBlog(Integer id);
	
	/**
	 * 添加一篇博客
	 * @return
	 */
	public int add(Blog blog);
	
	/**
	 * 删除博客
	 * @param blogId
	 * @return
	 */
	public Integer deleteBlog(Integer id);
}
