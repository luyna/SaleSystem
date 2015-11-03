package com.luyna.dao;

import java.util.List;

import com.luyna.pojo.User;

public interface UserMapper {
    int deleteByPrimaryKey(Integer userid);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userid);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    /**
     * 根据用户名找到相应的记录，用户名是唯一的
     * @param username
     * @return
     */
    User selectByUsername(String username);
    /**
     * 根据用户名修改用户密码
     * @param user
     * @return
     */
    public int  updatePasswordByUsername(User user);
    /**
     * 修改用户信息
     * @param user
     * @return
     */
    public int  updateUserInfo(User user);
    /**
     * 找出所有注册未审核的用户
     * @return
     */
    public List selectAllUnChecked();
    /**
     * 修改用户状态为“审核通过”
     * @param username
     * @return
     */
    public int updateUserStatus(String username);
    /**
     * 物理删除用户
     * @param username
     * @return
     */
    public int deleteByUsername(String username);
    
    public List selectAllChecked();
}