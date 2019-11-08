package com.sg.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import lombok.Data;

import java.io.Serializable;

/**
 * 条件查询封装的类
 */
@Data
public class GoodsCon  implements Serializable {
    @TableId
   private String goodsNameCon;
   private Integer priceBeginCon;
   private Integer priceEndCon;
   private Integer  gtIdCon;


}
