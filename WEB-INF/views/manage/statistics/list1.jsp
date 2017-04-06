<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>科协资源管理平台</title>
<%@include file="../common/form.jsp" %>
<link href="${contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
/*<![CDATA[*/
function selectChange(obj){
	window.location.href="${contextPath}/manage/statistics/list1.rt?viewId=${viewId}&leftId=${leftId}&columnId="+$(obj).val();
}
/*]]>*/
</script>
</head>
<body>
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp" />
		<div class="right">
			<div class="main">
				<table width="100%" border="0" id="At_table" class="fl">
				  <tr>
				  	<c:forEach items="${lall }" var="obj">
				  		<th scope="col" width="5%">${obj[1] }: ${obj[0] }条</th>
				  	</c:forEach>
				  </tr>
				  </table>
			</div>
			<!--查询-->
			<form name="searchForm" id="searchForm" action="" method="post">
			<input type="hidden" name="viewId" value="${viewId }" />
			<input type="hidden" name="leftId" value="${leftId }" />
			<fieldset class="search" style="clear:both;">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
					视频分类：
					<select id="columnId" name="columnId" onchange="selectChange(this)">
						<option value="">请选择</option>
						<c:forEach items="${columnes }" var="c">
							<option<c:if test="${columnId==c.id }"> selected="selected"</c:if> value="${c.id }">${c.name }</option> 
						</c:forEach>
					</select>
				</div>
			</fieldset>
			<!--查询.end-->
			<!--数据列表-->
			<div class="main">
				<table width="50%" border="0" id="At_table" class="fl" style="margin-top:20px;">
				  <tr>
					<th scope="col" width="5%">序号</th>
					<th scope="col" width="10%">视频名称</th>
					<th scope="col" width="10%">上传机构</th>
					<th scope="col" width="20%">发布时间</th>
					<th scope="col" width="5%">点播数</th>
				  </tr>
				  	<c:forEach items="${list }" var="v" varStatus="index">
				  		<tr>
							<td>${index.index+1}</td>
							<td>${v[0] }</td>
							<td>${v[2] }</td>
							<td><fmt:formatDate value="${v[1] }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td>${v[3] }</td>
						  </tr>
				  	</c:forEach>
				</table>
				<img src="${contextPath}/upload/panel.jpg" alt="" width="48%" class="fr" />
				<div class="page">
<%--					<div class="page_all"><input name="cc" type="checkbox" value="all" id="All" onClick="selectAll(this);" /></div>--%>
<%--					<div class="quanx fl"><label for="All">全选/反选</label></div>--%>
<%--					<div class="fl"><input type="button" id="delSelected" value="删除选中视频" class="sub2 ml25" style="*margin-left:-170px;" /></div>--%>
<%--					<jsp:include page="../common/page.jsp" >--%>
<%--					<jsp:param value="${contextPath}/manage/video/list.rt" name="pageUrl"/>--%>
<%--					<jsp:param value="searchForm" name="formName"/>--%>
<%--					</jsp:include>--%>
					
				</div>
			</div>
			<!--数据列表.end-->
			</form>
		</div>
		<div class="cb"></div>
	</div>
</div>
<script type="text/javascript">
	var Ptr=document.getElementById("At_table").getElementsByTagName("tr");
    for (i=1;i<Ptr.length+1;i++) { 
    	Ptr[i-1].className = (i%2>0)?"t1":"t2"; 
    }
</script>
<script src="${contextPath}/js/checkbox.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>

