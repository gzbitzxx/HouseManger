package com.ssm.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.Validate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssm.pojo.*;
import com.ssm.service.*;
import com.ssm.util.SecurityUtil;
import com.ssm.util.Pagination;

@Controller
@RequestMapping("/repair")
public class RepairController {
	@Autowired
	@Qualifier("repairService")
	private RepairService repairService;
	
	/**
	 * 进入信息列表
	 * @return
	 */
	@RequestMapping("/toList")
	public String toList() {
		return "jsp/repair/list";
	};
	
	/**
	 * 进入信息列表
	 * @return
	 */
	@RequestMapping("/toList2")
	public String toList2() {
		return "jsp/repair/listadmin";
	};
	
	/**
	 * 返回信息数据
	 * @param pagination
	 * @return data
	 */
	@RequestMapping("/list")
	@ResponseBody
	public String list(Pagination pagination,HttpServletRequest request){
		User user=(User)request.getSession().getAttribute("user");
		if(user.getType().equals("0")) {
			pagination.setUserId(user.getId());
		}
		String data=repairService.list(pagination);
		return data;
	}
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@RequestMapping("/detele")
	@ResponseBody
	public String delete(Repair data){
		repairService.delete(data);
		return "ok";
	}
	
	//通过id获取数据
	@RequestMapping("/findById")
	@ResponseBody
	public String findUserById(String id) {
		return repairService.findById(id);
	}
	
	//通过更新数据
	@RequestMapping("/update")
	@ResponseBody
	public String update(Repair data) {
		repairService.update(data);
		return "";
	}
	
	//通过更新数据
		@RequestMapping("/update2")
		@ResponseBody
		public String update2(Repair data) {
			Repair repair=repairService.findByRepair(data.getId());
			data.setEndtime(new Date());
			data.setStarttime(repair.getStarttime());
			data.setStatus("已处理");
			System.out.println(data);
			repairService.update(data);
			return "1111";
		}
	
	/**
	 * 添加数据
	 */
	@RequestMapping("/add")
	@ResponseBody
	public String add(Repair data) {
		repairService.insert(data);
		return "ok";
	}
}
