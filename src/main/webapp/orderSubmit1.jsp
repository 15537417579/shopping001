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
<form id="form1" action="" method="post">
</form>
<script>
	$(function () {
		getCartList();

		//去后台获取列表
		function getCartList() {

			var search = window.location.search;
			var orderIds = search.split("=")[1].split(",");

			$('#form1').empty()
			$.ajax({
				url:'/orders/getOrderList.do',
				data:JSON.stringify(orderIds),
				dataType:'json',
				type:'post',
				contentType:'application/json',
				success:function (data) {
					console.log(data)
					if(data.object.length==0){

					}else{
						var trOfSaler = ''
						var tb1 = '<table id="tb1" border="1" style="width:100%">';
						$.each(data.object,function (i,ordersVO) {
							var totalPrice =0;
							//trOfSaler = ''
							trOfSaler = '<tr>\n' +
									'\t\t\t\t\t\t<td colspan="6">\n' +
									'\t\t\t\t\t\t\t<fieldset>\n' +
									'\t\t\t\t\t\t\t<legend>'+ordersVO.petName+'</legend>\n' +
									'\t\t\t\t\t\t\t<table style="width:100%">\n' +
									'\t\t\t\t\t\t\t\t<tr>\n' +
									'\t\t\t\t\t\t\t\t\t<td>产品</td>\n' +
									'\t\t\t\t\t\t\t\t\t<td>名称</td>\n' +
									'\t\t\t\t\t\t\t\t\t<td>单价（元）</td>\n' +
									'\t\t\t\t\t\t\t\t\t<td>数量</td>\n' +
									'\t\t\t\t\t\t\t\t\t<td>金额（元）</td>\n' +
									'\t\t\t\t\t\t\t\t\t<td>' +
									'<input type="button" value="付款" id="pay'+ordersVO.ordersId+'">' +

									'</td>\n' +
									'\t\t\t\t\t\t\t\t</tr>\n' ;
							$.each(ordersVO.list,function (j,goodsVO) {
								totalPrice += goodsVO.unitPrice*goodsVO.amount;
								console.log("totalPrice:"+totalPrice)
								trOfSaler +=
										'\t\t\t\t\t\t\t\t\t<tr>\n' +
										'\t\t\t\t\t\t\t\t\t\t<td><img src="'+goodsVO.imgUrl+'"/></td>\n' +
										'\t\t\t\t\t\t\t\t\t\t<td>'+goodsVO.goodsName+'</td>\n' +
										'\t\t\t\t\t\t\t\t\t\t<td><span id="unitPrice'+goodsVO.cartId+'">'+goodsVO.unitPrice+'</span></td>\n' +
										'\t\t\t\t\t\t\t\t\t\t<td>\n' +
										'\t\t\t\t\t\t\t\t\t\t\t<input type="text" id="amount'+goodsVO.cartId+'" name="amount" style="width:30px;" value="'+goodsVO.amount+'"/>\n' +
										'\t\t\t\t\t\t\t\t\t\t</td>\n' +
										'\t\t\t\t\t\t\t\t\t\t<td><span id="price'+goodsVO.cartId+'">'+goodsVO.unitPrice*goodsVO.amount+'</span></td>\n' +
										'\t\t\t\t\t\t\t\t\t\t<td>' +
										'<input type="hidden" value="'+goodsVO.stock+'" id="stock'+goodsVO.cartId+'">' +
										'\t\t\t\t\t\t\t\t\t</tr>\n' ;
							})
							var totalTr='<tr>\n' +
									'\t\t\t\t\t<td colspan="4" align="right">总额：</td>\n' +
									'\t\t\t\t\t<td colspan="2" id="totalPrice">'+totalPrice+'</td>\n' +
									'<td>' +
									'    <form action="alipay.trade.page.pay.jsp" id="forms'+ordersVO.ordersId+'">' +
									'    <input type="hidden" name="WIDout_trade_no" value="'+ordersVO.ordersId+'"/>\n' +
									'    <input type="hidden" name="WIDtotal_amount" value="'+totalPrice+'"/>\n' +
									'    <input type="hidden" name="WIDsubject" value="'+ordersVO.petName+'"/>\n' +
									'    <input type="hidden" name="WIDbody" value=""/></form>' +
									'</td>'+
									'\t\t\t\t</tr>';
							trOfSaler+=totalTr
							trOfSaler +=
									'\t\t\t\t\t\t\t</table>\n' +
									'\t\t\t\t\t\t\t</fieldset>\n' +
									'\t\t\t\t\t\t</td>\t\n' +
									'\t\t\t\t\t</tr>\n' ;
							//'\t\t\t\t<tr>';
							tb1 += trOfSaler;
							//$('#tb1').append(trOfSaler);
						})

						tb1 += '</table>'
						$('#form1').append(tb1)
					}
					var buy = '<input type="button" value="继续购买" onclick="window.location.href=\'shopping.jsp\'"/>';
					$('#form1').append(buy)
				}
			})
		}

		//动态处理　付款按钮
		$('body').on('click','input[id^=pay]',function () {
			var orderId = $(this).attr('id').substr(3);
			console.log(orderId)
			//找到我们对应的form表单，让它提交
			//console.log($('form[id=forms'+orderId+']').html())
			$('form[id=forms'+orderId+']').submit();
		})

	})
</script>
</body>
</html>