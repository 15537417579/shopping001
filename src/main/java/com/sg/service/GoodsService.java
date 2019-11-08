package com.sg.service;

import com.github.pagehelper.PageInfo;
import com.sg.entity.Goods;
import com.sg.entity.GoodsCon;
import com.sg.entity.PageBean;

import java.util.List;

public interface GoodsService {
    List<Goods> findAllGoods();

    List<Goods> findGoodsListByPage(PageBean pageBean);

    Integer findGoodsCount();

    Integer findGoodsCountByCon(GoodsCon goodsCon);

    List<Goods> findGoodsListByPageAndCon(PageBean pageBean, GoodsCon goodsCon);

    Goods findGoodsById(Integer goodsId);

    void addGoods(Goods goods);

    List<Goods> getGoodsListByUserId(Integer id);

    PageInfo<Goods> getGoodsListByUserIdAndPage(Integer currentPage,Integer userId);

    void editGoods(Goods goods);

    void delGoodsById(Integer goodsId);
}
