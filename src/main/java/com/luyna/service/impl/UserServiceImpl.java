package com.luyna.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.luyna.controller.Address;
import com.luyna.dao.BranchCompanyMapper;
import com.luyna.dao.ManageMapper;
import com.luyna.dao.UserMapper;
import com.luyna.pojo.BranchCompany;
import com.luyna.pojo.Manage;
import com.luyna.pojo.User;
import com.luyna.service.UserService;

@Service("userService")  
public class UserServiceImpl implements UserService {  
    @Resource  
    private UserMapper userDao;  
    @Resource  
    private BranchCompanyMapper branchCompanyDao;  
    @Resource  
    private ManageMapper manageDao;
    
    @Override  
    public User getUserById(int userId) {  
        // TODO Auto-generated method stub  
        return this.userDao.selectByPrimaryKey(userId);  
    }
	@Override
	public boolean saveUser(User user) {
		User userExist=findUserByUsername(user.getUsername());
		if(userExist!=null) return false;
		userDao.insert(user);
		return true;
	}
	@Override
	public User findUserByUsername(String username) {
		User user=userDao.selectByUsername(username);
		return user;
	}
	@Override
	public List findBranchCompany(String username) {
		// TODO Auto-generated method stub
		return branchCompanyDao.selectByUsername(username);
	}  
  
	@Override
	public Address findReceiveAddress(String username, String companyid) {
		Address addr=new Address();
		System.out.println("companyid:"+companyid+"fdfa");
		if(companyid.equals("0")){
			User user=userDao.selectByUsername(username);
			addr.setCompanyAddress(user.getAddress());
			addr.setCompanyName(user.getCompanyname());
			addr.setUserName(user.getUserrelname());
			addr.setUserPhone(user.getPhonenum());
		}else{
			Map map=new HashMap();
			map.put("username", username);
			map.put("companyid",companyid);
			BranchCompany comp=branchCompanyDao.selectByUsernameCompanyid(map);
			addr.setCompanyAddress(comp.getAddress());
			addr.setCompanyName(comp.getCompanyname());
			addr.setUserName(comp.getRelationuser());
			addr.setUserPhone(comp.getPhonenum());
		}
		
		return addr;
	}
	@Override
	public int updateUserPSByUsername(String username, String oldps, String newps) {
		User user=userDao.selectByUsername(username);
		String old=user.getPassword();
		if(old.equals(oldps)){
			user.setPassword(newps);
			int result=userDao.updatePasswordByUsername(user);
			return 1;
		}
		return 0;
		
	}
	@Override
	public int updateUserInfo(User user) {
		//System.out.println("xiugadifdang_____________________________");
		return userDao.updateUserInfo(user);
	}
	@Override
	public BranchCompany findBranchCompanyById(String companyid) {
		return branchCompanyDao.selectByPrimaryKey(Integer.parseInt(companyid));
	}
	
	@Override
	public int updateBranchCompanyById(String companyid, String relationuser,
			String companyname, String address, String phonenum, String email) {
		BranchCompany company=findBranchCompanyById(companyid);
    	company.setAddress(address);
    	company.setCompanyname(companyname);
    	company.setEmail(email);
    	company.setPhonenum(phonenum);
    	company.setRelationuser(relationuser);
    	
		return branchCompanyDao.updateByPrimaryKey(company);
	}
	@Override
	public int addBranchCompany(String username, String relationuser,
			String companyname, String address, String phonenum, String email) {
		BranchCompany company=new BranchCompany();
		company.setUsername(username);
    	company.setAddress(address);
    	company.setCompanyname(companyname);
    	company.setEmail(email);
    	company.setPhonenum(phonenum);
    	company.setRelationuser(relationuser);
    	company.setStatus("1");
    	return branchCompanyDao.insert(company);
	}
	@Override
	public int delBranchCompanyById(String companyid) {
		// TODO Auto-generated method stub
		return branchCompanyDao.deleteByCompanyId(Integer.parseInt(companyid));
	}
	@Override
	public Manage findManageByManageName(String managename) {
		// TODO Auto-generated method stub
		return manageDao.selectByManageName(managename);
	}
	
	@Override
	public int addManage(String managename,String password) {
		Manage manage=new Manage();
		manage.setManagename(managename);
		manage.setPassword(password);
		return manageDao.insert(manage);
	}
	
	@Override
	public List findAllManage() {
		return manageDao.selectAllManage();
	}

	@Override
	public int updateManageByName(String name, String oldps, String newps) {
		Manage manage=manageDao.selectByManageName(name);
		if(manage==null) return 0;
		if(manage.getPassword().equals(oldps)) manage.setPassword(newps);
		else return -1;
		manageDao.updateByManageName(manage);
		return 1;
	}
	
	@Override
	public List findUncheckedUser(){
		return userDao.selectAllUnChecked();
	}
	@Override
	public List findCheckedUser(){
		return userDao.selectAllChecked();
	}
	
	@Override
	public int alterUserStatus(String username){
		return userDao.updateUserStatus(username);
	}
	@Override
	public int delUserByUsername(String username){
		int result=userDao.deleteByUsername(username);
		branchCompanyDao.deleteByUsername(username);
		return result;
	}
}  
