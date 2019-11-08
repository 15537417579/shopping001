package com.sg.entity;

import lombok.Data;


public class ResponseResult<T> {
    private String msg;
    private T object;


    public ResponseResult() {
    }

    public ResponseResult(String msg) {
        this.msg = msg;
    }


    public ResponseResult(T object) {
        this.object = object;
    }

    public ResponseResult(String msg, T object) {
        this.msg = msg;
        this.object = object;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getObject() {
        return object;
    }

    public void setObject(T object) {
        this.object = object;
    }
}
