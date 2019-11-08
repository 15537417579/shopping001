package com.sg.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("test1")
@Controller
public class TestController {
    @RequestMapping("test")
    public void test(){
        System.out.println("进来了");

    }


}
