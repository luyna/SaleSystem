package com.luyna.service.impl;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.luyna.controller.Address;
import com.luyna.controller.TypeGroup;
import com.luyna.dao.BranchCompanyMapper;
import com.luyna.dao.JewelMapper;
import com.luyna.dao.JewelOrderMapper;
import com.luyna.dao.JewelSubTypeMapper;
import com.luyna.dao.JewelTypeMapper;
import com.luyna.dao.MyCollectionMapper;
import com.luyna.dao.OrderItemMapper;
import com.luyna.dao.PictureMapper;
import com.luyna.dao.ShopCartMapper;
import com.luyna.dao.UserMapper;
import com.luyna.pojo.Jewel;
import com.luyna.pojo.JewelOrder;
import com.luyna.pojo.JewelSubType;
import com.luyna.pojo.JewelType;
import com.luyna.pojo.MyCollectionKey;
import com.luyna.pojo.OrderItem;
import com.luyna.pojo.Picture;
import com.luyna.pojo.ShopCart;
import com.luyna.pojo.ShopCartKey;
import com.luyna.pojo.User;
import com.luyna.service.JewelService;
import com.luyna.service.UserService;

@Service("jewelService")
public class JewelServiceImpl implements JewelService {
	@Resource
	private JewelTypeMapper jewelTypeDao;
	@Resource
	private JewelSubTypeMapper jewelSubTypeDao;
	@Resource
	private JewelMapper jewelDao;
	@Resource
	private ShopCartMapper shopCartDao;
	@Resource
	private MyCollectionMapper myCollectionDao;
	@Resource
	private BranchCompanyMapper branchCompanyDao;
	@Resource
	private JewelOrderMapper jewelOrderDao;
	@Resource
	private OrderItemMapper orderItemDao;
	@Resource
	private PictureMapper pictureDao;


	@Override
	public List<JewelType> findAllTypes() {
		List<JewelType> typeList = jewelTypeDao.selectAll();
		/*
		 * Iterator<JewelType> typeItr=typeList.iterator();
		 * while(typeItr.hasNext()){ JewelType type=typeItr.next();
		 * System.out.println("typename:"+type.getTypename()); }
		 */
		return typeList;
	}

	@Override
	public List<JewelSubType> findSubtypesByPrefix(String prefix) {
		List<JewelSubType> subtypeList = jewelSubTypeDao.selectByPrefix(prefix);
		/*
		 * Iterator<JewelSubType> typeItr=subtypeList.iterator();
		 * while(typeItr.hasNext()){ JewelSubType type=typeItr.next();
		 * System.out.println("subtypename:"+type.getSubtypename()); }
		 */
		return subtypeList;
	}

	@Override
	public List<JewelType> findTypesByPrefix(String prefix) {
		List<JewelType> typeList = jewelTypeDao.selectByPrefix(prefix);
		return typeList;
	}

	@Override
	public List<TypeGroup> findTypeGroups(String prefix) {
		List<JewelType> types = findTypesByPrefix(prefix);
		Iterator<JewelType> typeItr = types.iterator();
		// 找到所有类型的子类型，将结构TypeGroup(JewelType,JewelSubType)保存在链表中
		List<TypeGroup> groupList = new ArrayList<TypeGroup>();
		while (typeItr.hasNext()) {
			JewelType type = typeItr.next();
			List<JewelSubType> subtypes = findSubtypesByPrefix(type.getTypeid());
			TypeGroup group = new TypeGroup(type, subtypes);
			groupList.add(group);
		}
		return groupList;
	}

	@Override
	public List findJewelByType(String type) {
		List list = new ArrayList<Jewel>();
		if (type.length() == 1 || type.length() == 3) { // 如果是1/2/3这种类型，代表3D硬千足金/珠宝类等大类;若是101这种编号，表示项链等类型
			list = jewelDao.selectByTypePrefix(type);
		} else {
			list = jewelDao.selectByType(type);
		}
		return list;
	}

	@Override
	public List findJewelByStylenoWeight(String styleno, String minWeight,
			String maxWeight) {
		if (minWeight.isEmpty())
			minWeight = "0";
		if (maxWeight.isEmpty())
			maxWeight = Float.MAX_VALUE + "";

		/*
		 * float min,max; if(minWeight.isEmpty()) min=0; else
		 * min=Integer.parseInt(minWeight); if(maxWeight.isEmpty())
		 * max=Float.MAX_VALUE; else max=Integer.parseInt(maxWeight);
		 */
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("styleno", styleno);
		paramMap.put("minWeight", minWeight);
		paramMap.put("maxWeight", maxWeight);
		return jewelDao.selectByStylenoWeight(paramMap);
	}

	@Override
	public int addShopCart(String username, String styleno, int count) {
		// 如果款号为空，则表明是购物车的初始化数量显示，直接返回数据库中用户购物车中的中珠宝数即可
		if (styleno == null)
			return shopCartDao.selectCartSum(username);
		ShopCartKey param = new ShopCartKey();
		param.setStyleno(styleno);
		param.setUsername(username);
		ShopCart cart = shopCartDao.selectByPrimaryKey(param);
		if (cart != null) {
			cart.setJewelnum(cart.getJewelnum() + count);
			shopCartDao.updateByPrimaryKey(cart);
		} else {
			cart = new ShopCart();
			cart.setJewelnum(count);
			cart.setStyleno(styleno);
			cart.setUsername(username);
			shopCartDao.insert(cart);
		}

		return shopCartDao.selectCartSum(username);
	}

	@Override
	public boolean addCollection(String username, String styleno) {
		MyCollectionKey key = new MyCollectionKey();
		key.setStyleno(styleno);
		key.setUsername(username);
		MyCollectionKey exist = myCollectionDao.selectByPrimaryKey(key);
		if (exist != null)
			return false;
		myCollectionDao.insert(key);
		return true;

	}
	
	@Override
	public boolean delCollection(String username, String styleno) {
		MyCollectionKey key = new MyCollectionKey();
		key.setStyleno(styleno);
		key.setUsername(username);
		myCollectionDao.deleteByPrimaryKey(key);
		return true;
	}

	@Override
	public List findShopCartDetail(String username) {
		List<ShopCart> shopCartList = shopCartDao
				.selectShopCartDetail(username);
		/*
		 * Iterator<ShopCart> cartItr=shopCartList.iterator();
		 * while(cartItr.hasNext()){ ShopCart cart=cartItr.next();
		 * System.out.println("getStyleno:"+cart.getStyleno()); }
		 */

		return shopCartList;
	}

	@Override
	public boolean delFromShopCart(String username, String styleno) {
		ShopCartKey key = new ShopCartKey();
		key.setStyleno(styleno);
		key.setUsername(username);
		shopCartDao.deleteByPrimaryKey(key);
		return true;
	}

	@Override
	public int updateShopCart(String username, String param) {
		String[] params = param.split("\\]");
		List<ShopCart> cartList = new ArrayList<ShopCart>();
		for (String value : params) {
			String[] values = value.split("\\,");
			ShopCart cart = new ShopCart();
			cart.setUsername(username);
			cart.setStyleno(values[0]);
			cart.setJewelnum(Integer.parseInt(values[1]));
			shopCartDao.updateByPrimaryKey(cart);
			System.out.println(values[0] + "," + values[1]);
		}

		return 1;
	}

	@Override
	public int submitOrder(String username, String totalnum,
			String totalweight, String accessoryprice, String paytype,
			String companyid, String remark) {
		// 插入订单
		JewelOrder order = new JewelOrder();
		order.setAccessoryprice(Float.parseFloat(accessoryprice));
		order.setCompanyid(Integer.parseInt(companyid));
		order.setOrdertime(new Date());
		order.setPaytype(paytype);
		order.setStatus("待审核");
		order.setTotalnum(Integer.parseInt(totalnum));
		order.setTotalweight(Float.parseFloat(totalweight));
		order.setUsername(username);
		order.setRemark(remark);
		String s = UUID.randomUUID().toString();
		s = s.substring(0, 8) + s.substring(9, 13) + s.substring(14, 18)
				+ s.substring(19, 23) + s.substring(24);
		order.setOrderid(s);
		jewelOrderDao.insert(order);
		// 插入订单条目，删除购物车中商品，减库存
		List list = shopCartDao.selectByUserName(username);
		OrderItem item = new OrderItem();
		Iterator itr = list.iterator();
		int sequence = 1;
		while (itr.hasNext()) {
			ShopCart cart = (ShopCart) itr.next();
			Jewel jewel = jewelDao.selectByPrimaryKey(cart.getStyleno());
			int storage = jewel.getStorage() - cart.getJewelnum();
			item.setJewelnum(cart.getJewelnum());
			item.setOrderid(s);
			item.setSequence(sequence++);
			item.setStyleno(cart.getStyleno());
			item.setExpectnum(storage > 0 ? 0 : Math.abs(storage));
			orderItemDao.insert(item);
			shopCartDao.deleteByPrimaryKey(cart);

			jewel.setStorage(storage < 0 ? 0 : storage);
			jewelDao.updateByPrimaryKey(jewel);
		}

		return 1;
	}

	@Override
	public List findOrderByUsernameDate(String username, String starttime,
			String endtime) {
		Date startdate = null;
		Date enddate = null;
		DateFormat format = DateFormat.getDateInstance();
		try {
			if (starttime == null || starttime.isEmpty()) {
				startdate = new Date(0);
			} else
				startdate = format.parse(starttime);
			if (endtime == null || endtime.isEmpty()) {
				enddate = new Date();
			} else
				enddate = format.parse(endtime);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Map param = new HashMap();
		param.put("username", username);
		param.put("starttime", startdate);
		param.put("endtime", enddate);
		List orderlist=jewelOrderDao.selectByUsernameDate(param);		
		return orderlist;
	}

	@Override
	public List findOrderItemByOrderid(String orderid) {
		
		return orderItemDao.selectByOrderId(orderid);
	}
	
	@Override
	public List findOrderItemByOrderidKind(String orderid,String kindid) {
		Map map=new HashMap();
		map.put("orderid", orderid);
		map.put("kindid", kindid);
		return orderItemDao.selectByOrderIdKind(map);
	}


	@Override
	public List findCollectionsByUsername(String username) {
		// TODO Auto-generated method stub
		return myCollectionDao.selectDetailByUsername(username);
	}

	@Override
	public Jewel findJewelByStyleNo(String styleno) {
		// TODO Auto-generated method stub
		return jewelDao.selectByStyleNo(styleno);
	}

	@Override
	public int addJewel(Picture pic,String styleno, String typeno, String jewelname,
			String weight, String fineness, String specification,
			String accessory, String accessoryprice, String suite,
			String storage, String instruction, String remark) {
		//System.out.println("===========1================");
		pictureDao.insert(pic);
		//System.out.println("===========2================");
		Jewel jewel=new Jewel();
		jewel.setAccessory(accessoryprice);
		jewel.setAccessoryprice(accessoryprice.isEmpty()?0:Float.parseFloat(accessoryprice));
    	jewel.setFineness(fineness);
    	jewel.setInstruction(instruction);
    	jewel.setJewelname(jewelname);
    	jewel.setRemark(remark);
    	jewel.setSpecification(specification);
    	jewel.setStorage(storage.isEmpty()?0:Integer.parseInt(storage));
    	jewel.setStyleno(styleno);
    	jewel.setSuite(suite);
    	jewel.setTypeno(Integer.parseInt(typeno));
    	jewel.setTime(new Date());
    	jewel.setWeight(weight.isEmpty()?0:Float.parseFloat(weight));
    	jewel.setStatus("1");
    	//System.out.println("===========3================");
		return jewelDao.insert(jewel);
	}

	@Override
	public int addJewel(Jewel jewel) {
		// TODO Auto-generated method stub
		return jewelDao.insert(jewel);
	}
	
	@Override
	public int updateJewel(Picture pic,String styleno, String typeno, String jewelname,
			String weight, String fineness, String specification,
			String accessory, String accessoryprice, String suite,
			String storage, String instruction, String remark) {
		//System.out.println("===========1================");
		if(pic!=null) {
			Picture picture=pictureDao.selectByStyleno(styleno);
			if(picture==null) pictureDao.insert(pic);
			else pictureDao.updateByStyleno(pic);
		}
		//System.out.println("===========2================");
		Jewel jewel=new Jewel();
		jewel.setAccessory(accessoryprice);
		jewel.setAccessoryprice(accessoryprice.isEmpty()?0:Float.parseFloat(accessoryprice));
    	jewel.setFineness(fineness);
    	jewel.setInstruction(instruction);
    	jewel.setJewelname(jewelname);
    	jewel.setRemark(remark);
    	jewel.setSpecification(specification);
    	jewel.setStorage(storage.isEmpty()?0:Integer.parseInt(storage));
    	jewel.setStyleno(styleno);
    	jewel.setSuite(suite);
    	jewel.setTypeno(Integer.parseInt(typeno));
    	jewel.setTime(new Date());
    	jewel.setWeight(weight.isEmpty()?0:Float.parseFloat(weight));
    	//System.out.println("===========3================");
		return jewelDao.updateByPrimaryKey(jewel);
	}


	@Override
	public List findJewelByFuzzyStyleno(String styleno) {
		// TODO Auto-generated method stub
		return jewelDao.selectByFuzzyStyleNo(styleno);
	}

	@Override
	public Picture findPictureByStyleno(String styleno) {
		// TODO Auto-generated method stub
		return pictureDao.selectByStyleno(styleno);
	}

	@Override
	public List findTypeGroupByTypeno(String typeno) {
		
		return null;
	}
	
	@Override
	public int delJewelByStyleno(String styleno) {
		
		int result=jewelDao.deleteByStylenoLogic(styleno);
		//删除购物车和收藏夹中对应的数据
		myCollectionDao.deleteByStyleno(styleno);
		shopCartDao.deleteByStyleno(styleno);
			//图片不用删除,以防历史订单中存在相应的珠宝
			//pictureDao.deleteByStyleno(styleno);		
		return result;
	}

	@Override
	public List findUncheckedOrder() {
		// TODO Auto-generated method stub
		return jewelOrderDao.selectUncheckedOrder();
	}
	
	@Override
	public int updateOrderStatus(String orderid,String status) {
		Map<String,String> map=new HashMap<String,String>();
		map.put("orderid", orderid);
		map.put("status", status);
		
		/*try{
			jewelOrderDao.updateStatusByOrderid(map);
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}*/
		return jewelOrderDao.updateStatusByOrderid(map);
	}



	@Override
	public List findOrderForManage(String username, String orderStatus,
			String minDate, String maxDate){
		Map  map=new HashMap();
		//if(username.isEmpty()) username=null; 
		//if(orderStatus.isEmpty()) orderStatus=null;
		map.put("username", username);
		map.put("orderStatus", orderStatus);
		Date min,max;
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		if(minDate==null || minDate.isEmpty()){
			min=new Date(0);
		}else{
			try {
				min=format.parse(minDate);
			} catch (ParseException e) {
				min=new Date(0);
				e.printStackTrace();
			}			
		}		
		if(maxDate==null || maxDate.isEmpty()){
			max=new Date();
		}else{
			try {
				max=format.parse(maxDate);
			} catch (ParseException e) {
				max=new Date();
				e.printStackTrace();
			}			
		}
		map.put("minDate", min);
		map.put("maxDate", max);
/*		System.out.println("========"+username);
		System.out.println("========"+orderStatus);
		System.out.println("========"+min);
		System.out.println("========"+max);*/
		return jewelOrderDao.selectCheckedOrder(map);
	}

	@Override
	public JewelType addJewelType(String typename,String prefix){
		if(typename==null) return null;	
		JewelType type=new JewelType();				
		int id=jewelTypeDao.selectMaxId(prefix);
		if(id==0) id=Integer.parseInt(prefix+"00");
		type.setTypename(typename);		
		//System.out.println("id"+id);
		type.setTypeid(String.valueOf(id+1));  //将新类型的id设置成已经存在的id最大值+1
		jewelTypeDao.insert(type);
		return type;
	}
	@Override
	public int updateJewelType(String typename,String typeid){
		JewelType type=new JewelType();
		type.setTypename(typename);
		type.setTypeid(typeid);
		return jewelTypeDao.updateTypename(type);
	}
	
	@Override
	public int deleteJewelType(String typeid){
		return jewelTypeDao.deleteByTypeid(typeid);
	}
	
	
	@Override
	public JewelSubType addJewelSubType(String typename,String prefix){
		if(typename==null) return null;	
		JewelSubType type=new JewelSubType();				
		int id=jewelSubTypeDao.selectMaxId(prefix);
		if(id==0) id=Integer.parseInt(prefix+"00");
		type.setSubtypename(typename);		
		//System.out.println("id"+id);
		type.setSubtypeid(String.valueOf(id+1));  //将新类型的id设置成已经存在的id最大值+1
		jewelSubTypeDao.insert(type);
		return type;
	}
	
	@Override
	public int updateJewelSubType(String typename,String typeid){
		JewelSubType type=new JewelSubType();
		type.setSubtypename(typename);
		type.setSubtypeid(typeid);
		return jewelSubTypeDao.updateTypename(type);
	}
	
	@Override
	public int deleteJewelSubType(String typeid){
		return jewelSubTypeDao.deleteByTypeid(typeid);
	}
	
	

	
	

}
