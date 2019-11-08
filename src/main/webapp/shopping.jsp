<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.1.11.1.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/json2.js"></script>
<title>Insert title here</title>
<script language="javascript">

function pageControl(curPage,maxRowCount){
	  document.forms[0].action="<%=request.getContextPath()%>/goods/PageList.do?curPage="+curPage+"&maxRowCount="+maxRowCount;
	  document.forms[0].submit(); 
}
</script>
</head>

<body>
<form action="" method="post">
<%--	条件查询--%>
	<div>
		商品名称：<input name="goodsNameCon" id="goodsNameCon"/>
		价格区间：<input name="priceBeginCon" id="priceBeginCon"/>
		<input name="priceEndCon" id="priceEndCon"/>
		商品类别：
		<select id="gtIdCon">
			<option value="0">--请选择--</option>
		</select>
		<input type="button" id="selectByCon" value="查询">
	</div>

	<%--<%PageControl pagee = (PageControl)request.getAttribute("pageControl"); %>--%>
	<table id="tb1">

	</table>	<br/>
	<div align="center" id="pageBean">
		<%--<input type="button" onclick="" value="上一页"/>
		<input type="button" style="color:red" onclick="" value="1"/>
		<input type="button" onclick="" value="2"/>
		<input type="button" onclick="" value="3"/>
		<input type="button" onclick="" value="4"/>
		<input type="button" onclick="" value="下一页"/>--%>
	</div>
</form>
</body>
</html>
<script>
	$(function () {
		//查询商品列表
		findGoodsType()
		//调用ajax方法
		dealWith(1);

		//动态处理分页点击(动态生成的按钮，是不能这么写的)
		//$('#prePage').click(function(){})
		$('body').on('click','#prePage',function () {
		//	上一页
			dealWith($('#currPage').val()*1-1);
		})

		$('body').on('click',"input[id^=page]",function () {
			//	上一页
			dealWith($(this).val());
		})


		$('body').on('click','#nextPage',function () {
			//	上一页
			dealWith($('#currPage').val()*1+1);
		})




	//处理返回的数据
		function dealWith(currPage){
			//	ajax自动加载商品数据
			$.ajax({
				url:"/goods/goodsListByPage.do",
				dataType:"json",
				data:{currPage:currPage},
				success:function(data){
					//JSON.stringify()的作用是将 JavaScript 对象转换为 JSON 字符串
					console.log(JSON.stringify(data))
					$("#tb1").empty() //清空上一次的数据
					/*拼接商品循环*/
					var tr = '<tr>'
					/*循环商品
                    data.object:是我们的list,index:是数组下标（index），goods：是遍历出来的元素
                    * */
					$.each(data.object.list,function(index,goods){
						var td =
								'<td>' +
								'<div style="width:200px;height:200px;cursor:pointer">' +
								'<table>' +
								'<tr><td><img src="${pageContext.request.contextPath}/'+goods.imgUrl+'" onclick=\'\'></td></tr>' +
								'<tr><td>商品名称：'+goods.goodsName+'</td></tr>' +
								'<tr><td>定价：'+goods.unitPrice+'元</td></tr>' +
								'</table>' +
								'</div>' +
								'</td>'

						tr +=td

						if ((index+1)%5==0){ //换行
							tr+="</tr>"
							tr+="<tr>"
						}
					})

					tr +='</tr>'
					$("#tb1").append(tr)//将动态生成的数据添加到元素（table表格）中

					/*
                    处理分页
                     @type {string}
                    */
					$("#pageBean").empty()  //清空上一次的数据
					var pageBean = ''
					//判断是否需要上一页  如果 当前页数大于1 就需要出现上一页
					if(data.object.currPage > 1){
						pageBean +='<input type="button" onclick="" id="prePage"  value="上一页"/>'
					}
					//遍历处理每一页
					console.log(data.object.currPage)
					for (var i = 1; i <=data.object.totalPage;i++) {
						if (i==data.object.currPage ){
							pageBean +='<input type="button" style="color:red"  onclick=""  id="page'+i+'"  value="'+i+'"/>'

						}else{
							pageBean +='<input type="button" style="color:#0214ff" onclick="" id="page'+i+'" value="'+i+'"/>'

						}
					}
					//判断是否需要上一页  如果 当前页数小于总页数 就需要出现下一页
					if(data.object.currPage < data.object.totalPage){
						pageBean +='<input type="button" onclick=""  id="nextPage"  value="下一页"/>'
					}

					//将动态生成的数据添加到div
					$("#pageBean").append(pageBean)
					$("#pageBean").append('<input type="hidden" value="'+data.object.currPage+'" id="currPage" />')

				}
			})
		}

		function findGoodsType(){
			$.post('/goods/findGoodsType.do',
			function (data) {
				console.log(JSON.stringify(data))
				$.each(data.object,function (i,goodsType) {
					var option = '<option value="'+goodsType.typeId+'">--'+goodsType.typeName+'--</option>'
					$("#gtIdCon").append(option)
				})
			})
		}
	})
</script>