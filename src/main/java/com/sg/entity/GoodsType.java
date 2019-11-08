package com.sg.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import lombok.Data;

import java.io.Serializable;

@Data
public class GoodsType  implements Serializable {
    @TableId
    private Integer typeId;

    private String typeName;

    private String introduce;

    private String imgUrl;


}