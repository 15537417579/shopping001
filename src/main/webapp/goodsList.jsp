<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/10/31
  Time: 22:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.1.11.1.js"></script>
    <script type="text/javascript" src="js/jquery.pagination.js"></script>
    <link rel="stylesheet" href="css/pagination.css" />
</head>
<body>
<script>
    $(function () {
        /*进入页面就用ajax去后台查询数据*/
        getGoods(1)

        function getGoods(currentPage) {
        $.post(
            "/goods/getGoodsList.do",{currentPage:currentPage},
            function (data) {
                console.log(data)
                $("#tb1").empty() //清空上一次的数据
                $.each(data.object.list,function (index,goods) {
                    var tr='<tr>\n' +
                        '            <td><img src="'+goods.imgUrl+'" width="128px"/></td>\n' +
                        '            <td>'+goods.goodsName+'</td>\n' +
                        '            <td>'+goods.unitPrice+'</td>\n' +
                        '            <td>'+goods.stock+'</td>\n' +
                        '            <td align="center">\n' +
                        '                <input type="button" style="width:40px" value="修改" id="update'+goods.goodsId+'"/>\n' +
                        '                <input type="button" style="width:40px" value="删除" id="del'+goods.goodsId+'"/>\n' +
                        '            </td>\n' +
                        '        </tr>'
                        $("#tb1").append(tr)

                })
                //处理分页
                $('#pagination').pagination({
                    //totalPage:data.lastPage,//总页码，貌似不同版本的实现不同
                    pageCount:data.object.lastPage,
                    current:data.object.pageNum,//当前页码
                    jump:true,
                    coping:true,//是否开启首页和末页
                    homePage:'首页',
                    endPage:'末页',
                    prevContent:'上页',
                    nextContent:'下页',
                    //callback:pageCallback(data.pageNum)
                    callback:function (api) {
                        pageCallback(api.getCurrent());
                    }
                });
            }
        )
    }
        //分页
        function pageCallback(currentPage) {
            getGoods(currentPage);
        }


        $('body').on('click','input[id^=update]',function () {
            var goodsId =  $(this).attr('id').substr(6)  //取出id值
            window.location.href='newGoods.jsp?goodsId='+goodsId  //跳转到newGoods.jsp
        })

        $('body').on('click','input[id^=del]',function () {
            var goodsId =  $(this).attr('id').substr(3)  //取出id值
            if(confirm("是否确定删除")){
                $.post(
                    "/goods/delGoods.do",{goodsId:goodsId},function (data) {
                        alert("删除成功")
                        getGoods(1)
                    }
                )
            }

        })

    })
</script>
<form id="form1" action="" method="post">
    <input type="button" value="修改商品" id="update1"/>
    <input type="button" value="新增商品" id="new"/>
    <table id="tb1" border="1" style="width:100%">
        <tr>
            <td>商品</td>
            <td>名称</td>
            <td>单价</td>
            <td>库存</td>
            <td>操作</td>
        </tr>

       <%-- <tr>
            <td><img src="img/53c417e88ab3c.png"/></td>
            <td>暖壶</td>
            <td>3</td>
            <td>20</td>
            <td align="center">
                <input type="button" style="width:40px" value="修改" id="update"/>
                <input type="button" style="width:40px" value="删除" id="del"/>
            </td>
        </tr>--%>
    </table>
    <div id="pagination"></div>
</form>
</body>
</html>
