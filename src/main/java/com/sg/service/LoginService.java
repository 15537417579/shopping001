package com.sg.service;

import com.sg.entity.UserInfo;

public interface LoginService {

    void register(UserInfo userInfo);

    UserInfo checkUserName(String userName);

    UserInfo login(UserInfo userInfo);
}
