<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="../common/form.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="edge" />
	<title>科协资源管理平台</title>
	<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
</head>

<body>
<form>
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp"/>
		<div class="right">
			<!--[if lt IE 8]><div class="both"></div><![endif]-->
			<div class="main">
				<div class="tit">日志详情</div>
				<div class="line">日志详情：</div>
				<table width="96%" border="0" class="data">
				  <tr>
					<th scope="row" width="110">用户：</th>
					<td><span>${log.operName }</span></td>
				  </tr>
				  <tr>
					<th scope="row" align="right">操作时间：</th>
					<td><span><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${log.operTime }"/></span></td>
				  </tr>
				  <tr>
					<th scope="row">IP地址：</th>
					<td><span>${log.ip }</span></td>
				  </tr>
				  <tr>
					<th scope="row" valign="top" class="mt6 pt13">操作：</th>
					<td><span>${log.description }</span></td>
				  </tr>
				  <tr class="buttom">
					<th scope="row" align="right"></th>
					<td>
						<a href="javascript:window.history.back();" class="but_fanhui" style="height:24px;border:0px;font-size:14px;color:white;font-weight:bold;">返 回</a>
					</td>
				  </tr>
				</table>
			</div>
		</div>
		<div class="cb"></div>
	</div>
</div>
</form>
</body>
</html>

