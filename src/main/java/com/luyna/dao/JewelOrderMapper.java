package com.luyna.dao;

import java.util.List;
import java.util.Map;

import com.luyna.pojo.JewelOrder;

public interface JewelOrderMapper {
    int deleteByPrimaryKey(String orderid);

    int insert(JewelOrder record);

    int insertSelective(JewelOrder record);

    JewelOrder selectByPrimaryKey(String orderid);

    int updateByPrimaryKeySelective(JewelOrder record);

    int updateByPrimaryKey(JewelOrder record);
    /**
     * 根据用户名和日期筛选订单（所有状态的订单）
     * @param map
     * @return
     */
    public List selectByUsernameDate(Map map);
    /**
     * 获取所有“未审核”订单
     * @return
     */
    public List selectUncheckedOrder();
    /**
     * 更新订单状态
     * @param map
     * @return
     */
    public int updateStatusByOrderid(Map map);
    /**
     * 获取所有已经审核过的订单
     * @return
     */
    public List selectCheckedOrder(Map map);
}