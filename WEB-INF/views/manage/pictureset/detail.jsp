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
				<div class="tit">查看图集信息</div>
				<div class="line">图集详情：</div>
				<table width="96%" border="0" class="data">
				  <tr>
					<th scope="row" width="110">封面图：</th>
					<td>
					    <c:if test="${not empty pictureset.isCover}">
					    <img src="${contextPath}/manage/picture/thumbnail.rt?picId=${pictureset.isCover}&size=176" alt="...">
					  </c:if>
					</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">所属分类：</th>
					<td>${channel.parent.name}—${channel.name}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110"> 图集标题：</th>
					<td>${rt:escapeHtml(pictureset.name)}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">学科分类：</th>
					<td>${subject.name}</td>
				  </tr>
  				  <tr>
					<th scope="row" width="110">来源：</th>
					<td>
					   ${pictureset.sourceId eq 1 ? "无" : ""}
					   ${pictureset.sourceId eq 2 ? "原创" : ""}
					   ${pictureset.sourceId eq 3 ? "转载" : ""}
					   ${pictureset.sourceId eq 4 ? "购买版权" : ""}
					</td>
				  </tr>
   				  <tr>
					<th scope="row" width="110">是否为图片简介：</th>
					<td>
					   ${pictureset.isPictureDesc eq yes ? "是" : ""}
					   ${pictureset.isPictureDesc eq no ? "否" : ""}
					</td>
				  </tr>
				  <tr>
				  	<th scope="row" width="110">简介：</th>
					<td>
					  ${rt:escapeHtml(pictureset.description)}
					</td>
				  </tr>
				  <tr>
					<th scope="row">创建时间：</th>
					<td>
                       <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${pictureset.createTime }" />
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