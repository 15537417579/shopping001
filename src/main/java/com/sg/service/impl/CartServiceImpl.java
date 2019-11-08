package com.sg.service.impl;

import com.sg.entity.Cart;
import com.sg.entity.CartVo;
import com.sg.entity.UserInfo;
import com.sg.mapper.CartMapper;
import com.sg.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service
public class CartServiceImpl  implements CartService {
    @Autowired
    private CartMapper cartMapper;

    /**
     * 添加新的商品到用户的购物车中去
      * @param goodsId
     * @param userId
     */

    @Override
    public void addGoodsToCart(Integer goodsId, Integer userId) {
        Cart cart = new Cart();
        cart.setAmount(1);
        cart.setGoodsId(goodsId);
        cart.setMyCartId(userId);
        cartMapper.insert(cart);
    }

    /**
     * 查找是已经该用户是否已经存在该商品
     * @param goodsId
     * @param userId
     * @return
     */
    @Override
    public Cart selectGoodsHadInCart(Integer goodsId, Integer userId) {
        Cart cart = new Cart();
        cart.setGoodsId(goodsId);
        cart.setMyCartId(userId);
        Cart cart1 = cartMapper.selectOne(cart);
        return cart1;
    }

    /**
     * 更新已经存在的商品
     * @param cart
     */
    @Override
    public void updateGoodsAmountHadInCart(Cart cart) {
        cartMapper.updateByPrimaryKeySelective(cart);
    }

    /**
     * 得到购物车的全部信息
     * @param userId
     * @return
     */
    @Override
    public List<CartVo> getCartList(Integer userId) {
        return cartMapper.getCartList(userId);
    }

    /**
     * 单个删除购物车记录
     * @param cardId
     */
    @Override
    public void delGoodsInCart(Integer cardId) {
        cartMapper.deleteById(cardId);
    }

    /**
     * 批量删除数据 参数是数组
     * @param cardIds
     */
    @Override
    public void delBatch(Integer[] cardIds) {
        cartMapper.deleteBatchIds(Arrays.asList(cardIds));
    }

    /**
     * 批量删除  参数是集合
     * @param cardIds
     */
    @Override
    public void delBatchByRequestBody(List<Integer> cardIds) {
        cartMapper.deleteBatchIds(cardIds);
    }
}
