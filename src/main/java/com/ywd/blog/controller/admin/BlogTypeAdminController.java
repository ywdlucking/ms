package com.ywd.blog.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ywd.blog.entity.BlogType;
import com.ywd.blog.entity.PageBean;
import com.ywd.blog.service.BlogTypeService;
import com.ywd.blog.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
@RequestMapping("/admin/blogType")
public class BlogTypeAdminController {
	
	@Resource
	private BlogTypeService blogTypeService;
	
	/**
	 * 获取所有的博客类别
	 * @param id
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=true)String page, @RequestParam(value="rows",required=true)String rows,HttpServletResponse response) throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<BlogType> blogTypes = blogTypeService.list(map);
		Long blogTypeTotal = blogTypeService.getTotal(map);
		JSONArray array = JSONArray.fromObject(blogTypes);
		JSONObject result = new JSONObject();
		result.put("rows", array);
		result.put("total", blogTypeTotal);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/save")
	public String save(BlogType blogType, HttpServletResponse response)throws Exception{
		int result = 0;
		if(blogType.getId() == null){
			result = blogTypeService.add(blogType);
		}else{
			result = blogTypeService.update(blogType);
		}
		if(result > 0){
			ResponseUtil.write(response, true);
		}else{
			ResponseUtil.write(response, false);
		}
		return null;
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam(value="ids", required=true)String ids, HttpServletResponse response)throws Exception{
		String[] split = ids.split(",");
		try {
			for (String id : split) {
				blogTypeService.delete(Integer.valueOf(id));
			}
		} catch (Exception e) {
			ResponseUtil.write(response, false);
		}
		ResponseUtil.write(response, true);
		return null;
	}
}
