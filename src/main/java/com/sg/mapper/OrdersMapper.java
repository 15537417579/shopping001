package com.sg.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.sg.entity.Cart;
import com.sg.entity.Orders;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrdersMapper extends BaseMapper<Orders> {
    int deleteByPrimaryKey(Integer orderId);


    int insertSelective(Orders record);

    Orders selectByPrimaryKey(Integer orderId);

    int updateByPrimaryKeySelective(Orders record);

    int updateByPrimaryKey(Orders record);

    /**
     * 插入
     * @param cartId
     * @param userId
     * @return
     */
    List<Orders> selectDataForOrders(@Param("cartIds") List<Integer> cartId, @Param("userId")Integer userId);

    /**
     * 批量插入订单
     * @param ordersList
     */
    void insertBatch(@Param("ordersList") List<Orders> ordersList);
}