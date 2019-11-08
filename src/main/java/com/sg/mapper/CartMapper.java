package com.sg.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.sg.entity.Cart;
import com.sg.entity.CartVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CartMapper extends BaseMapper<Cart> {
    int deleteByPrimaryKey(Integer cartId);



    int insertSelective(Cart record);

    Cart selectByPrimaryKey(Integer cartId);

    int updateByPrimaryKeySelective(Cart record);

    int updateByPrimaryKey(Cart record);

    List<CartVo> getCartList(@Param("userId") Integer userId);
}