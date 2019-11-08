package com.sg.util;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class TestAop {

    @Before("within(com.sg.controller..*)")
    public void te1(){
        System.out.println("hi....");
    }
}
