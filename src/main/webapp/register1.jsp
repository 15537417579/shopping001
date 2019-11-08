<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.validate.min.js"></script>
<%--<script type="text/javascript" src="<%=request.getContextPath()%>/js/alert.js"></script>--%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/messages_zh.min.js"></script>


<script language="javascript" type="text/javascript">
	$(function () {

	    //获取手机验证码
        $('#sendMsg').click(function () {
            $.post('/login/testMsg.do',{phone:$('#phone').val()},function (data) {
                console.log(data)
            });
        })


			//表单提交
			$("#submit").click(function () {
				//提交之前调用test()方法去较验，该方法会返回一个validate对象。用这个对象去.form()就是返回是否较验成功
				if(test().form()){//这个在调用validate对象的form()方法。如果form()方法的返回值为true..
					alert("ok");
					//提交注册，我们要把表单整体提交，要用到$('#form1').serialize()
					$.ajax({
						url:'/login/ajaxRegister.do',
						data:$('#form1').serialize(),
						dataType:'json',
                        contentType:'application/x-www-form-urlencoded',
						type:'post',
						success:function (data) {
							console.log(JSON.stringify(data))
							if(data.msg=="注册成功"){
								window.location.href="../login.jsp";
							}
						}
					})
				}else{
					alert("not ok");
				}
			});
			//该方法return，会返回一个validate对象，这个对象有一个form()方法，form()方法的返回值是是否通过验证。
			function test() {
				//$("#form1").validate方法是我们具体写校验的地方
				return $("#form1").validate({
					rules:{
						petName:{
							required:true
						},
						userName:{
							required:true
						},password:{
							required:true,
							minlength:4,
							maxlength:8
						},confirmPwd:{
							required:true,
							minlength:4,
							maxlength:8,
							equalTo:"#password"
						}
					},
					messages:{
						password:{
							required:"密码不能为空"
						}
					}
				});
			}




		//用户名是否已存在的较验
		$('#userName').blur(function () {
			$.ajax({
				url:'/login/checkUserName.do',
				data:{userName:$('#userName').val()},
				type:'post',

				success:function (data) {
					console.log(JSON.stringify(data))
					//{"msg":"valid"}
					if(data.msg == "valid"){
						$('#msg').html("用户名有效，可以使用");
					}else{
						$('#msg').html("用户名已存在，请重新尝试");
					}
				},
				error:function () {
					console.log('wrong')
				}
			})
		})
	})


</script>
</head>
<body style="background-image:url('<%=request.getContextPath()%>/img/background.jpg')">
<form id="form1" action="/login/register.do" method="post">
	<section class="container">
		<table>
			<tr>
				<td><label>昵称：</label></td>
				<td><input type="text" id="petName" name="petName"/>
					<label style="color:red">*</label>
				</td>
			</tr>	
			<tr>
				<td><label>用户名：</label></td>
				<td>
					<input type="text" id="userName" name="userName"/>
					<label style="color:red">*</label>
					<span id="msg"></span>
				</td>
			</tr>
			<tr>
				<td><label>密码：</label></td>
				<td>
					<input type="password" id="password" name="password"/>
					<label style="color:red">*</label>
				</td>
			</tr>
			<tr>
				<td><label>再次输入密码：</label></td>
				<td>
					<input type="password" id="confirmPwd" name="confirmPwd"/>
					<label style="color:red">*</label>
				</td>
			</tr>
			<tr>
				<td><label>性别：</label></td>
				<td>
					<input type="radio" value="0" name="sex" checked=true/><label>女</label>
					<input type="radio" value="1" name="sex"/><label>男</label>
				</td>			
			</tr>
			<tr>
				<td><label>年龄：</label></td>
				<td><input type="text" name="age"/></td>
			</tr>
			<tr>
				<td><label>身份证号：</label></td>
				<td><input type="text" name="idNum"/></td>			
			</tr>	
			<tr>
				<td><label>生日：</label></td>
				<td>
					<input type="date" name="birthday"/>
				</td>
			</tr>
			<tr>
				<td><label>地址：</label></td>
				<td><input type="text" name="address"/></td>
			</tr>
			<tr>
				<td><label>电话：</label></td>
				<td><input type="text" id="phone" name="telephone"/></td>
			</tr>
			<tr>
				<td><label>验证码：</label></td>
				<td><input type="text" name="yzm"/></td>
				<td><input type="button" id="sendMsg" style="width:100px" value="获取验证码"/></td>

			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button" id="submit" style="width:100px" value="注册" /></td>
			</tr>			
		</table>
	</section>

</form>
</body>
</html>