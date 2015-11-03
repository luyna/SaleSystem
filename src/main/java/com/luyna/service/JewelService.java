package com.luyna.service;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.luyna.controller.Address;
import com.luyna.controller.TypeGroup;
import com.luyna.pojo.Jewel;
import com.luyna.pojo.JewelSubType;
import com.luyna.pojo.JewelType;
import com.luyna.pojo.Picture;


public interface JewelService {  
  
	/**
	 * 找出所有一级类型
	 * @return
	 */
    public List<JewelType> findAllTypes();
    /**
     * 根据类别前缀找出该类别下的所有类型
     * @param prefix
     * @return
     */
    public List<JewelType> findTypesByPrefix(String prefix);
    /**
     * 找出所有以一级类型为前缀的二级类型
     * @param prefix
     * @return
     */
    public List<JewelSubType> findSubtypesByPrefix(String prefix);
    /**
     * 为左侧导航栏准备需要的类型数据
     * @param prefix
     * @return
     */
    public List<TypeGroup> findTypeGroups(String prefix);
    /**
     * 根据类型筛选珠宝（类型的前缀或者精确的类型）
     * @param type
     * @return
     */
    public List<Jewel> findJewelByType(String type);
    /**
     * 条件检索：根据款号和重量筛选珠宝
     * @param styleno
     * @param minWeight
     * @param maxWeight
     * @return
     */
    public List findJewelByStylenoWeight(String styleno, String minWeight,
			String maxWeight);

    /**
     * 用户添加珠宝到购物车,
     * @param username
     * @param styleno
     * @param count
     * @return 返回用户购物车中的珠宝总个数
     */
    public int addShopCart(String username,String styleno,int count); 
    /**
     * 添加珠宝到收藏夹,如果已经在收藏加中返回false,否则返回true
     * @param username
     * @param styleno
     */
    public boolean addCollection(String username,String styleno);
    /**
     * 取消收藏
     * @param username
     * @param styleno
     * @return
     */
    public boolean delCollection(String username,String styleno);
    /**
     * 显示用户购物车详情
     * @param username
     * @return
     */
    public List findShopCartDetail(String username);
    /**
     * 用户删除购物车中某一商品
     * @param username
     * @param styleno
     * @return
     */
    public boolean delFromShopCart(String username,String styleno);
    /**
     * 更新用户购物车商品数量
     * @param param 多个"styleno,jewelNum]"拼接的参数
     * @return
     */
    public int updateShopCart(String username,String param);
     /**
      * 用户提交订单逻辑操作
      * @param username
      * @param totalnum
      * @param totalweight
      * @param accessoryprice
      * @param paytype
      * @param companyid
      * @return
      */
    public int submitOrder(String username,String totalnum,String totalweight,String accessoryprice,String paytype,String companyid,String remark);

    /**
     * 根据用户名和订单日期找出用户所有订单
     * @param username
     * @param starttime 时间格式是2015-09-14
     * @param endtime
     * @return
     */
    public List findOrderByUsernameDate(String username,String starttime,String endtime );

    /**
     * 根据订单号找出订单中的所有商品条目信息
     * @param orderid
     * @return
     */
    public List findOrderItemByOrderid(String orderid);
    /**
     * 找出用户收藏夹中的商品
     * @param username
     * @return
     */
    public List findCollectionsByUsername(String username);
    /**
     * 根据款号找出珠宝详细信息
     * @param styleno
     * @return
     */
    public Jewel findJewelByStyleNo(String styleno);
    /**
     * 添加珠宝
     * @param styleno
     * @param typeno
     * @param jewelname
     * @param weight
     * @param fineness
     * @param specification
     * @param accessory
     * @param accessoryprice
     * @param suite
     * @param storage
     * @param instruction
     * @param remark
     * @return
     */
    public int addJewel(Picture pic,String styleno, String typeno, String jewelname,
			String weight, String fineness, String specification,
			String accessory, String accessoryprice, String suite,
			String storage,  String instruction, String remark);
    /**
     * 添加珠宝信息
     * @param jewel
     * @return
     */
    public int addJewel(Jewel jewel);
    /**
     * 根据款号模糊检索
     * @param styleno
     * @return
     */
    public List findJewelByFuzzyStyleno(String styleno);
    /**
     * 根据款号查询图片
     * @param styleno
     * @return
     */
    public Picture findPictureByStyleno(String styleno);
    /**
     * 根据类型码找出相关的一级和二级分类
     * @param typeno
     * @return
     */
    public List findTypeGroupByTypeno(String typeno);
    /**
     * 更新珠宝图片和基本信息
     * @param pic
     * @param styleno
     * @param typeno
     * @param jewelname
     * @param weight
     * @param fineness
     * @param specification
     * @param accessory
     * @param accessoryprice
     * @param suite
     * @param storage
     * @param instruction
     * @param remark
     * @return
     */
	public int updateJewel(Picture pic, String styleno, String typeno,
			String jewelname, String weight, String fineness,
			String specification, String accessory, String accessoryprice,
			String suite, String storage, String instruction, String remark);
	/**
	 * 删除珠宝信息，包括基本信息和图片
	 * @param styleno
	 * @return
	 */
	public int delJewelByStyleno(String styleno);
	/**
	 * 找出所有未审核订单
	 * @return
	 */
	public List findUncheckedOrder();
	/**
	 * 更新订单状态
	 * @param orderid
	 * @param status
	 * @return
	 */	
	int updateOrderStatus(String orderid, String status);
	/**
	 *后台管理： 根据条件筛选订单
	 * @param username
	 * @param orderStatus
	 * @param minDate
	 * @param maxDate
	 * @return
	 * @throws ParseException 
	 */
	public List findOrderForManage(String username, String orderStatus, String minDate, String maxDate);
	/**
	 * 添加一级类型
	 * @param typename
	 * @return
	 */
	JewelType addJewelType(String typename, String prefix);

	/**
	 * 更新jewelType类型
	 * @param typename
	 * @param typeid
	 * @return
	 */
	int updateJewelType(String typename, String typeid);
	/**
	 * 删除类型
	 * @param typeid
	 * @return
	 */
	int deleteJewelType(String typeid);
	/**
	 * 添加二级类型
	 * @param typename
	 * @param prefix
	 * @return
	 */
	JewelSubType addJewelSubType(String typename, String prefix);
	/**
	 * 更新二级类型
	 * @param typename
	 * @param typeid
	 * @return
	 */
	int updateJewelSubType(String typename, String typeid);
	/**
	 * 删除二级类型
	 * @param typeid
	 * @return
	 */
	int deleteJewelSubType(String typeid);
	/**
	 * 根据订单号筛选给定类别的商品列表
	 * @param orderid
	 * @param kindid
	 * @return
	 */
	List findOrderItemByOrderidKind(String orderid, String kindid);

}   