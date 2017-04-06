<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>科协资源-图片查看</title>
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/sco.message.css" type="text/css"></link>
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/scojs.css" type="text/css"></link>
<script type="text/javascript" src="${contextPath}/bootstrap.sco/js/sco.message.js"></script>
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
				<div class="tit">查看图片信息</div>
				<div class="line">图片详情：</div>
				<table border="0" class="data" style="width:width: 96%;">
				  <tr>
					<th scope="row" width="110">图片名称：</th>
					<td>${rt:escapeHtml(picture.picName)}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">图片简介：</th>
					<td>${rt:escapeHtml(picture.picDescription)}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">原图：</th>
					<td>
					  <div style="width:670px; overflow: hidden;"><img src="${contextPath}/manage/picture/image.rt?picId=${picture.id}" alt="..." style="max-width: 670px;"></div>
					</td>
				  </tr>
				  <tr></tr>
				  <tr>
				    <th>缩略图：</th>
				    <td>
				      <img  src="${contextPath}/manage/picture/thumbnail.rt?picId=${picture.id}&size=176" alt="176">
	    			  <img  src="${contextPath}/manage/picture/thumbnail.rt?picId=${picture.id}&size=152" alt="152">
	    			  <img  src="${contextPath}/manage/picture/thumbnail.rt?picId=${picture.id}&size=128" alt="128">
	    			  <img  src="${contextPath}/manage/picture/thumbnail.rt?picId=${picture.id}&size=100" alt="100">
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