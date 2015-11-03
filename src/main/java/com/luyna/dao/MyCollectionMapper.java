package com.luyna.dao;

import java.util.List;

import com.luyna.pojo.MyCollection;
import com.luyna.pojo.MyCollectionKey;

public interface MyCollectionMapper {
    int deleteByPrimaryKey(MyCollectionKey key);

    int insert(MyCollectionKey record);

    int insertSelective(MyCollectionKey record);
    
    public MyCollectionKey selectByPrimaryKey(MyCollectionKey key);
    /**
     * 根据用户名找出用户收藏夹中的商品
     * @param username
     * @return
     */
    public List selectDetailByUsername(String username);
    /**
     * 删除对应款号的收藏
     * @param styleno
     * @return
     */
    public int deleteByStyleno(String styleno);
    
}