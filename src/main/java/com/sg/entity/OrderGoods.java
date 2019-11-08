package com.sg.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import lombok.Data;

import java.io.Serializable;

@Data
public class OrderGoods  implements Serializable {
    @TableId
    private Integer orderGoodsId;

    private Integer orderId;

    private Integer goodsId;

    private String goodsName;

    private Long unitPrice;

    private Integer amount;

    private Integer discount;

}