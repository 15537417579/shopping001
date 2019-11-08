package com.sg.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.sg.entity.Cart;
import com.sg.entity.UserInfo;
import org.apache.ibatis.annotations.Param;

public interface UserInfoMapper extends BaseMapper<UserInfo> {
    int deleteByPrimaryKey(Integer userId);


    int insertSelective(UserInfo record);

    UserInfo selectByPrimaryKey(Integer userId);

    int updateByPrimaryKeySelective(UserInfo record);

    int updateByPrimaryKey(UserInfo record);

    UserInfo selectByUserName(@Param("userName") String userName);

    UserInfo login(UserInfo userInfo);
}