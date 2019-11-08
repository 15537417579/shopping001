package com.sg.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.sg.entity.Cart;
import com.sg.entity.GoodsType;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface GoodsTypeMapper extends BaseMapper<GoodsType> {
    int deleteByPrimaryKey(Integer typeId);


    int insertSelective(GoodsType record);

    GoodsType selectByPrimaryKey(Integer typeId);

    int updateByPrimaryKeySelective(GoodsType record);

    int updateByPrimaryKey(GoodsType record);

    @Select("select * from goods_type")
    @ResultMap("BaseResultMap")
    List<GoodsType> findAllGoodsType();
}