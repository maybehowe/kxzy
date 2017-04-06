<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="edge" />
	<title>科协资源-科普团体详情查看</title>
	<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/js/form.js"></script>
	 <script type="text/javascript" language="javascript">
	     $(function(){
	    	 if("${add_refresh}"){
	    		parent.reFresh(); 
	    	 }
	     });
	 </script>
</head>

<body>
<div class="wrapper" style="min-width:100%;">
	<div class="content" style="min-width:100%;">
			<!--[if lt IE 8]><div class="both"></div><![endif]-->
			<div class="main" style="min-height:100%;">
		<table width="96%" border="0" class="data">
		  <tr>
			<th scope="row" width="110">团体名称：</th>
			<td>${team.teamName}</td>
		  </tr>
		  <tr>
			<th scope="row" width="110">团体地址：</th>
			<td>${rt:escapeHtml(team.teamAddress)}</td>
		  </tr>
		  <tr>
			<th scope="row" width="110">联系方式：</th>
			<td>${team.contact}</td>
		  </tr>
		  <tr>
			<th scope="row" width="110">团体简称：</th>
			<td>${rt:escapeHtml(team.shortName)}
			<!-- <div style="word-break:break-all; width: 400px; height: 90px; overflow-Y:auto; border: 1px solid #eeeeee;">
				
			 </div>-->
			</td>
		  </tr>
		  <tr>
			<th scope="row" width="110">备注：</th>
			<td>${rt:escapeHtml(team.remark)}
			  <!--<div style="word-break:break-all; width: 400px; height: 90px; overflow-Y:auto; border: 1px solid #eeeeee;">
				
			  </div>-->
			</td>
		  </tr>
		   <tr>
			<th scope="row">访问链接：</th>
			<td>
		      ${rt:escapeHtml(team.linkUrl)}
			</td>
		  </tr>
		    <tr>
			<th scope="row" width="110">图片：</th>
			<td>
		    <c:choose>
		      <c:when test="${team.imgPath != null}">
		         <img src="${contextPath}${team.imgPath}" width="220" height="200"/>
		      </c:when>
		      <c:otherwise>
		          <img src="${contextPath}/images/load.jpg" alt="" width="220" height="200" />
		      </c:otherwise>
		    </c:choose>
		    </td>
		  </tr>
		  <tr>
			<th scope="row">创建时间：</th>
			<td>
	           <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${team.createTime }" />
			</td>
		  </tr>
		</table>
			</div>
		</div>
	</div>
</body>
</html>