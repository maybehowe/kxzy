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
	window.location.href="${contextPath}/manage/statistics/list3.rt?viewId=${viewId}&leftId=${leftId}&year="+$(obj).val();
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
			<!--查询-->
			<form name="searchForm" id="searchForm" action="${contextPath}/manage/video/list.rt" method="post">
			<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			<input type="hidden" name="viewId" value="${viewId }" />
			<input type="hidden" name="leftId" value="${leftId }" />
			<fieldset class="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
				年份:
				<select name="year" id="year" onchange="selectChange(this);">
					<option>请选择</option>
					<c:forEach items="${years }" var="y">
						<option<c:if test="${y==year }"> selected="selected"</c:if> value="${y }">${y }</option>
					</c:forEach>
				</select>
				</div>
			</fieldset>
			<!--查询.end-->
			<!--数据列表-->
			<div class="main">
				<img src="${contextPath}/upload/timeSeries_${year }.jpg" alt="" id="timeSeries"/>
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
<script src="${contextPath}/js/checkbox.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>

