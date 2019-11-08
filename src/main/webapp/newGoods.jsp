<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/11/1
  Time: 16:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.1.11.1.js"></script>
</head>
<body>
<script>
    $(function () {
        //查询商品类型数据
        findGoodsType()
        var search = window.location.search;



        if (search != ''){
            var goodsId = search.split("=")[1];
        //    id不是空 说明是修改 去后台取数据 并 回显到列表上面
            console.log(goodsId)
            $.post(
                'goods/getGoodsById.do',
                {goodsId:goodsId},
                function (data) {
                    console.log(JSON.stringify(data))
                    $('input[name=goodsName]').val(data.object.goodsName)//商品名称
                    $('#imgShow').attr('src',data.object.imgUrl)//给图片显示
                    $('input[name=imgUrl]').val(data.object.imgUrl)//商品图片
                    $('#gtId').val(data.object.gtId)//商品类别
                    $('input[name=unitPrice]').val(data.object.unitPrice)//商品单价
                    $('input[name=spec]').val(data.object.spec)//商品规格
                    $('input[name=introduce]').val(data.object.introduce)//商品介绍
                    $('input[name=stock]').val(data.object.stock)//商品库存
                    $('input[name=vaildDate]').val(data.object.vaildDate.split(" ")[0])//商品日期
                    $('input[name=goodsId]').val(data.object.goodsId)//商品id
                    $('#add').val('修改')

                }
            )

        }
        //判断我们是要新增商品还是修改商品

        //点击add增加商品
        $("#add").click(function(){
            var formData=new FormData($('#form1')[0])//把整个表单都提上去了
            var url = '';
            if (search != ''){
            //    走修改的通道
                url="/goods/editGoods.do"
            }else{
            //    走增加的通道
                url="/goods/addGoods.do"
            }
            $.ajax({
                url:url,
                cache:false,
                data:formData,
                type:'post',
                processData:false,//告诉jq不用处理发送的数据
                contentType:false,
                success:function (data) {
                    console.log(data)
                 window.location.href='goodsList.jsp'
                }

            })
        })


        //图片回显
        $("#file").change(function(){
            var objUrl = getObjectURL(this.files[0]) ;//图片路径
            var file = $("#file").val();
            console.log("objUrl:"+objUrl+"file:"+file)
            var fileName = file.substr(file.lastIndexOf("\\")+1)
            if (objUrl) {
                //元素.attr("src",属性值)
                //prop
                $("#imgShow").attr("src", objUrl) ;//图片路径
                $("#imgUrl").attr("value", 'img/'+fileName) ;
                console.log(fileName)
            }
        }) ;

        //建立一個可存取到该file的url
        function getObjectURL(file) {
            var url = null ;
            if (window.createObjectURL!=undefined) { // basic
                url = window.createObjectURL(file) ;
            } else if (window.URL!=undefined) { // mozilla(firefox)
                url = window.URL.createObjectURL(file) ;
            } else if (window.webkitURL!=undefined) { // webkit or chrome
                url = window.webkitURL.createObjectURL(file) ;
            }
            return url ;
        }



        //ajax查询商品类型
        function findGoodsType(){
            $.post('/goods/findGoodsType.do',
                function (data) {
                    console.log(JSON.stringify(data))
                    $.each(data.object,function (i,goodsType) {
                        var option = '<option value="'+goodsType.typeId+'">--'+goodsType.typeName+'--</option>'
                        $("#gtId").append(option)
                    })
                })
        }
    })
</script>
<form id="form1" method="post" >
    <input type="hidden" name="goodsId"/>
    <TABLE>
        <TR>
            <TD>选择产品图片：</TD>
            <TD>
                <input type="file" id="file" name="file"/>
             <%--   <input  type="button" id="upload" value="上传"/>--%>
                <img id="imgShow"><input type="hidden" id='imgUrl' name="imgUrl" />
            </TD>
        </TR>

        <TR><TD>产品名称：</TD><TD><input type="text" id="goodsName" name="goodsName"/></TD></TR>
        <TR>
            <TD>产品类别：</TD><TD>
            <select id="gtId" name="gtId">
            </select>
        </TD>
        </TR>
        <TR><TD>单价：</TD><TD><input type="text" name="unitPrice"/>元</TD></TR>
        <TR><TD>产品规格：</TD><TD><input type="text" name="spec"/></TD></TR>
        <TR><TD>产品说明：</TD><TD><input type="text" name="introduce"/></TD></TR>
        <TR><TD>库存：</TD><TD><input type="text" name="stock"/></TD></TR>
        <TR><TD>有效期：</TD><TD><input type="date" id="vaildDate" name="vaildDate"/></TD></TR>
    </TABLE>&nbsp;
    <input type="button" value="增加" id="add" />
</form>
</body>
</html>
