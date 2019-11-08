<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.5.js"></script>
<script language="javascript" type="text/javascript">
	function goTo(url){
		//各输入项的判断
		document.forms[0].action="<%=request.getContextPath()%>/"+url;
		document.forms[0].submit();   
		return true;
	}
	
</script>
</head>
<body>
<form action="" method="post">
	<table>
		<tr>
			<td width="10%" align="center"><img src="<%=request.getContextPath()%>/img/icon_user.gif"></td>
	    	<td valign="middle" align="left" style="font-size:101%;font-family:Tahoma;">	<label class="user">${user.petName}</label><label>,欢迎您!</label></td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td><a href="<%=request.getContextPath()%>/goods/list.do" target="main">我要购物</a></td>
			<td><a href="<%=request.getContextPath()%>/cart/cartList.do" target="main">购物车</a></td>
			<td><a href="<%=request.getContextPath()%>/order/listByUserId.do" target="main">已完成订单</a></td>
			<td><a href="<%=request.getContextPath()%>/order/mySoldOrders.do" target="main">我的店(订单管理)</a></td>
			<td><a href="<%=request.getContextPath()%>/goods/mySoldGoods.do" target="main">我的店(库存管理)</a></td>
		</tr>		
	</table>	
</form>
</body>
</html>