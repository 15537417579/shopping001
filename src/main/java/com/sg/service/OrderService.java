package com.sg.service;

import com.sg.entity.Orders;

import java.util.List;

public interface OrderService {
    List<Orders> selectDataForOrders(List<Integer> cartId, Integer userId);
}
