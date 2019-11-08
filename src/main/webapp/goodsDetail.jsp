
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.1.11.1.js"></script>

</head>
<body>
<form action="" method="post">
    <section class="container">
        <TABLE id="tb1">

        </TABLE>
    </section>
</form>
<script>
    $(function () {
        var a = window.location.search;
        var goodsId = a.split("=")[1]
        // alert(goodsId)
        getGoodsDetailsById(goodsId);

        function getGoodsDetailsById(goodsId) {
            $.post('/goods/getGoodsDetailsById.do',{goodsId:goodsId},function (data) {
                console.log(JSON.stringify(data))
                var tr = '<TR>' +
                    '                <TD><img src="'+data.object.imgUrl+'"></TD>' +
                    '                <TD>产品名称：</TD>' +
                    '                <TD>'+data.object.goodsName+'</TD>' +
                    '            </TR>' +
                    '            <TR>' +
                    '                <TD>定价：'+data.object.unitPrice+'元</TD>' +
                    '                <TD>产品规格：</TD>\n' +
                    '                <TD>'+data.object.spec+'</TD>' +
                    '            </TR>' +
                    '            <TR>' +
                    '                <TD><input type="hidden" id="goodsId" name="goodsId" value="'+data.object.goodsId+'"/></TD>' +
                    '                <TD>产品说明：</TD>' +
                    '                <TD>'+data.object.introduce+'</TD>' +
                    '            </TR>' +
                    '            <TR>' +
                    '                <TD colspan="3" align="center"><input type="button" id="add" value="加入购物车"/></TD>' +
                    '            </TR>'
                $('#tb1').append(tr)
            })
        }

        //动态处理 添加到购物车
        $('body').on('click','#add',function () {
            $.post('/cart/addGoodsToCart.do',{goodsId:goodsId},function (data) {
                console.log(JSON.stringify(data))
                window.location.href='cartList.jsp'
            })
        })
    })
</script>
</body>
</html>
