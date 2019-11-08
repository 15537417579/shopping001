package com.sg.service;

import com.sg.entity.Cart;
import com.sg.entity.CartVo;

import java.util.List;

public interface CartService {


    void addGoodsToCart(Integer goodsId, Integer userId);

    Cart selectGoodsHadInCart(Integer goodsId, Integer userId);

    void updateGoodsAmountHadInCart(Cart cart);

    List<CartVo> getCartList(Integer userId);

    void delGoodsInCart(Integer cardId);

    void delBatch(Integer[] cardIds);

    void delBatchByRequestBody(List<Integer> cardIds);
}
