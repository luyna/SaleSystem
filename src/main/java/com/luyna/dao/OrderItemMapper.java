package com.luyna.dao;

import java.util.List;
import java.util.Map;

import com.luyna.pojo.OrderItem;
import com.luyna.pojo.OrderItemKey;

public interface OrderItemMapper {
    int deleteByPrimaryKey(OrderItemKey key);

    int insert(OrderItem record);

    int insertSelective(OrderItem record);

    OrderItem selectByPrimaryKey(OrderItemKey key);

    int updateByPrimaryKeySelective(OrderItem record);

    int updateByPrimaryKey(OrderItem record);
    /**
     * 根据订单号找出该订单中的所有商品条目
     * @param orderid
     * @return
     */
    public List selectByOrderId(String orderid);
    /**
     * 根据订单号和类别筛选订单条目
     * @param map
     * @return
     */
    public List selectByOrderIdKind(Map map);
}