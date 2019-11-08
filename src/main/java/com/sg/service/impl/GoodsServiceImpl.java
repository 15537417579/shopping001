package com.sg.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sg.entity.Goods;
import com.sg.entity.GoodsCon;
import com.sg.entity.PageBean;
import com.sg.entity.UserInfo;
import com.sg.mapper.GoodsMapper;
import com.sg.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class GoodsServiceImpl implements GoodsService {

    @Autowired
    private GoodsMapper goodsMapper;

    @Override
    public List<Goods> findAllGoods() {
        return goodsMapper.findAllGoods();
    }

    @Override
    public List<Goods> findGoodsListByPage(PageBean pageBean) {
        return goodsMapper.findGoodsListByPage(pageBean);
    }

    @Override
    public Integer findGoodsCount() {
        return goodsMapper.findGoodsCount();
    }

    @Override
    public Integer findGoodsCountByCon(GoodsCon goodsCon) {
        return goodsMapper.findGoodsCountByCon(goodsCon);
    }

    @Override
    public List<Goods> findGoodsListByPageAndCon(PageBean pageBean, GoodsCon goodsCon) {
        return goodsMapper.findGoodsListByPageAndCon(pageBean, goodsCon) ;
    }

    @Override
    public Goods findGoodsById(Integer goodsId) {
        return goodsMapper.selectByPrimaryKey(goodsId);
    }

    @Override
    public void addGoods(Goods goods) {
        goodsMapper.insert(goods);
    }

    /**
     * 通过用户的id查询对于的商品列表
     * @param idNum
     * @return
     */
    @Override
    public List<Goods> getGoodsListByUserId(Integer idNum) {
//        包装UserInfo 来作为条件查询
        EntityWrapper userInfoEntityWrapper = new EntityWrapper();

        userInfoEntityWrapper.eq("user_id",idNum);

        List<Goods> goodsList = goodsMapper.selectList(userInfoEntityWrapper);


        return goodsList;
    }

    @Override
    public PageInfo<Goods> getGoodsListByUserIdAndPage(Integer currentPage,Integer userId) {
        PageHelper.startPage(currentPage,4);

        EntityWrapper entityWrapper = new EntityWrapper();
        entityWrapper.eq("user_id", userId);
        List<Goods> list = goodsMapper.selectList(entityWrapper);
        PageInfo<Goods> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public void editGoods(Goods goods) {
        goodsMapper.updateById(goods);
    }

    @Override
    public void delGoodsById(Integer goodsId) {
        goodsMapper.deleteByPrimaryKey(goodsId);
    }
}
