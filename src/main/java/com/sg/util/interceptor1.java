package com.sg.util;

import com.sg.entity.UserInfo;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 自定义的拦截器，需要实现HandlerInterceptor接口
 */
public class interceptor1 implements HandlerInterceptor {

    /**
     * 是在进入目标controller之前执行
     * @param
     * @param
     * @param o
     * @return
     * @throws Exception
     */
    public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object o) throws Exception {
        System.out.println("进入拦截器……");
        UserInfo userInfo = (UserInfo) req.getSession().getAttribute("user");
        if (userInfo == null){
//            req.setAttribute("msg","请先登录");
//            req.getRequestDispatcher("/login.jsp").forward(req,resp);
//            if("XMLHttpRequest".equals(req.getHeader("X-Requested-With"))){//如果你是用ajax进的拦截器
//                System.out.println("ajax.....");
//                resp.setHeader("REDIRECT","REDIRECT");
//                resp.setHeader("CONTENTPATH","/login.jsp");
//                resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
//            }else{//你cart/haha.do进的
//                resp.sendRedirect("/login.jsp");
//            }
            String XRequested =req.getHeader("X-Requested-With");
            if("XMLHttpRequest".equals(XRequested)){
                //如果是ajax进来的，我在响应体中加一段字符串，在ajax中判断响应体里是否存在该字符串，我们在jquery源码中进行全局配置
                resp.getWriter().write("IsAjax");
            }else{
                resp.sendRedirect("login.jsp");
            }

            return false;
        }else{
            return true;
        }
        //httpServletRequest.setAttribute("msg","今天就是不放行");
        //httpServletRequest.getRequestDispatcher("/WEB-INF/error.jsp").forward(httpServletRequest,httpServletResponse);
       //return false就是不放行
    }

    /**
     * 这个也是业务，这个是在目标controller执行之后
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @param modelAndView
     * @throws Exception
     */
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        System.out.println("postHandle...后台业务已经执行完了。");

    }

    /**
     * 它是在视图层的后面
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @param e
     * @throws Exception
     */
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
        System.out.println("afterCompletion..最后");
    }
}
