package com.luyna.controller;
 
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import javax.websocket.Session;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;  
import org.springframework.ui.Model;  
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.luyna.pojo.BranchCompany;
import com.luyna.pojo.Jewel;
import com.luyna.pojo.Manage;
import com.luyna.pojo.User;
import com.luyna.service.UserService;
   
@Controller  
@RequestMapping("/user")
public class UserController {  
	Logger log=Logger.getLogger(UserController.class);
    @Resource  
    private UserService userService;  
      
    @RequestMapping("/loginpage")
    public String toIndex(HttpServletRequest request,Model model){
        return "../index";  
    } 
    
    @RequestMapping("/adminLoginpage")
    public String toAdminIndex(HttpServletRequest request,Model model){
        return "../adminIndex";  
    } 
    /**
     * 用户登录
     * @param username
     * @param userpassword
     * @param model
     * @return
     */
    @RequestMapping(value="/userLogin")  
    public String userLogin(HttpServletRequest request,Model model){
    	String username=request.getParameter("username");
    	String pw=encoderByMd5(request.getParameter("userpassword"));
    	log.info(username);
    	User user=userService.findUserByUsername(username);
    	if(user!=null ){
    		if(user.getStatus().equals("0")){//尚未通过审核
    			return "content/login_notpass";
    		}else if(user.getStatus().equals("1") && user.getPassword().equals(pw)){
    			request.getSession().setAttribute("username", username);
        		return "content/homepage";
    		}   		
    	}
    	
        return "content/login_failure";  
    }  
    /**
     * 管理员登陆
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/adminLogin")  
    public String adminLogin(HttpServletRequest request,Model model){
    	String username=request.getParameter("username");
    	String pw=encoderByMd5(request.getParameter("userpassword"));
    	log.info(username);
    	Manage admin=userService.findManageByManageName(username);
    	if(admin!=null && admin.getPassword().equals(pw)){
    		request.getSession().setAttribute("adminname", username);
    		return "admin/mainPage";
    	}
    	
        return "content/login_failure";  
    }
   /* public String userLogin(@RequestParam("username") String username,@RequestParam("userpassword") String userpassword,Model model){
    	log.info(username);
    	log.info(userpassword);
    	
        User user=userService.findUserByUsername(username);
        if(user!=null) {
            model.addAttribute("user", user);
        	return "content/showUser";
        }
        return "content/login_failure";  
    }  */
    
   /* @RequestMapping(value="/userRegisterProfile",method=RequestMethod.POST)  
    public String userRegister(@ModelAttribute("user") User user,Model model){
    	SimpleDateFormat format=new SimpleDateFormat("YYYY-MM-DD");
    	user.setRegdate(new Date() );
    	log.info(user.getRegdate().toString());
        //userService.save
        model.addAttribute("user", user);
        if(user!=null) return "showUser";
        return "login_failure";  
    }  */
    
    /**
     * 用户注册
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/userRegister",method=RequestMethod.POST)  
    public String userRegister(HttpServletRequest request,Model model){
    	SimpleDateFormat format=new SimpleDateFormat("YYYY-MM-DD");
    	User user=new User();
    	try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
    	user.setUsername(request.getParameter("username"));
    	user.setAddress(request.getParameter("address"));
    	user.setCompanyname(request.getParameter("companyname"));
    	user.setEmail(request.getParameter("email"));
    	//密码使用MD5加密保存
    	user.setPassword(encoderByMd5(request.getParameter("userpassword")));
    	user.setPhonenum(request.getParameter("phonenum"));
    	user.setUserrelname(request.getParameter("realname"));
    	user.setRegdate(new Date());
    	user.setStatus("0");
    	log.info(request.getParameter("realname"));
    	if(userService.saveUser(user)){    		
    		model.addAttribute("user", user);
    		log.info("保存成功。。");
    		return "content/register_success";
    	}
    	log.info("保存失败。。");
        return "content/register_failure";  
    }  
    /**
     * MD5加密算法
     * @param str
     * @return
     * @throws NoSuchAlgorithmException 
     * @throws UnsupportedEncodingException 
     */
    public String encoderByMd5(String str) { 
        //确定计算方法 
    	MessageDigest md5 = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
    	byte[] bytes = md5.digest(str.getBytes());  
        StringBuffer stringBuffer = new StringBuffer();  
        for (byte b : bytes){  
            int bt = b&0xff;  
            if (bt < 16){  
                stringBuffer.append(0);  
            }   
            stringBuffer.append(Integer.toHexString(bt));  
        }     
        return stringBuffer.toString();   
    }
    /**
     * 跳转到修改密码页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/toAlterPassword")  
    public String toAlterPassword(HttpServletRequest request,Model model){ 
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";

    	PasswordAlter ps=new PasswordAlter();   
    	model.addAttribute("passwordContent", ps);//用于将参数与修改密码的表单绑定
    	return "content/alterPS";
    }
    /**
     * 修改密码提交
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/alterPassword")  
    public String alterPassword(HttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	String username=(String) user;
    	String oldps=request.getParameter("oldps");
    	String newps=request.getParameter("newps");
    	int result=userService.updateUserPSByUsername(username, encoderByMd5(oldps), encoderByMd5(newps));
    	if(result==1){
    		//注销掉需要重新登陆
    		request.getSession().removeAttribute("username");
    		log.info("success");
    		return "content/alterPS_success";
    	}
    	return "content/alterPS_error";
    }
    /**
     * 普通用户注销
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/logout")  
    public String logout(HttpServletRequest request,Model model){
    	request.getSession().removeAttribute("username");
    	return "content/logout";
    }
    /**
     * 跳转到修改用户基本信息页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/toAlterUserInfo")  
    public String toAlterUserInfo(HttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	String username=(String) user;
    	
    	User userInfo=userService.findUserByUsername(username);
    	model.addAttribute("userInfo", userInfo);//将userInfo对象与表单绑定
    	return "content/alterUserInfo";
    }
    /**
     * 用户信息修改后提交
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/alterUserInfo")  
    public String  alterUserInfo(HttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	String username=(String) user;
    	User userInfo=userService.findUserByUsername(username);  
    	try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	String userrelname=request.getParameter("userrelname");
    	String address=request.getParameter("address");
    	String companyname=request.getParameter("companyname");
    	String phonenum=request.getParameter("phonenum");
    	String email=request.getParameter("email");
    	
    	userInfo.setAddress(address);
    	userInfo.setCompanyname(companyname);
    	userInfo.setEmail(email);
    	userInfo.setPhonenum(phonenum);
    	userInfo.setUserrelname(userrelname);
    	int result=userService.updateUserInfo(userInfo);
    	if(result==1) return "content/alterUserInfo_success";
    	return "content/alterUserInfo_error";
    	
    }
    /**
     * 分店管理页面：列表显示所有分店信息
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/branchCompany") 
    public String branchCompanyManage(HttpServletRequest request,ModelMap model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	String username=(String) user;   	
    	List companylist=userService.findBranchCompany(username);
    	
    	//分页处理
    	int pagesize=10,pagenow=0;
    	if(request.getParameter("pagesize")!=null)
    		pagesize=Integer.parseInt(request.getParameter("pagesize"));
    	if(request.getParameter("pagenow")!=null)
    		pagenow=Integer.parseInt(request.getParameter("pagenow"));
    	int totalsize=companylist.size();
    	int endIndex;
    	if((pagenow+1)*pagesize<totalsize) endIndex=(pagenow+1)*pagesize;
    	
    	else endIndex=totalsize;
    	
    	model.addAttribute("companylist", companylist.subList(pagenow*pagesize, endIndex));
    	model.addAttribute("pagenow", pagenow);
    	model.addAttribute("pagesize", pagesize);
    	model.addAttribute("totalsize", totalsize);
    	return "content/branchCompanyManage";
    }
    /**
     * 跳转到修改分店信息页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/toAlterBranchCompany") 
    public String toAlterBranchCompany(HttpServletRequest request,ModelMap model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	//String username=(String) user; 
    	String companyid=request.getParameter("companyid");
    	BranchCompany company=userService.findBranchCompanyById(companyid);
    	model.addAttribute("branchCompany", company);
    	 	
    	return "content/alterBranchCompany";
    }
    /**
     * 修改分店信息
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/alterBranchCompany") 
    public String alterBranchCompany(HttpServletRequest request,ModelMap model){
    	try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	String username=(String) user;
    	String companyid=request.getParameter("companyid");
    	String relationuser=request.getParameter("relationuser");
    	String address=request.getParameter("address");
    	String companyname=request.getParameter("companyname");
    	String phonenum=request.getParameter("phonenum");
    	String email=request.getParameter("email");
    	int result=userService.updateBranchCompanyById(companyid, relationuser, companyname, address, phonenum, email);
    	if(result==1) return "content/alterCompany_success";
    	return "content/alterCompany_error";
    }
    
    @RequestMapping(value="/toAddBranchCompany") 
    public String toAddBranchCompany(HttpServletRequest request,ModelMap model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	String username=(String) user; 
    	BranchCompany company=new BranchCompany();
    	company.setUsername(username);
    	model.addAttribute("branchCompany", company);
    	 	
    	return "content/addBranchCompany";
    }
    /**
     * 添加分店
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/addBranchCompany") 
    public String addBranchCompany(HttpServletRequest request,ModelMap model){
    	try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	String username=(String) user;   	
    	String relationuser=request.getParameter("relationuser");
    	String address=request.getParameter("address");
    	String companyname=request.getParameter("companyname");
    	String phonenum=request.getParameter("phonenum");
    	String email=request.getParameter("email");
    	int result=userService.addBranchCompany(username, relationuser, companyname, address, phonenum, email);
    	if(result==1) return "content/addCompany_success";
    	return "content/addCompany_error";
    }

    /**
     * 删除分店信息
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/delBranchCompany") 
    public @ResponseBody ModelMap delBranchCompany(HttpServletRequest request,ModelMap model){
    	String companyid=request.getParameter("companyid");
    	 
    	log.info("======================");
    	int result=userService.delBranchCompanyById(companyid);
    	log.info("======================"+result);
    	model.addAttribute("result", result);
    	return model;
    }
    /**
     * 跳转到添加管理员页面
     * @param request
     * @param model
     * @return
     */
   /* @RequestMapping(value="/toAddAdmin")  
    public String toAddAdmin(HttpServletRequest request,Model model){
    	Manage manage=new Manage();
    	model.addAttribute("manage", manage);
    	return "admin/addAdmin";
    }*/
    /**
     * 添加管理员
     * @param request
     * @param model
     * @return
     */
    /*@RequestMapping(value="/addAdmin")  
    public String addAdmin(HttpServletRequest request,Model model){
    	try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	return "admin/addAdmin_success";
    }*/
    /**
     * 跳转到修改管理员密码页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/toAlterAdminPS")  
    public String toAlterPS(HttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";
    	PasswordAlter ps=new PasswordAlter();
    	model.addAttribute("passwordContent", ps);
    	return "admin/alterPS";
    }
    /**
     * 修改管理员密码
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/alterAdminPassword")  
    public String alterAdminPassword(HttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";
    	String username=(String) user;
    	String oldps=request.getParameter("oldps");
    	String newps=request.getParameter("newps");
    	int result=userService.updateManageByName(username, encoderByMd5(oldps), encoderByMd5(newps));
    	if(result==1){
    		//注销掉需要重新登陆
    		request.getSession().removeAttribute("adminname");
    		log.info("success");
    		return "admin/alterPS_success";
    	}
    	return "admin/alterPS_error";
    }
    
    @RequestMapping(value="/adminLogout")  
    public String adminLogout(HttpServletRequest request,Model model){
    	request.getSession().removeAttribute("adminname");
    	return "admin/logout";
    }
    /**
     * 跳转到用户注册审核页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/toCheckUser")  
    public String toCheckUser(HttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";
    	
    	List userlist=userService.findUncheckedUser();
    	model.addAttribute("userlist", userlist);
    	return "admin/checkUser";
    }
    /**
     * 审核用户
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/checkUser") 
    public @ResponseBody ModelMap checkUser(HttpServletRequest request,ModelMap model){
    	String username=request.getParameter("username");
    	userService.alterUserStatus(username);
    	return model;
    }
    /**
     * 删除用户
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/delUser") 
    public @ResponseBody ModelMap delUser(HttpServletRequest request,ModelMap model){
    	String username=request.getParameter("username");
    	userService.delUserByUsername(username); 
    	return model;
    }
    /**
     * 跳转到管理用户页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/toManageUser")  
    public String toManageUser(HttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";
    	
    	List userlist=userService.findCheckedUser();
    	
    	//分页
    	int pagesize=15,pagenow=0;
    	if(request.getParameter("pagesize")!=null)
    		pagesize=Integer.parseInt(request.getParameter("pagesize"));
    	if(request.getParameter("pagenow")!=null)
    		pagenow=Integer.parseInt(request.getParameter("pagenow"));   	 	
    	int totalsize=userlist.size();
    	int endIndex;
    	if((pagenow+1)*pagesize<totalsize) endIndex=(pagenow+1)*pagesize;
    	else endIndex=totalsize;   	
    	List sublist=userlist.subList(pagenow*pagesize, endIndex); 
    	
    	model.addAttribute("pagenow", pagenow);
    	model.addAttribute("pagesize", pagesize);
    	model.addAttribute("totalsize", totalsize);
    	model.addAttribute("userlist", sublist);
    	   	
    	//model.addAttribute("userlist", userlist);
    	return "admin/manageUser";
    }
    
    @RequestMapping(value="/toManageBranchCompany")  
    public String toManageBranchCompany(HttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";
    	String username=request.getParameter("username");
    	log.info(username);
    	List companylist=userService.findBranchCompany(username);
    	log.info(companylist.size());
    	
    	model.addAttribute("companylist", companylist);
    	return "admin/manageUserBranchCompany";
    }
  
}  