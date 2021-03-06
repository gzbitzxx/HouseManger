package com.ssm.service;

import com.ssm.pojo.User;
import com.ssm.util.Pagination;
import com.ssm.vo.UserInfo;

public interface UserService {
	/**
	 * 添加用户
	 * 
	 * @param info
	 */
	public void insert(User user);

	/**
	 * 用户登录
	 * 
	 * @param user
	 * @return
	 */
	public User login(User user);

	/**
	 * 获取用户分页数据
	 * 
	 * @param pagination
	 * @return
	 */
	public String list(Pagination pagination);

	/**
	 * 删除用户
	 * @param user
	 */
	public void delete(User user);

	/**
	 * 根据Id查询用户信息
	 * 
	 * @param id
	 * @return 用户信息
	 */
	public String findById(String id);
	
	/**
	 * 根据Id查询用户信息
	 * 
	 * @param id
	 * @return 用户信息
	 */
	public boolean findByUserName(String username);

	/**
	 * 根据id修改用户信息
	 * 
	 * @param user 用户信息
	 */
	public void update(User user);
	
	/**
	 * 获取用户下拉信息
	 * @return
	 */
	public String findIDAndNumber();
	/**
	 * 获取用户信息
	 * @param user
	 * @return
	 */
	public UserInfo findUserInfo(User user);
	/**
	 * 修改个人信息
	 * @param userInfo
	 */
	public User updateInfo(UserInfo userInfo);
}
