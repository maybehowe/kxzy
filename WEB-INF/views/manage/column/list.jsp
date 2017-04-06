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
		$("#searchName").val('栏目名称');
	}
});
function edit(id){
	$("#searchForm").attr("action","${contextPath}/manage/column/edit.rt?id="+id);
	$("#searchForm").submit();
}  

function del(id){
	if(confirm("确定删除？")){
		$.ajax({
		   type: "POST",
		   url: "${contextPath}/manage/column/delete.rt?id="+id,
		   success: function(json){
		     if(!json.flag){
		    	 alert("删除失败，该频道包含其他栏目信息。");
		     } else{
		    	 $("#searchForm").attr("action","${contextPath}/manage/column/list.rt");
	    		 $("#searchForm").submit();
		     }
		   }
		}); 
	}
}

function searchSelect(){
	$("#searchForm").attr("action","${contextPath}/manage/column/list.rt");
	$("#searchForm").submit();
}

function disableOrEnable(id){
	$("#searchForm").attr("action","${contextPath}/manage/column/disableOrEnable.rt?id="+id);
	$("#searchForm").submit();
}
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
		<jsp:include page="../common/left.jsp" />
		<div class="right">
			<div class="buts">
				<a href="${contextPath}/manage/column/add.rt?viewId=${viewId}&leftId=${leftId}">添加栏目</a>
			</div>
			<!--查询-->
			<form id="searchForm" name="searchForm" action="${contextPath}/manage/column/list.rt" method="post">
			<input type="hidden" name="viewId" value="${viewId }" />
			<input type="hidden" name="leftId" value="${leftId }" />
			<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			<fieldset class="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
					所属查询
					<select name="col.channelId" id="channelId" onchange="searchSelect();">
						<option value="">请选择</option>
						<c:forEach items="${channeles }" var="chann">
						<option<c:if test="${chann.id==col.channelId }"> selected="selected"</c:if> value="${chann.id }">${chann.name }</option>
						</c:forEach>
					</select>
					状态查询：
					<select class="mr40" name="col.status" onchange="searchSelect();">
					  <option<c:if test="${col.status==1 }"> selected="selected"</c:if> value="1">启用</option>
					  <option<c:if test="${col.status==0 }"> selected="selected"</c:if> value="0">禁用</option>
					</select>
					<input name="searchName" id="searchName" type="text" class="text" value="${col.name }" onfocus="if(this.value=='栏目名称'){this.value=''}" onblur="if(this.value==''){this.value='栏目名称'}" />
					<input name="" type="button" onclick="searchSubmit();" value="搜 索" class="sub" />
				</div>
			</fieldset>
			<!--查询.end-->
			<!--数据列表-->
			<div class="main">
				<table width="100%" border="0" id="At_table">
				  <tr>
					<th scope="col" width="7%"><input name="c0" type="checkbox" value="check" /></th>
					<th scope="col" width="21%">栏目名称</th>
					<th scope="col" width="15%">栏目代码</th>
					<th scope="col" width="15%">排序号</th>
					<th scope="col" width="15%">描述</th>
					<th scope="col" width="8%">状态</th>
					<th scope="col" width="19%">操作</th>
				  </tr>
				  <c:forEach items="${page.results }" var="chann">
				  	<tr>
					<td><input name="channIds" type="checkbox" value="${chann.id }" /></td>
					<td>${chann.name }</td>
					<td>${chann.columnCode }</td>
					<td>${chann.sortId }</td>
					<td>${chann.description }</td>
					<td>
					<c:if test="${chann.status==0 }"><span class="no">禁用</span></c:if>
					<c:if test="${chann.status==1 }"><span class="ok">启用</span></c:if>
					</td>
					<td>
						<a href="javascript:void(0);" onclick="edit(${chann.id})">编辑</a><span> -</span>
						<a href="javascript:void(0);" onclick="disableOrEnable(${chann.id})">
						<c:if test="${chann.status==0 }">启用</c:if>
						<c:if test="${chann.status==1 }">禁用</c:if>
						</a><span> -</span>
						<a href="javascript:void(0);" onclick="del(${chann.id})">删除</a>
					</td>
				  </tr>
				  </c:forEach>
				</table>
				<div class="page">
<%--					<div class="page_all"><input name="cc" type="checkbox" value="all" id="All" onClick="switchAll()" /></div>--%>
<%--					<div class="quanx fl"><label for="All">全选/反选</label></div>--%>
<%--					<div class="fl"><input type="button" value="删除选中角色" class="sub2 ml25" style="*margin-left:-170px;" /></div>--%>
					<jsp:include page="../common/page.jsp" >
					<jsp:param value="${contextPath}/manage/column/list.rt" name="pageUrl"/>
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

