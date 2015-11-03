package com.luyna.dao;

import java.util.List;

import com.luyna.pojo.ShopCart;
import com.luyna.pojo.ShopCartKey;

public interface ShopCartMapper {

	int deleteByPrimaryKey(ShopCartKey key);

    int insert(ShopCart record);

    int insertSelective(ShopCart record);

    ShopCart selectByPrimaryKey(ShopCartKey key);

    int updateByPrimaryKeySelective(ShopCart record);

    int updateByPrimaryKey(ShopCart record);
    /**
     * 统计用户购物车中珠宝的总个数
     * @param username
     * @return
     */
    public int selectCartSum(String username);
    /**
     * 找出指定用户购物车中的商品
     * @param username
     * @return
     */
    public List selectByUserName(String username);
    /**
     * 根据用户名找出购物车中的商品详细信息
     * @param username
     * @return
     */
    public List selectShopCartDetail(String username);
    /**
     * 批量更新购物车中珠宝的数量
     * @param list
     * @return
     */
   // public int batchUpdate(List<ShopCart> list);
    /**
     * 删除对应款号的收藏
     * @param styleno
     * @return
     */
    public int deleteByStyleno(String styleno);
    
}