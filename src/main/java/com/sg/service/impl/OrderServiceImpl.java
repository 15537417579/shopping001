package com.sg.service.impl;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.sg.entity.GoodsVo;
import com.sg.entity.OrderGoods;
import com.sg.entity.Orders;
import com.sg.mapper.CartMapper;
import com.sg.mapper.GoodsMapper;
import com.sg.mapper.OrderGoodsMapper;
import com.sg.mapper.OrdersMapper;
import com.sg.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrdersMapper ordersMapper;

    @Autowired
    private OrderGoodsMapper orderGoodsMapper;

    @Autowired
    private CartMapper cartMapper;

    @Autowired
    private GoodsMapper goodsMapper;

    @Override
    public String submitOrders(List<Integer> cartIds, Integer userId) {
//        准备订单需要的数据
        List<Orders> ordersList = ordersMapper.selectDataForOrders(cartIds, userId);
//        生产订单
        ordersMapper.insertBatch(ordersList); //返回主键

        ordersList.stream().forEach((list)-> System.out.println(list));//这个list里存的是orderId

//        生成订单商品表
        List<GoodsVo> goodsVos = ordersMapper.selectForOrdersGoods(cartIds);
        goodsVos.stream().forEach((list)-> System.out.println(list));

        for (GoodsVo goodsVo : goodsVos) {
            for (Orders orders : ordersList) {
                //假设现在正在对手机商品找orderId,遍历所有的订单，哪个卖家跟我手机对上了，就是它
                if (goodsVo.getSalerId() == orders.getSalerId()){
                    OrderGoods orderGoods = new OrderGoods();
                    orderGoods.setDiscount(100);
                    orderGoods.setUnitPrice(goodsVo.getUnitPrice());
                    orderGoods.setOrderId(orders.getOrderId());
                    System.out.println("orders.getOrderId()=="+orders.getOrderId());
                    orderGoods.setGoodsName(goodsVo.getGoodsName());
                    orderGoods.setAmount(goodsVo.getAmount());
                    orderGoods.setGoodsId(goodsVo.getGoodsId());
                    System.out.println("orderGoods"+orderGoods);
//                    插入数据库
                    orderGoodsMapper.insert(orderGoods);
                    System.out.println("orderGoods:"+orderGoods);
                    break;
                }
            }
        }

        //清除购物车数据

        cartMapper.deleteBatchIds(cartIds);
//        减去库存
        for (GoodsVo goodsVo : goodsVos) {
            Integer amount = goodsVo.getAmount();
            Integer stock = goodsVo.getStock();
            goodsMapper.updateStock(amount,stock);
        }

        //把订单ids返回给前端
        StringBuilder stringBuilder = new StringBuilder("");
        for (Orders orders : ordersList) {
            stringBuilder.append(orders.getOrderId()).append(",");
        }
//        去除最后一个括号
        stringBuilder.deleteCharAt(stringBuilder.length()-1);
        return stringBuilder.toString();
    }


}
