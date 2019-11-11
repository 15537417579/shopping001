package com.sg.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.sg.entity.Cart;
import com.sg.entity.Goods;
import com.sg.entity.GoodsCon;
import com.sg.entity.PageBean;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface GoodsMapper extends BaseMapper<Goods> {
 int deleteByPrimaryKey(Integer goodsId);



    int insertSelective(Goods record);

    Goods selectByPrimaryKey(Integer goodsId);

    int updateByPrimaryKeySelective(Goods record);

    int updateByPrimaryKey(Goods record);

    List<Goods> findAllGoods();

    List<Goods> findGoodsListByPage(PageBean pageBean);

    @Select("select count(1) from goods")
    Integer findGoodsCount();

    Integer findGoodsCountByCon(GoodsCon goodsCon);

    List<Goods> findGoodsListByPageAndCon(@Param("pageBean") PageBean pageBean,@Param("goodsCon")GoodsCon goodsCon);

    void updateStock(@Param("amount") Integer amount, @Param("stock") Integer stock);

}