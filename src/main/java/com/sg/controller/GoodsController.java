package com.sg.controller;

import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.github.pagehelper.PageInfo;
import com.sg.entity.*;
import com.sg.service.GoodsService;
import com.sg.service.GoodsTypeService;
import com.sg.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("goods")
public class GoodsController extends BaseController {

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private GoodsTypeService goodsTypeService;


    @RequestMapping("findGoodsType")
    @ResponseBody
    public ResponseResult findGoodsType(){
        List<GoodsType> GoodsTypeList = goodsTypeService.findAllGoodsType();
        ResponseResult rr = new ResponseResult(GoodsTypeList);
        return rr;
    }
    /**
     * 商品列表
     * @param
     * @return
     */
    @RequestMapping("goodsList")
    @ResponseBody
    public ResponseResult goodsList(){
        //注册
        ResponseResult responseResult = new ResponseResult();
        List<Goods> goods = goodsService.findAllGoods();
        for (Goods good : goods) {
            System.out.println(good);
        }
        responseResult.setObject(goods);
        responseResult.setMsg("OK啦");
        return responseResult;
    }

    /**
     * 分页查询商品列表
     * @param pageBean
     * @return
     */
    @RequestMapping("goodsListByPage")
    @ResponseBody
    public ResponseResult goodsListByPage( PageBean pageBean){
        //注册
        ResponseResult responseResult = new ResponseResult();
//      查询总记录数
        Integer totalCount = goodsService.findGoodsCount();
//        初始化一个pageBean

        pageBean.setTotalCount(totalCount);//设置总记录数
//        pageBean.setCurrPage(3);//当前页数   前端传

        pageBean.getFirstPage1();  //获取当前页数第一条数据的索引
        pageBean.getTotalPage1();//获取总页数

        System.out.println(pageBean.getFirstPage());
//        通过分页查询出数据
        List<Goods> goods = goodsService.findGoodsListByPage(pageBean);

        pageBean.setList(goods); //将查询的数据封装到pageBean

        responseResult.setObject(pageBean);//将pageBean封装到responseResult
        responseResult.setMsg("OK啦");
        return responseResult;
    }


    /**
     * 分页查询带条件查询商品
     * @param pageBean  分页参数
     * @param goodsCon  条件参数
     * @return
     */
    @RequestMapping("goodsListByPageAndCon")
    @ResponseBody
    public ResponseResult goodsListByPageAndCon( PageBean pageBean,GoodsCon goodsCon){
        System.out.println(pageBean.getCurrPage()+"=======---===="+goodsCon);
        //注册
        ResponseResult responseResult = new ResponseResult();
//      条件查询总记录数
        Integer totalCount = goodsService.findGoodsCountByCon(goodsCon);
//        初始化一个pageBean

        pageBean.setTotalCount(totalCount);//设置总记录数
//        pageBean.setCurrPage(3);//当前页数   前端传

        pageBean.getFirstPage1();  //获取当前页数第一条数据的索引
        pageBean.getTotalPage1();//获取总页数

        System.out.println(pageBean.getFirstPage());
//        通过分页查询出数据
        List<Goods> goods = goodsService.findGoodsListByPageAndCon(pageBean,goodsCon);

        pageBean.setList(goods); //将查询的数据封装到pageBean

        responseResult.setObject(pageBean);//将pageBean封装到responseResult
        responseResult.setMsg("OK啦");
        return responseResult;
    }


    @RequestMapping("getGoodsDetailsById")
    @ResponseBody
    public ResponseResult  getGoodsDetailsById(Integer goodsId){
        ResponseResult responseResult = new ResponseResult();
        System.out.println(goodsId+"=-----------------------");
       Goods goods =  goodsService.findGoodsById(goodsId);
        responseResult.setObject(goods);
        System.out.println("goods0---------------------"+goods);
        return responseResult;
    }


    /**
     * 上传图片
     * @param multipartFile
     * @return
     * @throws IOException
     */
    @RequestMapping("uploadPic.do")
    @ResponseBody
    public ResponseResult uploadPic(@RequestParam("file") MultipartFile multipartFile) throws IOException {
        System.out.println("uploadPic.do……");
        String path = "e:\\file\\"+multipartFile.getOriginalFilename();
        multipartFile.transferTo(new File(path));
        return new ResponseResult();
    }


    /**
     * 提交表单 并且上传图片
     * @param multipartFile
     * @param goods
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping("addGoods")
    @ResponseBody
    public ResponseResult addGoods(@RequestParam("file") MultipartFile multipartFile,
                                   Goods goods, HttpServletRequest request) throws IOException {
//        处理文件文件上传路径  这里只能写绝对路径
//        F:\idea\shopping001\src\main\webapp\img
//        request.getServletContext().getRealPath("/") + "img\\" + multipartFile.getOriginalFilename();
        String path = System.getProperty("user.dir")+ "\\src\\main\\webapp\\img\\" + multipartFile.getOriginalFilename();
        System.out.println("path==========="+path);
        multipartFile.transferTo(new File(path));


        System.out.println("addGoods.do……"+goods);
        ResponseResult responseResult = new ResponseResult();
        responseResult.setMsg("好的啦");

        UserInfo user = (UserInfo) request.getSession().getAttribute("user");
        goods.setUserId(user.getUserId());


        goodsService.addGoods(goods);
        return responseResult;
    }


    /**
     * 提交表单 并且上传图片
     * @param multipartFile
     * @param goods
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping("editGoods")
    @ResponseBody
    public ResponseResult editGoods(@RequestParam("file") MultipartFile multipartFile,
                                   Goods goods, HttpServletRequest request) throws IOException {
//        处理文件文件上传路径  这里只能写绝对路径
//        F:\idea\shopping001\src\main\webapp\img
        String sPath = request.getServletContext().getRealPath("/") + "img\\" + multipartFile.getOriginalFilename();
        String filename = multipartFile.getOriginalFilename();
        System.out.println("filename-=-----=="+filename);
        if (!filename.equals("")){
            String path = System.getProperty("user.dir")+ "\\src\\main\\webapp\\img\\" + multipartFile.getOriginalFilename();
            System.out.println("path==========="+path);
            multipartFile.transferTo(new File(path));

        }


        System.out.println("addGoods.do……"+goods);
        ResponseResult responseResult = new ResponseResult();
        responseResult.setMsg("好的啦");

//        UserInfo user = (UserInfo) request.getSession().getAttribute("user");
//        goods.setUserId(user.getUserId());


        goodsService.editGoods(goods);
        return responseResult;
    }


    //直接查询出全部商品
   /*@RequestMapping("getGoodsList")
    @ResponseBody
    public ResponseResult getGoodsList(HttpSession session){
        System.out.println("getGoodsList========================");
        ResponseResult responseResult = new ResponseResult();
        responseResult.setMsg("好的啦");

        UserInfo user = (UserInfo) session.getAttribute("user");

        List<Goods> goodsList = goodsService.getGoodsListByUserId(user.getUserId());
        System.out.println("用户id======"+user.getUserId());
        responseResult.setObject(goodsList);
        return responseResult;
    }*/

    /**
     * 登陆用户 查专属用户的商品 并分页
     * @param session
     * @return
     */
   @RequestMapping("getGoodsList")
   @ResponseBody
   public ResponseResult getGoodsList(Integer currentPage,HttpSession session){
       System.out.println("getGoodsList========================");
       ResponseResult responseResult = new ResponseResult();
       responseResult.setMsg("好的啦");

       UserInfo user = (UserInfo) session.getAttribute("user");

       PageInfo<Goods> pageInfo =  goodsService.getGoodsListByUserIdAndPage(currentPage,user.getUserId());
       System.out.println("用户id======"+user.getUserId());
       List<Goods> list = pageInfo.getList();
       for (Goods goods : list) {
           System.out.println("商品信息："+goods);
       }

       return new  ResponseResult("ok",pageInfo);
   }

    /**
     * 去 后台取数据
     * @param goodsId
     * @return
     */
    @RequestMapping("getGoodsById")
    @ResponseBody
   public ResponseResult getGoodsById(Integer goodsId){
       Goods goods = goodsService.findGoodsById(goodsId);
        System.out.println(goodsId);
       return new ResponseResult(goods);
   }

    @RequestMapping("delGoods")
    @ResponseBody
    public ResponseResult delGoods(Integer goodsId){
        goodsService.delGoodsById(goodsId);
        return new ResponseResult("成功");
    }
}
