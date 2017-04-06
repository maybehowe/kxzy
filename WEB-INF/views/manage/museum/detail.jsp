<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roots.kxzy.system.common.constant.JudgeStatus"%>
<%
	request.setAttribute("yes",JudgeStatus.YES);
	request.setAttribute("no",JudgeStatus.NO);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="edge" />
	<title>科协资源-图集详情查看</title>
	<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/css/style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/js/form.js"></script>
	<script type="text/javascript">
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
				<div class="tit">查看图集信息</div>
				<div class="line">图集详情：</div>
				<table width="96%" border="0" class="data">
			    <tr>
					<th scope="row" width="110">封面图：</th>
					<td>
					    <c:if test="${not empty museum.isCover}">
					    <img src="${contextPath}/manage/museum/picture/thumbnail.rt?picId=${museum.isCover}&size=176" alt="...">
					  </c:if>
					</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">所属分类：</th>
					<td>${museum.type eq 1 ?'省内场馆' : '国内场馆'}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110"> 场馆名称：</th>
					<td>${rt:escapeHtml(museum.name)}</td>
				  </tr>
				  <c:if test="${museum.type eq 1 }">
				  <!-- 省内 -->
					  <tr>
						<th scope="row" width="110">场馆城市：</th>
						<td>${museum.cityName}</td>
					  </tr>
				  </c:if>
				  <c:if test="${museum.type eq 2 }">
				  <!-- 国内 -->
					  <tr>
						<th scope="row" width="110">场馆链接：</th>
						<td>${museum.link}</td>
					  </tr>
				  </c:if>
				  <tr>
				  	<th scope="row" width="110">场馆简介：</th>
					<td>
					  ${rt:escapeHtml(museum.descript)}
					</td>
				  </tr>
				  <tr>
					<th scope="row">创建时间：</th>
					<td>
                       <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${museum.createTime }" />
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