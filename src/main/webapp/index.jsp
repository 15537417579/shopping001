<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.5.js"></script>
<script language="javascript" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/lcsp_frame.css" type="text/css">
</head>
<frameset rows="40,*" framespacing="0"  frameborder="0" id="main_frame_top" name="main_frame_top">
	<frame name="contents" target="main" src="<%=request.getContextPath()%>/jsp/menu.jsp" scrolling="no" noresize class="frame_border">
	<frame name="main" src="<%=request.getContextPath()%>/goods/PageList.do?curPage=1" scrolling="auto" class="frame_border">
	<noframes>
	<body>
	<p>此网页使用了框架，但您的浏览器不支持框架。</p>

	</body>

	</noframes>
</frameset>
</html>