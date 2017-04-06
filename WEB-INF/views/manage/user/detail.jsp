<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roots.kxzy.system.common.constant.EnableStatus"%>
<%
	request.setAttribute("enable",EnableStatus.ENABLE);
	request.setAttribute("disable",EnableStatus.DISABLE);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="edge" />
	<title>科协资源-用户详情查看</title>
	<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/js/form.js"></script>
</head>
<body>
<form>
<div class="wrapper">
	<jsp:include page="/WEB-INF/views/manage/common/head.jsp" />
	<div class="content">
		  <jsp:include page="/WEB-INF/views/manage/common/left.jsp"/>
		<div class="right">
			<!--[if lt IE 8]><div class="both"></div><![endif]-->
			<div class="main">
				<div class="tit">查看用户信息</div>
				<div class="line">用户详情：</div>
				<table width="96%" border="0" class="data">
				  <tr>
					<th scope="row" width="110">登录名：</th>
					<td>${user.loginName}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">昵称：</th>
					<td>${user.nickName}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">用户姓名：</th>
					<td>${user.realName}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">所属角色：</th>
					<td>${roelReluser.role.roleName}</td>
				  </tr>
				   <tr>
					<th scope="row" width="110">所属团体：</th>
					<td>${t.teamName}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">状态：</th>
					<td>
					   ${user.activation eq enable ? "激活" : "禁用"}
					 </td>
				  </tr>
  				  <tr>
					<th scope="row" width="110">Email：</th>
					<td>${user.email}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">手机：</th>
					<td>${user.mobile}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">电话：</th>
					<td>${user.telphone}</td>
				  </tr>
				  <tr>
					<th scope="row">创建时间：</th>
					<td>
                       <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${user.createTime }" />
					</td>
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