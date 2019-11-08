package com.sg.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
@Data
public class Goods  implements Serializable {
    @TableId
    private Integer goodsId;

    private String goodsName;

    private Integer userId;

    private Integer gtId;

    private String spec;

    private BigDecimal unitPrice;

    private Integer stock;

    private String imgUrl;

    private String introduce;

    private Date vaildDate;


}