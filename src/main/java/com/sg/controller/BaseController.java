package com.sg.controller;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import java.text.SimpleDateFormat;
import java.util.Date;

public class BaseController {
    @InitBinder
    public void initBinder(WebDataBinder binder){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        format.setLenient(true);
        binder.registerCustomEditor(Date.class,new CustomDateEditor(format,true));
    }

    /**
     * 当出现异常时直接进入这个模块
     * @param e
     * @return
     *//*
    @ExceptionHandler
    public String aaa(Exception e, HttpServletRequest req, HttpServletResponse resp){
        System.out.println("捕获一枚异常");
        //判断是哪种异常
        if(e instanceof ArithmeticException){
            req.setAttribute("msg","除0异常");//配置异常信息，传到前台
        }else if(e instanceof FileNotFoundException){
            req.setAttribute("msg","文件没找着");//配置异常信息，传到前台
        }else{
            req.setAttribute("msg","其他异常");//配置异常信息，传到前台
        }
        return "error";//返回jsp页面
    }*/
}
