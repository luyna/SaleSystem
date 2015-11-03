package com.luyna.service;

import java.util.List;

import com.luyna.controller.Address;
import com.luyna.pojo.BranchCompany;
import com.luyna.pojo.Manage;
import com.luyna.pojo.User;
 
public interface UserService {  
    public User getUserById(int userId);  
    /**
     * 保存用户属性到数据库表中
     * @param user
     * @return
     */
    public boolean saveUser(User user);
    /**
     * 根据用户名找到用户
     * @param username
     * @return
     */
    public User findUserByUsername(String username);
    /**
     * 根据管理员名找出管理员信息
     * @param managename
     * @return
     */
    public Manage findManageByManageName(String managename);
    /**
     * 根据用户名找到用户的所有分店地址
     * @param username
     * @return
     */
    public List findBranchCompany(String username);
    
    /**
     * 找出收货人地址
     * @param usename
     * @param companyid
     * @return
     */
    public Address findReceiveAddress(String usename,String companyid);
    /**
     * 根据用户名修改用户密码
     * @param username
     * @return 1:修改成功；0：原密码错误
     */
    public int updateUserPSByUsername(String username,String oldps,String newps);
    /**
     * 修改用户基本信息
     * @param user
     * @return
     */
    public int updateUserInfo(User user);
    /**
     * 根据分店编码找出分店信息
     * @param companyid
     * @return
     */
    public BranchCompany findBranchCompanyById(String companyid);
    /**
     * 根据分店编号更新分店信息
     * @param companyid
     * @return
     */
    public int updateBranchCompanyById(String companyid,String relationuser,String companyname,String address,String phonenum,String email);
    /**
     * 添加保存分店信息
     * @param username
     * @param relationuser
     * @param companyname
     * @param address
     * @param phonenum
     * @param email
     * @return
     */
    public int addBranchCompany(String username,String relationuser,String companyname,String address,String phonenum,String email);

    /**
     * 逻辑删除分店信息
     * @param companyid
     * @return
     */
    public int delBranchCompanyById(String companyid);
    /**
     * 添加管理员
     * @param managename
     * @param password
     * @return
     */
	int addManage(String managename, String password);
	/**
	 * 找出所有管理员
	 * @return
	 */
	List findAllManage();
	/**
	 * 修改管理员密码
	 * @param name
	 * @param password
	 * @param string 
	 * @return 原密码不正确（-1） 修改成功（1） 用户不存在（0）
	 */
	int updateManageByName(String name, String oldps, String newps);
	/**
	 * 找出未审核的用户
	 * @return
	 */
	List findUncheckedUser();
	/**
	 * 修改用户状态
	 * @param username
	 * @return
	 */
	int alterUserStatus(String username);
	/**
	 * 删除用户
	 * @param username
	 * @return
	 */
	int delUserByUsername(String username);
	/**
	 * 找出所有审核过的用户
	 * @return
	 */
	List findCheckedUser();
    
    
    
}  