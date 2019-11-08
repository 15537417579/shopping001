package com.sg.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
@Data
public class UserInfo  implements Serializable {
    @TableId
    private Integer userId;

    private String userName;

    private String password;

    private String petName;

    private String name;

    private String sex;

    private String age;

    private String idNum;

    private Date birthday;

    private String telephone;

    private String address;

    private Integer storeHonor;

    private Date registerDate;

    private String remarks;


}