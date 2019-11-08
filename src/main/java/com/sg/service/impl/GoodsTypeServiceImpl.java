package com.sg.service.impl;

import com.sg.entity.GoodsType;
import com.sg.mapper.GoodsTypeMapper;
import com.sg.service.GoodsTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsTypeServiceImpl implements GoodsTypeService {

    @Autowired
    private GoodsTypeMapper goodsTypeMapper;


    @Override
    public List<GoodsType> findAllGoodsType() {
        return goodsTypeMapper.findAllGoodsType();
    }
}
