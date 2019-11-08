package com.sg.entity;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
@Data
public class GoodsVo  implements Serializable {
    private String goodsName;     //1：商品名称
    private Integer cartId;       //2：购物车Id
    private Integer goodsId;      //3：商品Id
    private BigDecimal unitPrice; //4：商品单价
    private Integer stock;        //5：商品库存
    private String ImgUrl;        //6：商品图片地址
    private Integer amount;       //7：商品数量
    /**
     * c.CART_ID,c.AMOUNT,
     *     g.GOODS_NAME,g.IMG_URL,g.STOCK,g.UNIT_PRICE,
     *     ui.PET_NAME
     */
}
