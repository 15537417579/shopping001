package com.sg.controller;

import com.sg.entity.Orders;
import com.sg.entity.OrdersVO;
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
//       获取userId
        Integer userId = ((UserInfo) session.getAttribute("user")).getUserId();
//        调用业务方法
        String s = orderService.submitOrders(cartIds, userId);
//        返回消息


        return new ResponseResult("okla",s);
    }

    @RequestMapping("getOrderList")
    public ResponseResult getOrderList(@RequestBody List<Integer> orderIds){
        List<OrdersVO> list = orderService.selectOrderList(orderIds);
        return new ResponseResult("ok",list);
    }

}
