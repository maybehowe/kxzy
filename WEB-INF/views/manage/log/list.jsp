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
	$(function(){
		var searchName = $("#searchName").val();
		if(searchName==''){
			$("#searchName").val('用户名');
		}
	});
	function searchSubmit(){
		$("#curPage").val(1);
		$("#searchForm").submit();
	}
	/*]]>*/
	</script>
</head>

<body>
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp"/>
		<div class="right">
			<!--查询-->
			<form id="searchForm" name="searchForm" action="${contextPath}/manage/log/list.rt" method="post">
			<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			<input type="hidden" name="viewId" id="viewId" value="${viewId }"/>
			<input type="hidden" name="leftId" id="leftId" value="${leftId }"/>
			<fieldset class="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
					<p class="fl mr15"><input name="log.operName" id="searchName" type="text" class="text" value="<c:out value='${log.operName }' escapeXml="true" />" onfocus="if(this.value=='用户名'){this.value=''}" onblur="if(this.value==''){this.value='用户名'}" /></p>
					<p><input name="" type="button" onclick="searchSubmit();" value="搜 索" class="sub" /></p>
				</div>
			</fieldset>
			<!--查询.end-->
			<!--数据列表-->
			<div class="main">
				<table width="100%" border="0" id="At_table">
				  <tr>
					<th scope="col" width="7%">序号</th>
					<th scope="col" width="15%">操作用户</th>
<!-- 					<th scope="col" width="20%">操作内容</th> -->
					<th scope="col" width="23%">时间</th>
					<th scope="col" width="15%">IP地址</th>
					<th scope="col" width="20%">操作</th>
				  </tr>
				  <c:forEach items="${page.results }" var="log" varStatus="index">
				  	<tr>
						<td>${index.index+1 }</td>
						<td>${log.operName }</td>
<!-- 						<td>${log.description }</td> -->
						<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${log.operTime }"/></td>
						<td>${log.ip }</td>
						<td>
							<a href="${contextPath }/manage/log/detail.rt?id=${log.id}&viewId=${viewId}&leftId=${leftId}">查看详情</a>
						</td>
					  </tr>
				  </c:forEach>
				</table>
				<div class="page">
					<jsp:include page="../common/page.jsp">
					<jsp:param value="${contextPath}/manage/log/list.rt" name="pageUrl"/>
					<jsp:param value="searchForm" name="formName"/>
					</jsp:include>
				</div>
			</div>
			</form>
			<!--数据列表.end-->
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

