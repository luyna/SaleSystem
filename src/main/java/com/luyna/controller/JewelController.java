package com.luyna.controller;
 
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;  
import org.springframework.ui.Model;  
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.luyna.dao.UserMapper;
import com.luyna.pojo.BranchCompany;
import com.luyna.pojo.Jewel;
import com.luyna.pojo.JewelOrder;
import com.luyna.pojo.JewelSubType;
import com.luyna.pojo.JewelType;
import com.luyna.pojo.Manage;
import com.luyna.pojo.Picture;
import com.luyna.pojo.ShopCart;
import com.luyna.pojo.User;
import com.luyna.service.JewelService;
import com.luyna.service.UserService;
   
@Controller  
@RequestMapping("/jewel")
public class JewelController {  
	Logger log=Logger.getLogger(JewelController.class);
	@Resource  
	private JewelService jewelService;
	@Resource  
	private UserService userService;
    /**
     * 跳转到浏览珠宝主页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mainpage")  
    public String toMainPage(HttpServletRequest request,Model model){
    	//如果用户未登录，则先登录
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	String username=(String) user;   	
    	
    	/**
    	 * 左边导航栏的显示
    	 */
    	String prefix=request.getParameter("type");
    	model.addAttribute("type", prefix);
    	List<TypeGroup> groupList=jewelService.findTypeGroups(prefix.substring(0,1));		
		model.addAttribute("groupList",groupList);
		
		/*String type=request.getParameter("type");
		List<Jewel> jewelList=jewelService.findJewelByType(type);
		if(jewelList!=null) model.addAttribute("jewelList", jewelList);*/
		
    	return "content/mainPage";  
    } 
    /**
     * 跳转到主页
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/homepage")
    public String toHomepage(HttpServletRequest request,Model model){
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	else return "content/homepage";  
    }  
    /**
     * 导航分类筛选和条件检索：ajax请求
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/conditionSearchResult")    
    public @ResponseBody ModelMap conditionSearch(HttpServletRequest request,ModelMap model){
    	log.info("conditionSearchResult");
    	int resultCount=0;
    	List<Jewel> jewelList=null;
    	String styleno=request.getParameter("styleNo");
		String minWeight=request.getParameter("minWeight");
		String maxWeight=request.getParameter("maxWeight");
    	String type=request.getParameter("type");   
    	//如果没有参数pagesize和pagenow，则默认分别为16和0
    	int pagesize=16,pagenow=0;
    	if(request.getParameter("pagesize")!=null)
    		pagesize=Integer.parseInt(request.getParameter("pagesize"));
    	if(request.getParameter("pagenow")!=null)
    		pagenow=Integer.parseInt(request.getParameter("pagenow"));
    	
    	//如果条件检索的输入框都为空则为分类筛选，否则是快速条件检索
    	log.info(request.getParameter("condition"));
    	if(styleno.isEmpty() && minWeight.isEmpty() && maxWeight.isEmpty()){
    		jewelList=jewelService.findJewelByType(type);
    		log.info("type:"+type);
    	}else{  		
    		log.info("styleno"+styleno+",min:"+minWeight+",max:"+maxWeight);
    		jewelList=jewelService.findJewelByStylenoWeight(styleno, minWeight, maxWeight);   		
    	}
    	//分页功能，每次返回其中的一页数据
    	resultCount=jewelList.size();
    	log.info("resultCount:"+resultCount);
    	int endIndex= (pagesize*(pagenow+1)>resultCount)?resultCount:pagesize*(pagenow+1);   	
    	model.addAttribute("jewelList",jewelList.subList(pagesize*pagenow, endIndex));
    	model.addAttribute("resultCount", resultCount);
		return model;  
    }   
    /**
     * 添加商品到购物车
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/shopcart")    
    public @ResponseBody ModelMap addShopcart(HttpServletRequest request,ModelMap model){
    	String username=(String) request.getSession().getAttribute("username");
    	String styleno=request.getParameter("styleno");
    	String count=request.getParameter("count");
    	if(count==null) count="0";
    	int sum=jewelService.addShopCart(username, styleno, Integer.parseInt(count));
    	model.addAttribute("result", "success");
    	model.addAttribute("cartCount", sum);
    	return model;
    	
    }
    /**
     * 添加到收藏夹
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/collection")    
    public @ResponseBody ModelMap addCollection(HttpServletRequest request,ModelMap model){
    	String username=(String) request.getSession().getAttribute("username");
    	String styleno=request.getParameter("styleno");
    	boolean notExist=jewelService.addCollection(username, styleno);
    	if(notExist) model.addAttribute("result", "notExist");
    	else model.addAttribute("result", "exist");
    	return model;    	
    }
    /**
     * 取消收藏
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/collectionCancel") 
    public @ResponseBody ModelMap collectionCancel(HttpServletRequest request,ModelMap model){
    	String username=(String) request.getSession().getAttribute("username");
    	String styleno=request.getParameter("styleno");
    	jewelService.delCollection(username, styleno);
    	
    	return model;
    }
    
    /**
     * //统计购物车的总件数，总金重，总附件价格
     * @param list
     * @return
     */
    public Map<String,String> shopCartStatistic(List<ShopCart> list){
    	Map<String,String> result=new HashMap<String,String>();
    	Iterator itr=list.iterator();
    	float totalprice=0;
    	float totalWeight=0;
    	int totalNum=0;
    	while(itr.hasNext()){
    		ShopCart cart=(ShopCart) itr.next();
    		int num=cart.getJewelnum();
    		totalprice += cart.getJewel().getAccessoryprice()*num;
    		totalWeight += cart.getJewel().getWeight()*num;
    		totalNum += num;
    	}
    	result.put("totalprice", String.valueOf(new DecimalFormat("#.##").format(totalprice)));
    	result.put("totalWeight", String.valueOf(new DecimalFormat("#.##").format(totalWeight)));
    	result.put("totalNum", String.valueOf(totalNum));
    	return result;   	
    }
    /**
     * 购物车商品展示
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/shopcartDetail")    
    public String shopcartDisplay(HttpServletRequest request,ModelMap model){
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	String username=(String) user;
    	//如果没有参数pagesize和pagenow，则默认分别为16和0
    	/*int pagesize=20,pagenow=0;
    	if(request.getParameter("pagesize")!=null)
    		pagesize=Integer.parseInt(request.getParameter("pagesize"));
    	if(request.getParameter("pagenow")!=null)
    		pagenow=Integer.parseInt(request.getParameter("pagenow"));*/
    	List<ShopCart> list=jewelService.findShopCartDetail(username);
    	/*int totalsize=list.size();
    	int endIndex;
    	if((pagenow+1)*pagesize<totalsize) endIndex=(pagenow+1)*pagesize;
    	else endIndex=totalsize;
    	model.addAttribute("pagenow", pagenow);
    	model.addAttribute("pagesize", pagesize);
    	model.addAttribute("totalsize", totalsize);
    	List subList=list.subList(pagenow*pagesize, endIndex);*/
    	//统计购物车的总件数，总金重，总附件价格
    	/*Iterator itr=list.iterator();
    	float totalprice=0;
    	int totalWeight=0;
    	int totalNum=0;
    	while(itr.hasNext()){
    		ShopCart cart=(ShopCart) itr.next();
    		int num=cart.getJewelnum();
    		totalprice += cart.getJewel().getAccessoryprice()*num;
    		totalWeight += cart.getJewel().getWeight()*num;
    		totalNum += num;
    	}*/
    	Map statistic=shopCartStatistic(list);
    	model.addAttribute("shopCartList", list);
    	model.addAttribute("totalprice", statistic.get("totalprice"));
    	model.addAttribute("totalWeight", statistic.get("totalWeight"));
    	model.addAttribute("totalNum", statistic.get("totalNum"));
    	
    	return "content/shopCart";    	
    }
    
    @RequestMapping("/shopcartDelete")    
    public String shopcartDelete(HttpServletRequest request,ModelMap model){
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	String username=(String) user;
    	String styleno=request.getParameter("styleno");
    	jewelService.delFromShopCart(username, styleno);
    	//删除后重新显示购物车
    	return shopcartDisplay(request,model);
    }
    /**
     * 订单确认
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/orderConfirm")    
    public String confirmOrder(HttpServletRequest request,ModelMap model){
    	Object usertmp=request.getSession().getAttribute("username");
    	if(usertmp==null) return "content/login_first";
    	String username=(String) usertmp;
    	String param=request.getParameter("param");
    	if(param==null || param.isEmpty()) return "content/shopCart";
    	jewelService.updateShopCart(username, param);
    	
    	List<ShopCart> list=jewelService.findShopCartDetail(username);
    	Map statistic=shopCartStatistic(list);
    	User user=userService.findUserByUsername(username);
    	List<BranchCompany> company=userService.findBranchCompany(username);
    	    	
    	model.addAttribute("user", user);
    	model.addAttribute("companyList", company);
    	model.addAttribute("shopCartList", list);
    	model.addAttribute("totalprice", statistic.get("totalprice"));
    	model.addAttribute("totalWeight", statistic.get("totalWeight"));
    	model.addAttribute("totalNum", statistic.get("totalNum"));  	
    	
    	return "content/confirmOrder";
    }
    /**
     * 订单提交
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/orderSubmit")     
    public String submitOrder(HttpServletRequest request,ModelMap model){
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	String username=(String) user;
    	String accessoryprice=request.getParameter("accessoryprice");
    	String totalweight=request.getParameter("totalweight");
    	String totalnum=request.getParameter("totalnum");
    	String companyid=request.getParameter("companyid");
    	String remark = "";
    	String paytype = "";
		try {
			paytype = URLDecoder.decode(request.getParameter("paytype"), "utf-8");
			remark=URLDecoder.decode(request.getParameter("remark"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	jewelService.submitOrder(username, totalnum, totalweight, accessoryprice, paytype, companyid,remark);    	 	    	
    	return "content/orderResult";
    }

    /**
     * 历史订单概要显示
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/jewelOrderView") 
    public String viewJewelOrder(HttpServletRequest request,ModelMap model){
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	String username=(String) user;
    	String starttime=request.getParameter("starttime");
    	String endtime=request.getParameter("endtime");
    	//分页
    	int pagesize=15,pagenow=0;
    	if(request.getParameter("pagesize")!=null)
    		pagesize=Integer.parseInt(request.getParameter("pagesize"));
    	if(request.getParameter("pagenow")!=null)
    		pagenow=Integer.parseInt(request.getParameter("pagenow"));
    	
    	List orderlist=jewelService.findOrderByUsernameDate(username, starttime, endtime);
    	log.info("orderlist:"+orderlist.size());
    	int totalsize=orderlist.size();
    	int endIndex;
    	if((pagenow+1)*pagesize<totalsize) endIndex=(pagenow+1)*pagesize;
    	else endIndex=totalsize;
    	
    	List sublist=orderlist.subList(pagenow*pagesize, endIndex);
    	
    	model.addAttribute("pagenow", pagenow);
    	model.addAttribute("pagesize", pagesize);
    	model.addAttribute("totalsize", orderlist.size());
    	model.addAttribute("orderlist", sublist);
    	
    	return "content/jewelOrderView";
    }
    /**
     * 订单详情,不分页显示，便于打印操作
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/orderDetail") 
    public String orderDetail(HttpServletRequest request,ModelMap model){
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	String username=(String) user;
    	
    	String orderid=request.getParameter("orderid");
    	String companyid=request.getParameter("companyid");
    	String kindid=request.getParameter("kindid");
    	List orderDetailList=null;
    	//如果类型不为空，则筛选该类型的条目
    	if(kindid==null || kindid.isEmpty() || kindid.equals("0"))
    		orderDetailList=jewelService.findOrderItemByOrderid(orderid);
    	else orderDetailList=jewelService.findOrderItemByOrderidKind(orderid, kindid);
    	Address address=userService.findReceiveAddress(username, companyid);  	

    	//分页处理
    	/*int pagesize=15,pagenow=0;
    	if(request.getParameter("pagesize")!=null)
    		pagesize=Integer.parseInt(request.getParameter("pagesize"));
    	if(request.getParameter("pagenow")!=null)
    		pagenow=Integer.parseInt(request.getParameter("pagenow"));
    	int totalsize=orderDetailList.size();
    	int endIndex;
    	if((pagenow+1)*pagesize<totalsize) endIndex=(pagenow+1)*pagesize;
    	else endIndex=totalsize;
    	
    	List sublist=orderDetailList.subList(pagenow*pagesize, endIndex);*/
    	model.addAttribute("receiveAddress", address);
    	model.addAttribute("orderDetailList", orderDetailList);
    	/*model.addAttribute("pagenow", pagenow);
    	model.addAttribute("pagesize", pagesize);
    	model.addAttribute("totalsize", totalsize);*/
    	model.addAttribute("orderid", orderid);
    	model.addAttribute("companyid", companyid);
    	model.addAttribute("kindid", kindid);
    	return "content/orderDetail";
    }
    /*@RequestMapping(value="/filterOrderlist") 
    public @ResponseBody ModelMap alterOrderlist(HttpServletRequest request,ModelMap model){
    	String orderid=request.getParameter("orderid");
    	String kindid=request.getParameter("kindid");	
    	List orderDetailList=jewelService.findOrderItemByOrderidKind(orderid, kindid);
    	model.addAttribute("orderDetailList", orderDetailList);
    	return model;
    }*/
    /**
     * 查看收藏夹内容
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/collectionView") 
    public String collectionView(HttpServletRequest request,ModelMap model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	String username=(String) user;
    	
    	List collections=jewelService.findCollectionsByUsername(username);
    	
    	//分页处理
    	int pagesize=16,pagenow=0;
    	if(request.getParameter("pagesize")!=null)
    		pagesize=Integer.parseInt(request.getParameter("pagesize"));
    	if(request.getParameter("pagenow")!=null)
    		pagenow=Integer.parseInt(request.getParameter("pagenow"));
    	int totalsize=collections.size();
    	int endIndex;
    	if((pagenow+1)*pagesize<totalsize) endIndex=(pagenow+1)*pagesize;
    	else endIndex=totalsize;
    	
    	model.addAttribute("collectionList", collections.subList(pagenow*pagesize, endIndex));
    	model.addAttribute("pagenow", pagenow);
    	model.addAttribute("pagesize", pagesize);
    	model.addAttribute("totalsize", totalsize);
    	return "content/collectionView";
    }
    /**
     * 显示珠宝的详细信息
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/jewelDetail") 
    public String jewelDetail(HttpServletRequest request,ModelMap model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("username");
    	if(user==null) return "content/login_first";
    	String username=(String) user;
    	String styleno=request.getParameter("styleno");
    	Jewel jewel=jewelService.findJewelByStyleNo(styleno);
    	model.addAttribute("jewel", jewel);
    	return "content/jewelDetail";    	
    }
    
    /**
     * 跳转到添加珠宝页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/toAddJewel")  
    public String toAddJewel(HttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";
    	Jewel jewel=new Jewel();
    	//jewel.setTime(new Date());
    	//类型默认显示3D硬千足金（编号为1）的分类信息
    	List<TypeGroup> typelist=jewelService.findTypeGroups("1");
    	model.addAttribute("jewel", jewel);
    	model.addAttribute("typelist", typelist);
    	return "admin/addJewel";
    }
    /**
     * 判断款号是否已经存在
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/stylenoExist")  
    public @ResponseBody Model stylenoExist(HttpServletRequest request,Model model){
    	String styleno=request.getParameter("styleno");
    	Jewel jewel=jewelService.findJewelByStyleNo(styleno);
    	if(jewel==null) model.addAttribute("result", "notExist");
    	else model.addAttribute("result", "exist");
    	return model;
    }
    @RequestMapping(value="/selectTypes")  
    public @ResponseBody Model selectTypes(HttpServletRequest request,Model model){
    	String styleno=request.getParameter("styleno");
    	log.info("+++++++++++++++"+styleno);
    	List typelist=null;
    	if(styleno.length()==1) //类型参数为1，2，3
    		typelist=jewelService.findTypeGroups(styleno);
    	else typelist=jewelService.findSubtypesByPrefix(styleno);//类型参数为101，102等
    	model.addAttribute("typelist", typelist);
    	return model;
    }
    @RequestMapping(value="/addJewel")  
    public String addJewel(MultipartHttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";
    	try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	MultipartFile file=request.getFile("jewelimage");
    	Picture pic=new Picture();
    	String styleno=request.getParameter("styleno");
    	String accessory=request.getParameter("accessory");   	
    	String accessoryprice=request.getParameter("accessoryprice");
    	String fineness=request.getParameter("fineness");
    	String instruction=request.getParameter("instruction");
    	String jewelname=request.getParameter("jewelname");
    	String remark=request.getParameter("remark");
    	String specification=request.getParameter("specification");
    	String storage=request.getParameter("storage");   	
    	String suite=request.getParameter("suite");
    	String typeno=request.getParameter("typeno");
    	String weight=request.getParameter("weight");
    	InputStream input;
		try {
			//处理图片输入流信息
			input = file.getInputStream();
			ByteArrayOutputStream fos = new ByteArrayOutputStream();
	    	byte[] bytes=new byte[1024];
	    	int len;
	    	while((len=input.read(bytes))>0){
	    		fos.write(bytes, 0, len);
	    	}
	    	pic.setPiccontent(fos.toByteArray());
	    	pic.setPicname(UUID.randomUUID().toString());
			pic.setStyleno(styleno);
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
     	
    	log.info("pic.getPicname():"+pic.getPicname());
    	log.info("pic.getPicname():"+pic.getStyleno());
    	log.info("pic.getPicname():"+pic.getPiccontent());
    	
    	try{
    		//如果插入时款号已经存在，抛出异常
    		int result=jewelService.addJewel(pic,styleno, typeno, jewelname, weight, fineness, specification, accessory, accessoryprice, suite, storage, instruction, remark);
        	//if(result==1) 
        		
    	}catch(Exception e){
    		e.printStackTrace();
    		return "admin/addJewel_error";
    	}
    	return "redirect:/jewel/addJewelSuccess";
    	
    }
    //珠宝添加成功页面重定向
    @RequestMapping(value="/addJewelSuccess")  
    public String addJewelSuccess(HttpServletRequest request,Model model){
    	return "admin/addJewel_success";
    }
    
    /**
     * 跳转到为修改珠宝的搜索页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/toAlterJewelSearch")  
    public String toAlterJewelSearch(HttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";
    	return "admin/alterJewelSearch";
    }
    /**
     * 为修改珠宝的模糊查询
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/fuzzySearchJewel")  
    public @ResponseBody Model fuzzySearchJewel(HttpServletRequest request,Model model){
    	String styleno=request.getParameter("styleno");
    	//System.out.println(styleno);
    	List jewellist=jewelService.findJewelByFuzzyStyleno(styleno);
    	
    	//分页处理
    	int pagesize=20,pagenow=0;
    	if(request.getParameter("pagesize")!=null)
    		pagesize=Integer.parseInt(request.getParameter("pagesize"));
    	if(request.getParameter("pagenow")!=null)
    		pagenow=Integer.parseInt(request.getParameter("pagenow"));
    	int totalsize=jewellist.size();
    	int endIndex;
    	if((pagenow+1)*pagesize<totalsize) endIndex=(pagenow+1)*pagesize;
    	else endIndex=totalsize;
    	log.info(jewellist.size());
    	model.addAttribute("jewellist", jewellist.subList(pagenow*pagesize, endIndex));
    	model.addAttribute("pagenow", pagenow);
    	model.addAttribute("pagesize", pagesize);
    	model.addAttribute("totalsize", totalsize);

    	return model;
    }
    /**
     * 异步请求图片
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value="/jewelPicture")  
    public @ResponseBody HttpServletResponse jewelPicture(HttpServletRequest request,HttpServletResponse response){
    	String styleno=request.getParameter("styleno");    	
    	Picture picture=jewelService.findPictureByStyleno(styleno);  
    	if(picture!=null){
    		response.setContentType("image/jpeg");
        	OutputStream out;
        	try {
    			out=response.getOutputStream();
    			out.write(picture.getPiccontent(),0,picture.getPiccontent().length);
    			out.flush();
    			out.close();
    		} catch (IOException e1) {
    			// TODO Auto-generated catch block
    			//e1.printStackTrace();
    			System.out.println("数据库中没有该款号的图片");
    		}
    	}
    	
    	return response;
    }
    /**
     * 跳转到修改珠宝页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/toAlterJewelPage")  
    public String toAlterJewelPage(HttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";
    	
    	String styleno=request.getParameter("styleno");
    	Jewel jewel=jewelService.findJewelByStyleNo(styleno);
    	String typeno=String.valueOf(jewel.getTypeno());
    	String prefix=typeno.substring(0, 1);
    	log.info(prefix);
    	List<TypeGroup> group=jewelService.findTypeGroups(prefix);
    	log.info(group.size());
    	model.addAttribute("jewel", jewel);
    	model.addAttribute("typelist", group);
    	model.addAttribute("prefix1", prefix);
    	model.addAttribute("prefix2", typeno.substring(0, 3));
    	model.addAttribute("prefix3", Integer.parseInt(typeno.substring(2, 3))-1);
    	return "admin/alterJewel";    	
    }
    /**
     * 修改珠宝
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/alterJewel")  
    public String alterJewel(MultipartHttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";
    	
    	try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	MultipartFile file=request.getFile("jewelimage");
    	
    	String styleno=request.getParameter("styleno");
    	String accessory=request.getParameter("accessory");   	
    	String accessoryprice=request.getParameter("accessoryprice");
    	String fineness=request.getParameter("fineness");
    	String instruction=request.getParameter("instruction");
    	String jewelname=request.getParameter("jewelname");
    	String remark=request.getParameter("remark");
    	String specification=request.getParameter("specification");
    	String storage=request.getParameter("storage");   	
    	String suite=request.getParameter("suite");
    	String typeno=request.getParameter("typeno");
    	String weight=request.getParameter("weight");
    	Picture pic=null;
    	log.info("pic.getOriginalFilename():"+file.getOriginalFilename());
    	if(!file.getOriginalFilename().isEmpty()){   		
    		pic=new Picture();
    		try {
    			//处理图片输入流信息
    			InputStream input;
    			input = file.getInputStream();
    			ByteArrayOutputStream fos = new ByteArrayOutputStream();
    	    	byte[] bytes=new byte[1024];
    	    	int len;
    	    	while((len=input.read(bytes))>0){
    	    		fos.write(bytes, 0, len);
    	    	}
    	    	pic.setPiccontent(fos.toByteArray());
    	    	pic.setPicname(UUID.randomUUID().toString());
    			pic.setStyleno(styleno);
    		} catch (IOException e2) {
    			// TODO Auto-generated catch block
    			e2.printStackTrace();
    		}
    		log.info("pic.getPicname():"+pic.getPicname());
        	log.info("pic.getPicname():"+pic.getStyleno());
        	log.info("pic.getPicname():"+pic.getPiccontent());
         	
    	}  	
    	try{
    		//如果更新失败，抛出异常
    		int result=jewelService.updateJewel(pic,styleno, typeno, jewelname, weight, fineness, specification, accessory, accessoryprice, suite, storage, instruction, remark);
        	//if(result==1)         		
    	}catch(Exception e){
    		e.printStackTrace();
    		return "admin/alterJewel_error";
    	}
    	return "redirect:/jewel/alterJewelSuccess";
    	
    }
    //珠宝修改成功页面重定向
    @RequestMapping(value="/alterJewelSuccess")
    public String alterJewelSuccess(HttpServletRequest request,Model model){
    	return "admin/alterJewel_success";
    }
    /**
     * 删除珠宝信息
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/delJewel")  
    public @ResponseBody Model delJewel(HttpServletRequest request,Model model){
    	String styleno=request.getParameter("styleno");
    	int result=jewelService.delJewelByStyleno(styleno);
    	if(result==1) model.addAttribute("result", "success"); 
    	return model;
    }
    @RequestMapping(value="/toCheckOrder")  
    public String toCheckOrder(HttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";
    	
    	//分页
    	int pagesize=15,pagenow=0;
    	if(request.getParameter("pagesize")!=null)
    		pagesize=Integer.parseInt(request.getParameter("pagesize"));
    	if(request.getParameter("pagenow")!=null)
    		pagenow=Integer.parseInt(request.getParameter("pagenow"));
    	
    	List orderlist=jewelService.findUncheckedOrder();
    	log.info("orderlist:"+orderlist.size());
    	int totalsize=orderlist.size();
    	int endIndex;
    	if((pagenow+1)*pagesize<totalsize) endIndex=(pagenow+1)*pagesize;
    	else endIndex=totalsize;
    	
    	List sublist=orderlist.subList(pagenow*pagesize, endIndex);
    	
    	model.addAttribute("pagenow", pagenow);
    	model.addAttribute("pagesize", pagesize);
    	model.addAttribute("totalsize", orderlist.size());
    	model.addAttribute("orderlist", sublist);
    	
    	return "admin/checkOrder";
    }
    /**
     * 后台订单详情
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/adminOrderDetail") 
    public String adminOrderDetail(HttpServletRequest request,ModelMap model){
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";
    	   	
    	String orderid=request.getParameter("orderid");
    	String companyid=request.getParameter("companyid");
    	String username=request.getParameter("username");
    	Address address=userService.findReceiveAddress(username, companyid);
    	
    	String kindid=request.getParameter("kindid");
    	List orderDetailList=null;
    	//如果类型不为空，则筛选该类型的条目
    	if(kindid==null || kindid.isEmpty() || kindid.equals("0"))
    		orderDetailList=jewelService.findOrderItemByOrderid(orderid);
    	else orderDetailList=jewelService.findOrderItemByOrderidKind(orderid, kindid);
    	
    	//分页处理
    	/*int pagesize=15,pagenow=0;
    	if(request.getParameter("pagesize")!=null)
    		pagesize=Integer.parseInt(request.getParameter("pagesize"));
    	if(request.getParameter("pagenow")!=null)
    		pagenow=Integer.parseInt(request.getParameter("pagenow"));
    	int totalsize=orderDetailList.size();
    	int endIndex;
    	if((pagenow+1)*pagesize<totalsize) endIndex=(pagenow+1)*pagesize;
    	else endIndex=totalsize;
    	
    	List sublist=orderDetailList.subList(pagenow*pagesize, endIndex);*/
    	model.addAttribute("receiveAddress", address);
    	model.addAttribute("orderDetailList", orderDetailList);
    /*	model.addAttribute("pagenow", pagenow);
    	model.addAttribute("pagesize", pagesize);
    	model.addAttribute("totalsize", totalsize);*/
    	model.addAttribute("orderid", orderid);
    	model.addAttribute("companyid", companyid);
    	model.addAttribute("kindid", kindid);
    	return "admin/orderDetail";
    }
    
    /**
     * 后台显示珠宝的详细信息
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/adminJewelDetail") 
    public String adminJewelDetail(HttpServletRequest request,ModelMap model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";

    	String styleno=request.getParameter("styleno");
    	Jewel jewel=jewelService.findJewelByStyleNo(styleno);
    	model.addAttribute("jewel", jewel);
    	return "admin/jewelDetail";    	
    }
    
    @RequestMapping(value="/checkOrder")  
    public @ResponseBody Model checkOrder(HttpServletRequest request,Model model){
    	try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	String orderid=request.getParameter("orderid");
    	String status=request.getParameter("status");
    	log.info(status);
    	int result=jewelService.updateOrderStatus(orderid, status);
    	model.addAttribute("result", result);
    	return model;
    }
    /**
     * 跳转到订单管理页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/toManageOrder")  
    public String toManageOrder(HttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";
    	
    	try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	String username=request.getParameter("username");
    	String orderStatus = request.getParameter("orderStatus");
    	if(orderStatus!=null && !orderStatus.isEmpty()){
    		try {			
    			orderStatus = URLDecoder.decode(orderStatus, "utf-8");
    		} catch (UnsupportedEncodingException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
		}
		
    	String minDate=request.getParameter("minDate");
    	String maxDate=request.getParameter("maxDate");
    	log.info(username+","+orderStatus+",");
    	//分页
    	int pagesize=15,pagenow=0;
    	if(request.getParameter("pagesize")!=null)
    		pagesize=Integer.parseInt(request.getParameter("pagesize"));
    	if(request.getParameter("pagenow")!=null)
    		pagenow=Integer.parseInt(request.getParameter("pagenow"));
    	
    	List orderlist = jewelService.findOrderForManage(username,orderStatus,minDate,maxDate);
		
    	log.info("orderlist:"+orderlist.size());
    	int totalsize=orderlist.size();
    	int endIndex;
    	if((pagenow+1)*pagesize<totalsize) endIndex=(pagenow+1)*pagesize;
    	else endIndex=totalsize;
    	
    	List sublist=orderlist.subList(pagenow*pagesize, endIndex);
    	
    	model.addAttribute("pagenow", pagenow);
    	model.addAttribute("pagesize", pagesize);
    	model.addAttribute("totalsize", orderlist.size());
    	model.addAttribute("orderlist", sublist);
    	//用于翻页过程中输入参数的重新显示
    	model.addAttribute("username", username);
    	model.addAttribute("orderStatus", orderStatus);
    	model.addAttribute("minDate", minDate);
    	model.addAttribute("maxDate", maxDate);
    	return "admin/manageOrder";
    }
    /**
     * 跳转到JewelType类型管理页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/toManageTypes")  
    public String toManageTypes(HttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";
    	
    	String jewelKind=request.getParameter("jewelKind");
    	if(jewelKind==null) jewelKind="1";
    	List list=jewelService.findTypesByPrefix(jewelKind);
    	model.addAttribute("jewelTypes", list);
    	model.addAttribute("jewelKind", jewelKind);
    	return "admin/manageTypes";    	
    }
    /**
     * 添加类型JewelType
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/addJewelType")  
    public @ResponseBody Model addJewelType(HttpServletRequest request,Model model){
    	try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	String jewelKind=request.getParameter("jewelKind");
    	String typename=request.getParameter("jewelType");
    	if(jewelKind==null) jewelKind="1";
    	log.info(jewelKind);
    	JewelType type=jewelService.addJewelType(typename,jewelKind);
    	//List list=jewelService.findTypesByPrefix(jewelKind);
    	model.addAttribute("newType", type);
    	return  model;  
    }
    /**
     * 更新类型JewelType
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/updateJewelType")  
    public @ResponseBody Model updateJewelType(HttpServletRequest request,Model model){
    	try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	String typeid=request.getParameter("typeid");
    	String typename=request.getParameter("typename");
 
    	jewelService.updateJewelType(typename,typeid);
    	//List list=jewelService.findTypesByPrefix(jewelKind);
    	//model.addAttribute("newType", type);
    	return  model;  
    }
    
    /**
     * 删除JewelType
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/deleteJewelType")  
    public @ResponseBody Model deleteJewelType(HttpServletRequest request,Model model){   	
    	String typeid=request.getParameter("typeid"); 
    	jewelService.deleteJewelType(typeid);
    	return  model;  
    }

    /**
     * 跳转到JewelSubType类型管理页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/toManageSubTypes")  
    public String toManageSubTypes(HttpServletRequest request,Model model){
    	//判断用户是否已经登录
    	Object user=request.getSession().getAttribute("adminname");
    	if(user==null) return "admin/login_first";
    	
    	String jewelType=request.getParameter("jewelType");
    	String jewelKind=request.getParameter("jewelKind");
    	if(jewelKind==null) jewelKind="1";
    	if(jewelType==null) jewelType="101";
    	List<JewelType> typelist=jewelService.findTypesByPrefix(jewelKind);
    	List<JewelSubType> subtypelist=jewelService.findSubtypesByPrefix(jewelType);
    	model.addAttribute("jewelTypes", typelist);
    	model.addAttribute("jewelSubTypes", subtypelist);
    	//model.addAttribute("jewelTypeid", list.get(0).getTypeid());
    	return "admin/manageSubTypes";    	
    }
    /**
     * 添加类型二级类型
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/addJewelSubType")  
    public @ResponseBody Model addJewelSubType(HttpServletRequest request,Model model){
    	try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	String newSubType=request.getParameter("newSubType");
    	String jewelType=request.getParameter("jewelType");
    	
    	JewelSubType type=jewelService.addJewelSubType(newSubType,jewelType);
    	//List list=jewelService.findTypesByPrefix(jewelKind);
    	model.addAttribute("newType", type);
    	return  model;  
    }
    /**
     * 更新类型二级类型
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/updateJewelSubType")  
    public @ResponseBody Model updateJewelSubType(HttpServletRequest request,Model model){
    	try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	String typeid=request.getParameter("typeid");
    	String typename=request.getParameter("typename");
 
    	jewelService.updateJewelSubType(typename,typeid);
    	//List list=jewelService.findTypesByPrefix(jewelKind);
    	//model.addAttribute("newType", type);
    	return  model;  
    }
    
    /**
     * 删除二级类型
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/deleteJewelSubType")  
    public @ResponseBody Model deleteSubJewelType(HttpServletRequest request,Model model){   	
    	String typeid=request.getParameter("typeid"); 
    	jewelService.deleteJewelSubType(typeid);
    	return  model;  
    }

}  

