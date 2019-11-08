package com.sg.entity;

import lombok.Data;

import java.util.List;
@Data
public class PageBean<T> {

    // success
    private Integer pageCount=10;//每页需要显示几条记录
    private Integer totalCount;//共有多少条记录
    private Integer totalPage;//总页数
    private Integer currPage;//当前页数   前台传的参数
    private Integer firstPage;//当页第一条  通过前台的参数 算出来的
    private List<T> list; //将所查到的商品数 包装进来
    //计算共有多少页
    public void getTotalPage1(){
        Double totalCount1 = new Double(totalCount);
        totalPage = (int)Math.ceil(totalCount1 / pageCount);

    }

    //计算当页第一条（数据库）
    public void getFirstPage1(){
        firstPage = (currPage - 1) * pageCount;
    }

    public PageBean() {
    }

    public PageBean(Integer pageCount, Integer totalCount, Integer totalPage, Integer currPage, Integer firstPage) {
        this.pageCount = pageCount;
        this.totalCount = totalCount;
        this.totalPage = totalPage;
        this.currPage = currPage;
        this.firstPage = firstPage;
    }



}
