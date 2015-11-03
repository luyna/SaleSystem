package com.luyna.dao;

import java.util.List;

import com.luyna.pojo.JewelSubType;
import com.luyna.pojo.JewelType;

public interface JewelSubTypeMapper {
    int insert(JewelSubType record);

    int insertSelective(JewelSubType record);
    /**
     * 根据类型前缀找出类型下的子类型，如吊坠包括佛/观音/羊系列等
     * @param prefix
     * @return
     */
    public List<JewelSubType> selectByPrefix(String prefix);
    /**
     * 找出相应前缀的最大Id号
     * @param prefix
     * @return
     */
    public int selectMaxId(String prefix);
    /**
     * 更新类型
     * @param type
     * @return
     */
    public int updateTypename(JewelSubType type);
    /**
     * 删除类型
     * @param typeid
     * @return
     */
    public int deleteByTypeid(String typeid);
}