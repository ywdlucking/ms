package com.ywd.blog.service;

import java.util.List;

import com.ywd.blog.entity.LotteryUser;

public interface LotteryUserService {
	
	public Integer add(LotteryUser lotteryUser);
	
	public Integer deleteById(Long id);
	
	public Integer findById(Long id);
	
	public Long getTotal();
	
	public List<LotteryUser> findAll();

}
