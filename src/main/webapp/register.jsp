<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/alert.js"></script>

<script language="javascript" type="text/javascript">
	$(function () {

	    //获取手机验证码
        $('#sendMsg').click(function () {
            $.post('/login/testMsg.do',{phone:$('#phone').val()},function (data) {
                console.log(data)
            });
        })

        //表单的较验
        $('#form1').validate({
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
        })


        //表单较验
        /*$('#submit').click(function () {

        })*/



		$('#userName').blur(function () {
			$.ajax({
				url:'/login/checkUserName.do',
				data:{userName:$('#userName').val()},
				type:'post',
				success:function (data) {
					console.log(JSON.stringify(data))
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
				<td colspan="2" align="center"><input type="submit" id="submit" style="width:100px" value="注册" /></td>
			</tr>			
		</table>
	</section>

</form>
</body>
</html>