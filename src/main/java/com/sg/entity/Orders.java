package com.sg.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
@Data
public class Orders  implements Serializable {
    @TableId
    private Integer orderId;

    private Date orderDate;

    private Integer buyerId;

    private String bPetName;

    private Integer salerId;

    private String salerName;

    private String address;

    private String telephone;

    private String buyerRemarks;

    private String status;

}