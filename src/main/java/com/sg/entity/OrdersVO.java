package com.sg.entity;

import lombok.Data;

import java.util.List;

@Data
public class OrdersVO {
    private String petName;//卖家姓名
    private Integer ordersId;//订单id
    private List<GoodsVo> list; //商品包装集合
    
}
