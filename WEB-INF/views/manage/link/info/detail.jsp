<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="edge" />
	<title>科协资源-友情链接详情查看</title>
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
				<div class="tit">查看友情链接信息</div>
				<div class="line">友情链接详情：</div>
				<table width="96%" border="0" class="data">
				  <tr>
					<th scope="row" width="110">链接名称：</th>
					<td>${link.linkName }</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">链接类型：</th>
					<td>${cate.cateName}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">域名地址：</th>
					<td>${rt:escapeHtml(link.address)}</td>
				  </tr>
				  <!--<tr>
					<th scope="row" width="110">主办单位：</th>
					<td>${link.organizer}</td>
				  </tr>-->
				  <tr>
					<th scope="row" width="110">图片：</th>
					<td>
					   <c:choose>
					      <c:when test="${link.pictureUrl != null}">
					         <img src="${contextPath}${link.pictureUrl}"  width="225px" height="80px"/>
					      </c:when>
					      <c:otherwise>
					          <img src="${contextPath}/images/load.jpg" alt="" width="225px" height="80px" />
					      </c:otherwise>
					    </c:choose>
					</td>
				  </tr>
				   <!--<tr>
					 <th scope="row">简介：</th>
					<td><%--
				      --%><%--<div style="word-break:break-all; width: 400px; height: 90px; overflow-Y:auto; border: 1px solid #eeeeee;">
					  </div>--%>
					 ${rt:escapeHtml(link.introduction)}
					</td>
				  </tr> -->
				  <tr>
					<th scope="row">创建时间：</th>
					<td>
                       <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${link.createTime }" />
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