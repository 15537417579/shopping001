package com.sg.service;

import com.sg.entity.GoodsVo;
import com.sg.entity.Orders;
import com.sg.entity.OrdersVO;

import java.util.List;

public interface OrderService {

    public String submitOrders(List<Integer> cartIds, Integer userId);

    List<OrdersVO> selectOrderList(List<Integer> orderIds);
}
