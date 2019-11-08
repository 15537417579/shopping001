package com.sg.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class CartVo  implements Serializable {
    private String petName;
    private List<GoodsVo> list;
    /**
     * c.CART_ID,c.AMOUNT,
     *     g.GOODS_NAME,g.IMG_URL,g.STOCK,g.UNIT_PRICE,
     *     ui.PET_NAME
     */
}
