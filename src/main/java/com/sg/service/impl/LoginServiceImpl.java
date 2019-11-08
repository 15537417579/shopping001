package com.sg.service.impl;

import com.sg.entity.UserInfo;
import com.sg.mapper.UserInfoMapper;
import com.sg.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private UserInfoMapper userInfoMapper;

    @Override
    public void register(UserInfo userInfo) {
        userInfoMapper.insertSelective(userInfo);
    }

    @Override
    public UserInfo checkUserName(String userName) {

        return userInfoMapper.selectByUserName(userName);
    }

    @Override
    public UserInfo login(UserInfo userInfo) {
        return userInfoMapper.login(userInfo);
    }
}
