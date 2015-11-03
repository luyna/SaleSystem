package com.luyna.dao;

import java.util.List;
import java.util.Map;

import com.luyna.pojo.Jewel;

public interface JewelMapper {
    int deleteByPrimaryKey(String styleno);

    int insert(Jewel record);

    int insertSelective(Jewel record);

    Jewel selectByPrimaryKey(String styleno);

    int updateByPrimaryKeySelective(Jewel record);

    int updateByPrimaryKey(Jewel record);
    /**
     * 根据类型查看珠宝
     * @param type
     * @return
     */
    public List<Jewel> selectByType(String type);
    /**
     * 根据类型前缀查看珠宝
     * @param prefix
     * @return
     */
    public List<Jewel> selectByTypePrefix(String prefix);
    /**
     * 根据款号和重量模糊检索珠宝
     * @param styleno
     * @param minWeight
     * @param maxWeight
     * @return
     */
    public List selectByStylenoWeight(Map<String,String> map);
    /**
     * 根据款号找出珠宝详情信息
     * @param styleno
     * @return
     */
    public Jewel selectByStyleNo(String styleno);
    /**
     * 根据款号模糊检索
     * @param styleno
     * @return
     */
    public List selectByFuzzyStyleNo(String styleno);
    /**
     * 逻辑删除珠宝信息
     * @param styleno
     * @return
     */
    public int deleteByStylenoLogic(String styleno);
}