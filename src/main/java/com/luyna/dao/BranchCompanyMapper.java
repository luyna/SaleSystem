package com.luyna.dao;

import java.util.List;
import java.util.Map;

import com.luyna.pojo.BranchCompany;

public interface BranchCompanyMapper {
    int deleteByCompanyId(Integer companyid);

    int insert(BranchCompany record);

    int insertSelective(BranchCompany record);

    BranchCompany selectByPrimaryKey(Integer companyid);

    int updateByPrimaryKeySelective(BranchCompany record);

    int updateByPrimaryKey(BranchCompany record);
    /**
     * 根据用户名找到该用户的所有分店
     * @param username
     * @return
     */
    public List selectByUsername(String username);
    /**
     * 根据用户名和分店编号找出分店信息
     * @param map
     * @return
     */
    public BranchCompany selectByUsernameCompanyid(Map map);
    /**
     * 删除用户的分店
     * @param username
     * @return
     */
    public int deleteByUsername(String username);

}