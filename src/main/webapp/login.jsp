<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>阿里妈妈商城</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.1.11.1.js"></script>
<script language="javascript" type="text/javascript">
	function register(){
		location.href="../register.jsp";
	}
	$(function(){
		$("#toLogin").click(function () {
			$.ajax({
				url:"/login/login.do",
				data:$("#form1").serialize(),
				dataType:'json',
				type:"post",
				// contentType:'application/x-www-form-urlencoded',
				success:function (data) {
					console.log(JSON.stringify(data))
					if(data.msg=="success"){
						window.location.href="shopping1.jsp"
					}else{
						$("#msg").html("用户名或密码错误");
					}
				}
			})
		})
	})
</script>

</head>
<body >
<form action="" method="post" id="form1">
	<section class="container">
	<div id="login" >
		<table>
			<tr><td colspan="2">
				<img src="${pageContext.request.contextPath}/img/login.png" style="width:400px;height:150px">
			</td></tr>
		</table><br/><br/>
		<table style="width:400px;">
			<tr>
				<td width="40px">
				<td><label>用户名：</label></td>
				<td>
					<input type="text" style="" id="userName" name="userName"/>
					<label style="color:red">*</label>
					<span style="color:red" id="msg">${msg}</span>
				</td>
			</tr>
			<tr><td width="40px">
				<td><label>密码：</label></td>
				<td>
					<input type="password" name="password"/>
					<label style="color:red">*</label>
				</td>
			</tr>	
		</table><br/>
		<table>
			<tr><td width="40px">
				<td >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td ><input type="button" style="width:80px" value="登录" id="toLogin"/></td>
				<td >&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td ><input type="button" style="width:80px" value="注册" onclick="register()"/></td>
			</tr>	
		</table>
	</div>
	</section>
</form>
</body>
</html>