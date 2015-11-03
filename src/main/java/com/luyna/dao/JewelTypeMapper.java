package com.luyna.dao;

import java.util.List;

import com.luyna.pojo.JewelSubType;
import com.luyna.pojo.JewelType;

public interface JewelTypeMapper {
    int insert(JewelType record);

    int insertSelective(JewelType record);
    /**
     * 找出所有类型
     * @return
     */
    public List<JewelType> selectAll();
    /**
     * 根据类别前缀找出类别下的类型，如类别3D硬千足金编号为1，下面的类型包括以1开头的类型：项链/吊坠/戒指等
     * @param prefix
     * @return
     */
    public List<JewelType> selectByPrefix(String prefix);
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
    public int updateTypename(JewelType type);
    /**
     * 删除类型
     * @param typeid
     * @return
     */
    public int deleteByTypeid(String typeid);
}