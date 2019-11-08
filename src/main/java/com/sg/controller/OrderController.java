package com.sg.controller;

import com.sg.entity.Orders;
import com.sg.entity.ResponseResult;
import com.sg.entity.UserInfo;
import com.sg.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;


@RestController
@RequestMapping("orders")
public class OrderController extends BaseController{

    @Autowired
    private OrderService orderService;

    @RequestMapping("submitOrders")
    public ResponseResult submitOrders(@RequestBody List<Integer> cartIds, HttpSession session){
        Integer userId = ((UserInfo) session.getAttribute("user")).getUserId();


       List<Orders> ordersList = orderService.selectDataForOrders(cartIds,userId);

        for (Orders orders : ordersList) {
            System.out.println("订单的信息："+orders);
        }
        return new ResponseResult("okla",ordersList);
    }

}
