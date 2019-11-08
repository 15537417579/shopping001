<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" type="text/css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.1.11.1.js"></script>
<title>Insert title here</title>
</head>

<body>
<form action="" method="post" id="form1">
			<%--<table id="tb1" border="1" style="width:100%">--%>


				<%--<tr>
					<td colspan="4" align="right">总额：</td>
					<td colspan="2"></td>
				</tr>
			</table>--%>
			
			<%--<input type="button" value="提交订单" onclick="submitOrder()"/>--%>

	<%--<input type="button" value="继续购买" onclick="window.location.href='shopping1.jsp'"/>--%>
</form>
<script>
	$(function () {
		getCartList();

		//去后台获取列表
		function getCartList() {
		    $("#tb1").empty() //清空上一次表的数据
			$.post('/cart/getCartList.do',function (data) {
				console.log(JSON.stringify(data))

				if(data.object.length==0){
					$("#form1").append('<p style="color:red">您的购物车还没有商品</p>')
				}else {
                    var trOfSaler = ''
				    var tb = '<table id="tb1" border="1" style="width:100%">'  //表头
					$.each(data.object,function (i,CartVo) {    //大表循环
						trOfSaler = '<tr>\n' +                 //表头基本数据
								'\t\t\t\t\t\t<td colspan="6">\n' +
								'\t\t\t\t\t\t\t<fieldset>\n' +
								'\t\t\t\t\t\t\t<legend>'+CartVo.petName+'</legend>\n' +
								'\t\t\t\t\t\t\t<table style="width:100%">\n' +
								'\t\t\t\t\t\t\t\t<tr>\n' +
								'\t\t\t\t\t\t\t\t\t<td>产品</td>\n' +
								'\t\t\t\t\t\t\t\t\t<td>名称</td>\n' +
								'\t\t\t\t\t\t\t\t\t<td>单价（元）</td>\n' +
								'\t\t\t\t\t\t\t\t\t<td>数量</td>\n' +
								'\t\t\t\t\t\t\t\t\t<td>金额（元）</td>\n' +
								'\t\t\t\t\t\t\t\t\t<td>操作</td>\n' +
								'\t\t\t\t\t\t\t\t</tr>\n';

						$.each(CartVo.list,function (j,goodsVo) { //小表循环
							trOfSaler +=
									'\t\t\t\t\t\t\t\t<tr>\n' +
									'\t\t\t\t\t\t\t\t\t<td><img src="'+goodsVo.imgUrl+'"/></td>\n' +
									'\t\t\t\t\t\t\t\t\t<td>'+goodsVo.goodsName+'</td>\n' +
									'\t\t\t\t\t\t\t\t\t<td><span id="unitPrice'+goodsVo.cartId+'">'+goodsVo.unitPrice+'</span></td>\n' +
									'\t\t\t\t\t\t\t\t\t<td>\n' +
									'\t\t\t\t\t\t\t\t\t\t<img id="minus'+goodsVo.cartId+'" src="img/02.gif"  onmousedown="this.src=\'img/01.gif\'" onmouseup="this.src=\'img/02.gif\'">\n' +
									'\t\t\t\t\t\t\t\t\t\t<input type="text" id="amount'+goodsVo.cartId+'" name="amount" style="width:30px;" value="'+goodsVo.amount+'" onblur="checkCount(this,${goodsMap.stock},${goodsMap.cart_id})"/>\n' +
									'\t\t\t\t\t\t\t\t\t\t<img id="append'+goodsVo.cartId+'" src="img/03.gif"  onmousedown="this.src=\'img/04.gif\'" onmouseup="this.src=\'img/03.gif\'">\n' +
									'\t\t\t\t\t\t\t\t\t<td><input type="hidden" id="stock'+goodsVo.cartId+'" value="'+goodsVo.stock+'"" /></td>\n' +
									'\t\t\t\t\t\t\t\t\t</td>\n' +
									'\t\t\t\t\t\t\t\t\t<td><span id="price'+goodsVo.cartId+'">'+goodsVo.unitPrice*goodsVo.amount+'</td>\n' +
									'\t\t\t\t\t\t\t\t\t<td><input type="checkbox" value="'+goodsVo.cartId+'" name="batchDel"/></td>\n' +
									'\t\t\t\t\t\t\t\t\t<td><input type="button" value="删除" id="del'+goodsVo.cartId+'"/></td>\n' +
									'\t\t\t\t\t\t\t\t</tr>\n';
						})
						trOfSaler +=
								'\t\t\t\t\t\t\t</table>\n' +
								'\t\t\t\t\t\t\t</fieldset>\n' +
								'\t\t\t\t\t\t</td>\t\n' +
								'\t\t\t\t\t</tr>'
                         tb += trOfSaler
					})

					var totalTr = '<tr>\n' +
							'\t\t\t\t\t<td colspan="4" align="right">总额：</td>\n' +
							'\t\t\t\t\t<td colspan="2" id="totalPrice"></td>\n' +
							'\t\t\t\t</tr>'

                    tb +=totalTr+'</table>'


                    $('#form1').append(tb)  //此时将所有的表数据1再追加到表单中
                    var submitButton = '<input type="button" value="提交订单"  id="submitOrders"/>';
                    submitButton += '<input type="checkbox" id="checkAll">全选</input>'
                    submitButton += '<input type="button" value="批量删除" id="batch"/>'
                    $('#form1').append(submitButton)
					getTotalPrice()
				}
                var buy = '<input type="button" value="继续购买" onclick="window.location.href=\'shopping1.jsp\'"/>';
                $('#form1').append(buy)
			})
	}
        //----------------------------------------------------
		//动态处理 提交
		$('body').on('click','#submitOrders',function () {

			var cardIds = getCards(); //调用获得ids的方法
			console.log(cardIds)
			if (cardIds.length != 0){
				$.ajax({
					url:'/orders/submitOrders.do',
					data:JSON.stringify(cardIds),
					dataType:'json',
					type:'post',
					contentType:'application/json',
					success:function(data) {
						console.log(JSON.stringify(data))
					}
				})
			}else{

				alert("您还没有选择 无法提交订单")
			}

		})


        //动态处理 全选
        $('body').on('change','#checkAll',function () {
                if ($(this).is(':checked')){
                    $('input[name=batchDel]').each(function () { //获取每个小的按钮的值 并更改其状态
                        $(this).prop('checked',true)
                    })
                }else{
                    $('input[name=batchDel]').each(function () {
                        $(this).prop('checked',false)
                    })
                }
        })

        //动态处理批量删除
        $('body').on('click','#batch',function () {
          if(confirm("是否确认要删除已经选中的商品")) {
              var cardIds = getCards(); //调用获得ids的方法
              if (cardIds != 0) {
                  /*$.ajax({
                      url:'/cart/delBatch.do',
                      type:'post',
                      dataType:'json',
                      data:{cardIds:cardIds},
                      traditional:true,
                      success:function (data) {
                          console.log(JSON.stringify(data))
                          getCartList()
                      }
                  })*/
                  $.ajax({
                      url: '/cart/delBatchByRequestBody.do',
                      type: 'post',
                      dataType: 'json',
                      data: JSON.stringify(cardIds),
                      contentType: 'application/json',
                      success: function (data) {
                          console.log(JSON.stringify(data))
                          getCartList()
                      }
                  })
              }
          }
        })
        //将获取的订单ids的方法获取到 并提取出来
        function getCards(){
            var cardIds = []

                $('input[name=batchDel]').each(function () {
                    console.log($(this).val())
                    if ($(this).is(':checked')){
                        cardIds.push($(this).val())
                    }
                })


            return cardIds;
        }

        //动态处理 减少商品数量
        $('body').on('click','img[id^=minus]',function () {
            //	分析思路：先获取原来的数量 然后将其数量减一
            var oldAmount = $(this).next().val();
            // alert(oldAmount)
            if (oldAmount>1){

                $(this).next().val(oldAmount*1-1)
                var newAmount =$(this).next().val()
                //	处理小计的金额  goodsVo.unitPrice*goodsVo.amount+
                var cartId = $(this).attr('id').substr(5);//获取购物车ID
                //获取单价
                var unitPrice = $("span[id=unitPrice"+cartId+"]").html();
                var price = unitPrice*newAmount;  //此时将单价和新的数量相乘 = 新的小计
                $("span[id=price"+cartId+"]").html(price)
                getTotalPrice() //当小计发生变化的时候 就调用总价
                $.post('/cart/UpdateCartList.do',{cartId:cartId,amount:newAmount},function (data) {
                    console.log(data)
                })
            }
        })
        /*//动态处理，手动输入商品数量
        $('body').on('blur','input[id^=amount]',function () {
            var newAmount = $(this).val();
            // alert(oldAmount) id="amount'+goodsVo.cartId+'"
            var cartId =$(this).attr('id').substr(6)//获取购物车id
            if (0<newAmount<=1000){
            //	获取单价
                var unitPrice = $("span[id^=amount"+cartId+"]").html()
                var price = newAmount*unitPrice
                $("span[id=price"+cartId+"]").html(price)
                getTotalPrice() //当小计发生变化的时候 就调用总价
            }
        })*/


        //动态处理，增加商品数量
        $('body').on('click','img[id^=append]',function () {
            //	分析思路：先获取原来的数量 然后将其数量减一
            var oldAmount = $(this).prev().val();
            var cartId = $(this).attr('id').substr(6);//获取购物车ID
			var stock = $("input[id=stock"+cartId+"]").val()*1 //获取库存

            // alert(oldAmount)
            if (oldAmount<stock){  //此时是老的数量  所以只能小于 不能等于 下面新数量加一

                $(this).prev().val(oldAmount*1+1)
                var newAmount =$(this).prev().val()
                //	处理小计的金额  goodsVo.unitPrice*goodsVo.amount+

                //获取单价
                var unitPrice = $("span[id=unitPrice"+cartId+"]").html();
                var price = unitPrice*newAmount;  //此时将单价和新的数量相乘 = 新的小计
                $("span[id=price"+cartId+"]").html(price)
                getTotalPrice() //当小计发生变化的时候 就调用总价

                $.post('/cart/UpdateCartList.do',{cartId:cartId,amount:newAmount},function (data) {
                    console.log(data)
                })
            }

        })


        //动态处理 删除
        $('body').on('click','input[id^=del]',function () {
               var cardId = $(this).attr("id").substr(3);
               // alert(cardId)
                $.post('/cart/delGoodsInCart.do',{cardId:cardId},function (data) {
                    console.log(data)
                    getCartList()
                })
        })


        //	处理总金额
        function getTotalPrice() {
            var sum = 0;
            $.each($('#tb1 table'),function (i,table) {
                // alert(i)
                $(table).find('tr').each(function (j,tr) {
                    if (j>=1){
                        var everyPrice = $(tr).find('span[id^=price]').html()
                        sum += everyPrice*1;
                    }
                })
            })
            console.log("sum"+sum);
            $('#totalPrice').html(sum)
        }
	})
</script>
</body>
</html>