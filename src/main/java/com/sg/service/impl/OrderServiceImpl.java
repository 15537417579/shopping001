package com.sg.service.impl;

import com.sg.entity.Orders;
import com.sg.mapper.OrdersMapper;
import com.sg.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrdersMapper ordersMapper;

    @Override
    public List<Orders> selectDataForOrders(List<Integer> cartId, Integer userId) {
        return ordersMapper.selectDataForOrders(cartId,userId);
    }
}
