package com.luyna.dao;

import com.luyna.pojo.Picture;

public interface PictureMapper {
    int insert(Picture record);

    int insertSelective(Picture record);
    /**
     * 根据款号查询图片
     * @param styleno
     * @return
     */
    public Picture selectByStyleno(String styleno);
    /**
     * 跟新图片
     * @param styleno
     * @return
     */
    public int updateByStyleno(Picture pic);
    /**
     * 删除图片
     * @param styleno
     * @return
     */
    public int deleteByStyleno(String styleno);
}