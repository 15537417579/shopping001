package com.sg.controller;

import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.sg.entity.Goods;
import com.sg.entity.ResponseResult;
import com.sg.entity.UserInfo;
import com.sg.mapper.GoodsMapper;
import com.sg.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("login")
public class LoginController extends BaseController {

    @Autowired
    private LoginService loginService;

    /**
     * 用户注册
     * @param userInfo
     * @return
     */
    @RequestMapping("register.do")
    public String register(UserInfo userInfo){
        //注册
        System.out.println(userInfo);
        loginService.register(userInfo);

        return "login";
    }

    /**
     * ajax版用户注册
     * @param userInfo
     * @return
     */
    @RequestMapping("ajaxRegister.do")
    @ResponseBody
    public ResponseResult ajaxRegister(UserInfo userInfo){
        //注册
        System.out.println(userInfo);
        loginService.register(userInfo);
        ResponseResult responseResult = new ResponseResult();
        responseResult.setMsg("注册成功");
        return responseResult;
    }

    /**
     * 用户登录
     * @param userInfo
     * @return
     */
    @RequestMapping("login.do")
    @ResponseBody
    public ResponseResult login(UserInfo userInfo, HttpSession session){
        //注册

        System.out.println(userInfo);
        UserInfo user= loginService.login(userInfo);
        ResponseResult responseResult = new ResponseResult();
        if(user==null){
            responseResult.setMsg("error");
        }else{
            responseResult.setMsg("success");
//           将用户登录数据  存入 session
            session.setAttribute("user",user);

        }
        return responseResult;
    }

    /**
     * 检查用户名是否重复
     * @param userName
     * @return
     */
    @RequestMapping("checkUserName.do")
    @ResponseBody
    public ResponseResult checkUserName(String userName){
        //检查
        System.out.println(userName);
        UserInfo user = loginService.checkUserName(userName);
        System.out.println(user);
        ResponseResult result = new ResponseResult();
        if(user == null){
            result.setMsg("valid");
        }else{
            result.setMsg("invalid");
            result.setObject(user);
        }

        return result;
    }

//    手机发送验证码
    @RequestMapping("testMsg.do")
    @ResponseBody
    private String testMsg(HttpServletRequest req, HttpServletResponse resp) {
        resp.setCharacterEncoding("utf-8");
        String phone = req.getParameter("phone");
        String value = String.valueOf((int)(Math.random()*10000));
        System.out.println("验证码：" + value + ",phone:" + phone);

        DefaultProfile profile = DefaultProfile.getProfile("default", "LTAI13SwrifAakze", "IHZ2LElI4vSQbjGQZGJBlIJrhG1tkO");
        IAcsClient client = new DefaultAcsClient(profile);

        CommonRequest request = new CommonRequest();
        request.setMethod(MethodType.POST);
        request.setDomain("dysmsapi.aliyuncs.com");
        request.setVersion("2017-05-25");
        request.setAction("SendSms");
        request.putQueryParameter("PhoneNumbers", phone);//前端传过来的电话号码
        // request.putQueryParameter("PhoneNumbers", "13361186514");
        request.putQueryParameter("SignName", "小程闪购商城");//申请的签名
        request.putQueryParameter("TemplateCode", "SMS_169900878");//申请的模板code
        request.putQueryParameter("TemplateParam", "{\"code\":\""+value+"\"}");//value就是验证码

        try {
            CommonResponse response = client.getCommonResponse(request);
            System.out.println(response.getData());
        } catch (ServerException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            e.printStackTrace();
        }
        return value;
    }


    @Autowired
    private GoodsMapper goodsMapper;


    @RequestMapping("TestMp")
    public void TestMp(){
        List<Goods> goods = goodsMapper.selectList(new EntityWrapper<>());
        for (Goods good : goods) {
            System.out.println(good);
        }
    }


}
