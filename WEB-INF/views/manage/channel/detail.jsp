<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>科协资源管理平台</title>
<%@include file="../common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript">
$(function(){
	 if("${add_refresh}"){
		parent.reFresh(); 
	 }
});
 </script>
</head>
<body>
<div class="main">
  <table width="96%" border="0" class="data">
  <tr>
	<th scope="row" width="110">名称：</th>
	<td>${fn:escapeXml(channel.name)}</td>
  </tr>
   <tr>
	<th scope="row" width="110">栏目URL：</th>
	<td>${fn:escapeXml(channel.siteUrl)}</td>
  </tr>
   <tr>
	<th scope="row" width="110">英文名：</th>
	<td>${channel.englishName }</td>
  </tr>
  <tr>
    <th scope="row" width="110">图片预览：</th>
    <td>
    <c:choose>
      <c:when test="${channel.imgPath != null}">
         <img src="${contextPath}${channel.imgPath}" alt="${channel.imgName}" width="115" height="95" />
      </c:when>
      <c:otherwise>
          <img src="${contextPath}/images/load.jpg" alt="默认图" width="115" height="95" />
      </c:otherwise>
    </c:choose>
    </td>
  </tr>
  <tr>
	<th scope="row" width="110">描述：</th>
	<td>${fn:escapeXml(channel.description)}</td>
  </tr>
</table>
</div>
</body>
</html>