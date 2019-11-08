package com.sg.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import lombok.Data;

import java.io.Serializable;

@Data
public class Cart implements Serializable {
    @TableId
    private Integer cartId;

    private Integer myCartId;

    private Integer goodsId;

    private Integer amount;

}