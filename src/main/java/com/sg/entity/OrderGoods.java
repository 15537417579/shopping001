package com.sg.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

@Data
public class OrderGoods  implements Serializable {
    @TableId
    private Integer orderGoodsId;

    private Integer orderId;

    private Integer goodsId;

    private String goodsName;

    private BigDecimal unitPrice;

    private Integer amount;

    private Integer discount;

}