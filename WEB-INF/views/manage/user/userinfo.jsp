<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>科协资源-用户详情查看</title>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/js/form.js"></script>
<script type="text/javascript">
//用户编辑
function showEdit(userId){
	var url = "${contextPath}/manage/user/showEditSelf.rt?userId=${sessionScope.userId}&viewId=${viewId}&leftId=${leftId}";
	window.location.href=url;
}
//修改密码
function modifyPwd(userId){
	var url = "${contextPath}/manage/user/showModifyPwd.rt?userId=${sessionScope.userId}&viewId=${viewId}&leftId=${leftId}";
	window.location.href=url;
}
</script>
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
				<div class="tit">用户个人信息</div>
				<div class="line">信息详情：</div>
                <div>
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
					<th scope="row" width="110">手机号码：</th>
					<td>${user.mobile}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">电话号码：</th>
					<td>${user.telphone}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">Email：</th>
					<td>${user.email}</td>
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
						<input type="button" id="submit_btn" value="用户编辑" onclick="showEdit()" class="add_but fl"/>
						<input type="button" id="submit_btn" value="修改密码" onclick="modifyPwd()" class="add_but fl"/>
						<a href="javascript:window.history.back();" class="but_fanhui fl" style="height:24px;border:0px;font-size:14px;color:white;font-weight:bold;">返 回</a>
					</td>
				  </tr>
				</table>
				</div>
			</div>
		</div>
		<div class="cb"></div>
	</div>
</div>
</form>
</body>
</html>