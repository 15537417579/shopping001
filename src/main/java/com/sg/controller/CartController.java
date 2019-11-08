package com.sg.controller;

import com.sg.entity.Cart;
import com.sg.entity.CartVo;
import com.sg.entity.ResponseResult;
import com.sg.entity.UserInfo;
import com.sg.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;
/*
* 相当于@Controller+@ResponseBody两个注解的结合，返回json数据不需要在方法前面加@ResponseBody注解了，
* 但使用@RestController这个注解，就不能返回jsp,html页面，视图解析器无法解析jsp,html页面
* */
@RestController
@RequestMapping("cart")
public class CartController {

    @Autowired
    private CartService cartService;

    /**
     * 增加新的购物车记录
     * @param goodsId
     * @param session
     * @return
     */
    @RequestMapping("addGoodsToCart")
    public ResponseResult addGoodsToCart(Integer goodsId, HttpSession session) {
        System.out.println("进入了addGoodsToCart===========================================");
        Integer userId = ((UserInfo) session.getAttribute("user")).getUserId();
        //        调用方法插入
        Cart cart = cartService.selectGoodsHadInCart(goodsId,userId);
        if (cart != null){ //此刻购物车有这样的商品类型 所以数量加一
            cart.setAmount(cart.getAmount()+1);
            cartService.updateGoodsAmountHadInCart(cart);
        }else{//此刻购物车没有有这样的商品类型
            cartService.addGoodsToCart(goodsId,userId);
        }
        return new ResponseResult("好的啦");
    }

    /**
     * 获取购物车列表
     * @param session
     * @return
     */
    @RequestMapping("getCartList")
    public ResponseResult getCartList(HttpSession session){
        System.out.println("getCartList.do......");
        Integer userId = ((UserInfo) session.getAttribute("user")).getUserId();
        List<CartVo> cartList= cartService.getCartList(userId); //通过userId去后台查询
        return new ResponseResult("ok",cartList);
    }

    /**
     * 更新购物车
     * @param cart
     * @param session
     * @return
     */
    @RequestMapping("UpdateCartList")
    public ResponseResult UpdateCartList(Cart cart,HttpSession session){
        System.out.println("UpdateCartList.do......");

        cartService.updateGoodsAmountHadInCart(cart);//修改购物车的数量

        Integer userId = ((UserInfo) session.getAttribute("user")).getUserId();
        List<CartVo> cartList= cartService.getCartList(userId); //通过userId去后台查询

        return new ResponseResult("ok",cartList);
    }

    /**
     * 删除购物车的记录
     * @param cardId
     * @param session
     * @return
     */
    @RequestMapping("delGoodsInCart")
    public ResponseResult delGoodsInCart(Integer cardId,HttpSession session){
        System.out.println("UpdateCartList.do......");

        cartService.delGoodsInCart(cardId);//删除购物车记录

        Integer userId = ((UserInfo) session.getAttribute("user")).getUserId();
        List<CartVo> cartList= cartService.getCartList(userId); //通过userId去后台查询

        return new ResponseResult("ok",cartList);
    }

    /**
     * 批量删除 后台通过数组接收
     * @param cardIds
     * @param session
     * @return
     */
    @RequestMapping("delBatch")
    public ResponseResult delBatch(Integer[] cardIds,HttpSession session){
//        批量删除的动作
        cartService.delBatch(cardIds);
//        当批量删除之后 从新去数据库查询数据 并返回到 前端
        Integer userId = ((UserInfo) session.getAttribute("user")).getUserId();
        List<CartVo> cartList = cartService.getCartList(userId);
        return new ResponseResult("ok",cartList);
    }

    /**
     * 批量删除 后台通过集合接收
     * 这里注意 如果使用数组接受 那就需要加上@RequestBody这个注解
     * @param cardIds
     * @param session
     * @return
     */
    @RequestMapping("delBatchByRequestBody")
    public ResponseResult delBatchByRequestBody(@RequestBody List<Integer> cardIds, HttpSession session){
//        批量删除的动作
        cartService.delBatchByRequestBody(cardIds);
//        当批量删除之后 从新去数据库查询数据 并返回到 前端
        Integer userId = ((UserInfo) session.getAttribute("user")).getUserId();
        List<CartVo> cartList = cartService.getCartList(userId);
        return new ResponseResult("ok",cartList);
    }
}
