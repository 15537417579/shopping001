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
						$.each(data.object,function (i,cartVO) {
							//trOfSaler = ''
							trOfSaler = '<tr>\n' +
									'\t\t\t\t\t\t<td colspan="6">\n' +
									'\t\t\t\t\t\t\t<fieldset>\n' +
									'\t\t\t\t\t\t\t<legend>'+cartVO.petName+'</legend>\n' +
									'\t\t\t\t\t\t\t<table style="width:100%">\n' +
									'\t\t\t\t\t\t\t\t<tr>\n' +
									'\t\t\t\t\t\t\t\t\t<td>产品</td>\n' +
									'\t\t\t\t\t\t\t\t\t<td>名称</td>\n' +
									'\t\t\t\t\t\t\t\t\t<td>单价（元）</td>\n' +
									'\t\t\t\t\t\t\t\t\t<td>数量</td>\n' +
									'\t\t\t\t\t\t\t\t\t<td>金额（元）</td>\n' +
									'\t\t\t\t\t\t\t\t\t<td>操作</td>\n' +
									'\t\t\t\t\t\t\t\t</tr>\n' ;
							$.each(cartVO.list,function (j,goodsVO) {
								trOfSaler +=
										'\t\t\t\t\t\t\t\t\t<tr>\n' +
										'\t\t\t\t\t\t\t\t\t\t<td><img src="'+goodsVO.imgUrl+'"/></td>\n' +
										'\t\t\t\t\t\t\t\t\t\t<td>'+goodsVO.goodsName+'</td>\n' +
										'\t\t\t\t\t\t\t\t\t\t<td><span id="unitPrice'+goodsVO.cartId+'">'+goodsVO.unitPrice+'</span></td>\n' +
										'\t\t\t\t\t\t\t\t\t\t<td>\n' +
										'\t\t\t\t\t\t\t\t\t\t\t<img id="minus'+goodsVO.cartId+'" src="img/02.gif" onmousedown="this.src=\'img/01.gif\'" onmouseup="this.src=\'img/02.gif\'">\n' +
										'\t\t\t\t\t\t\t\t\t\t\t<input type="text" id="amount'+goodsVO.cartId+'" name="amount" style="width:30px;" value="'+goodsVO.amount+'"/>\n' +
										'\t\t\t\t\t\t\t\t\t\t\t<img id="plus'+goodsVO.cartId+'" src="img/03.gif" onmousedown="this.src=\'img/04.gif\'" onmouseup="this.src=\'img/03.gif\'">\n' +
										'\t\t\t\t\t\t\t\t\t\t</td>\n' +
										'\t\t\t\t\t\t\t\t\t\t<td><span id="price'+goodsVO.cartId+'">'+goodsVO.unitPrice*goodsVO.amount+'</span></td>\n' +
										'\t\t\t\t\t\t\t\t\t\t<td>' +
										'<input type="hidden" value="'+goodsVO.stock+'" id="stock'+goodsVO.cartId+'">' +
										'<input type="checkbox" value="'+goodsVO.cartId+'" name="batch">' +
										'<input type="button" id="del'+goodsVO.cartId+'" value="删除"/></td>\n' +
										'\t\t\t\t\t\t\t\t\t</tr>\n' ;
							})
							trOfSaler +=
									'\t\t\t\t\t\t\t</table>\n' +
									'\t\t\t\t\t\t\t</fieldset>\n' +
									'\t\t\t\t\t\t</td>\t\n' +
									'\t\t\t\t\t</tr>\n' ;
							//'\t\t\t\t<tr>';
							tb1 += trOfSaler;
							//$('#tb1').append(trOfSaler);
						})
						var totalTr='<tr>\n' +
								'\t\t\t\t\t<td colspan="4" align="right">总额：</td>\n' +
								'\t\t\t\t\t<td colspan="2" id="totalPrice"></td>\n' +
								'\t\t\t\t</tr>';
						tb1 += totalTr
						tb1 += '</table>'
						$('#form1').append(tb1)
						var submitButton = '<input type="button" id="submitOrder" value="提交订单"/>';
						submitButton += '<input type="checkbox" id="checkAll">全选</input>'
						submitButton += '<input type="button" value="批量删除" id="batchDel"/>'
						$('#form1').append(submitButton)
						getTotalPrice();
					}
					var buy = '<input type="button" value="继续购买" onclick="window.location.href=\'shopping.jsp\'"/>';
					$('#form1').append(buy)
				}
			})
		}

		//动态处理 订单提交
		$('body').on('click','#submitOrder',function () {
			var cartIds = getBatch();//准备好待提交购物车的ids
			if(cartIds.length!=0){
				$.ajax({
					url:'orders/submitOrders.do',
					data:JSON.stringify(cartIds),
					dataType:'json',
					type:'post',
					contentType:'application/json',
					success:function (data) {
						console.log(JSON.stringify(data))
						var orderIds = data.object;
						//去下一个页面
						window.location.href="orderSubmit.jsp?orderIds="+orderIds;
					}
				})
			}else{
				alert("请选择要提交的商品");
			}

		})

		//动态处理 全选
		$('body').on('change','#checkAll',function () {
			//如果这个checkbox是选中的，那上面的批量checkbox都选中，否则全不选
			if($(this).is(":checked")){
				$('input[name=batch]').each(function () {
					$(this).prop('checked',true)
				})
			}else{
				$('input[name=batch]').each(function () {
					$(this).prop('checked',false)
				})
			}
		})

		//动态处理 批量删除
		$('body').on('click','#batchDel',function (){
			console.log("aaa")
			var cardIds = getBatch()
			console.log(cardIds)
			if(cardIds.length!=0){
				//后台用数组接
				/*$.ajax({
					url:'/cart/delBatch.do',
					type:'post',
					dataType:'json',
					data:{cardIds:cardIds},
					traditional:true,
					success:function (data) {
						console.log(JSON.stringify(data))
						getCartList();
					}
				})*/
				//后台用requestBody接
				$.ajax({
					url:'/cart/delBatchByRequestBody.do',
					type:'post',
					dataType:'json',
					data:JSON.stringify(cardIds),
					contentType:'application/json',
					success:function (data) {
						console.log(JSON.stringify(data))
						getCartList();
					}
				})
			}else{
				alert("请选择要删除的商品")
			}

		})

		function getBatch(){
			var cardIds = []
			$('input[name=batch]').each(function () {
				console.log($(this).val())
				if($(this).is(':checked')){
					cardIds.push($(this).val());
				}
			})
			return cardIds;
		}
		//动态处理 减少商品数量
		$('body').on('click','img[id^=minus]',function () {
			//先把原有的数量拿到
			var oldAmount = $(this).next().val();
			console.log(oldAmount)
			if(oldAmount>1){
				//当前对象的同级下一个元素
				$(this).next().val(oldAmount*1-1);
				var newAmount =$(this).next().val();
				//处理小计的金额unitPrice*amount
				//var unitPrice = $(this).parent().parent().find('span[id^=unitPrice]').html()
				//$(this)是指当前的对象，attr('id')得到的是当前这个“减”图片的id值“minus120”,substr后，就把120拿到了
				var cartId = $(this).attr('id').substr(5);//获取购物车ID
				//span不用value，用html()
				var unitPrice = $("span[id=unitPrice"+cartId+"]").html();//获取商品单价
				var price = unitPrice*(newAmount);//获取小计的金额
				//改小计
				$("span[id=price"+cartId+"]").text(price);
				//改总金额
				getTotalPrice();
				//去后台
				$.post('/cart/updateCart.do',{cartId:cartId,amount:newAmount},function (data) {
					console.log(data)
					//getCartList();
				});
			}
		})

		//动态处理 增加商品数量
		$('body').on('click','img[id^=plus]',function () {
			//先把原有的数量拿到
			var oldAmount = $(this).prev().val();
			console.log(oldAmount)
			var cartId = $(this).attr('id').substr(4);//获取购物车ID
			var stock = $("input[id=stock"+cartId+"]").val()*1;//获取库存
			console.log("stock:"+stock)
			if(oldAmount<stock){
				//当前对象的同级下一个元素
				$(this).prev().val(oldAmount*1+1);
				var newAmount =$(this).prev().val();
				//处理小计的金额unitPrice*amount
				//var unitPrice = $(this).parent().parent().find('span[id^=unitPrice]').html()
				//$(this)是指当前的对象，attr('id')得到的是当前这个“减”图片的id值“minus120”,substr后，就把120拿到了
				//span不用value，用html()
				var unitPrice = $("span[id=unitPrice"+cartId+"]").html();//获取商品单价
				var price = unitPrice*(newAmount);//获取小计的金额
				//改小计
				$("span[id=price"+cartId+"]").text(price);
				//改总金额
				getTotalPrice();
				//去后台
				$.post('/cart/updateCart.do',{cartId:cartId,amount:newAmount},function (data) {
					console.log(data)
					//getCartList();
				});
			}
		})

		//动态处理 删除
		$('body').on('click','input[id^=del]',function () {
			var cartId = $(this).attr("id").substr(3);//先从按钮的id中把cartId取出来
			var a = $(this);//为了防止ajax把$(this)给变了
			$.post('/cart/delGoodsInCart.do',{cartId:cartId},function (data) {
				console.log(data)
				getCartList();
				/*var table = $(a).parent().parent().parent().parent().parent()
                console.log($(table).html())
                $(a).parent().parent().remove();
                console.log("length:"+$(table).find("tr").length)
                if($(table).find("tr").length==1){
                    console.log(":进来了")
                    $(table)[0].remove();
                }*/

			})
		})

		//处理总金额
		function getTotalPrice() {
			var sum = 0;
			$.each($('#tb1 table'),function (i,table) {
				console.log("ffff:"+i)
				$(table).find("tr").each(function (j,tr) {
					if(j>=1){
						$(tr).find("span[id^=price]").html();
						//console.log("hhhhh:"+$(tr).find("span[id^=price]").html())
						sum += $(tr).find("span[id^=price]").html()*1;
					}
				})
			})
			console.log("sum"+sum);
			$('#totalPrice').html(sum);
		}

	})
</script>
</body>
</html>