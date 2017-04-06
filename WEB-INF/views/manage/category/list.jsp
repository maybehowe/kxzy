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
		$("#searchName").val('分类名称');
	}
});
function edit(id){
	$("#searchForm").attr("action","${contextPath}/manage/category/edit.rt?id="+id);
	$("#searchForm").submit();
}  

function del(id){
	if(confirm("确定删除？")){
		$("#searchForm").attr("action","${contextPath}/manage/category/delete.rt?id="+id);
		$("#searchForm").submit();
	}
}

function searchSelect(){
	$("#searchForm").attr("action","${contextPath}/manage/category/list.rt");
	$("#searchForm").submit();
}

function disableOrEnable(id){
	$("#searchForm").attr("action","${contextPath}/manage/category/disableOrEnable.rt?id="+id);
	$("#searchForm").submit();
}

function loadColumn(){
	var id = $("#channelId").val();
	if(id != null){
		$.ajax({
		   type: "POST",
		   url: "${contextPath}/manage/column/loadColumn.rt?id="+id,
		   success: function(json){
			   if(json.flag){
				   var html = '';
				    html +='<select name="category.columnId" id="columnId" onchange="searchSelect();">';
					html +='<option value="">请选择</option>';
					$(json.columns).each(function(i,item){
						html +='<option value="'+item.id+'">'+item.name+'</option>';
					});
					html +='</select>';
			   }
			   $("#columnes").html(html);
		   }
		});
	}
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
				<a href="${contextPath}/manage/category/add.rt?viewId=${viewId}&leftId=${leftId}">添加分类</a>
			</div>
			<!--查询-->
			<form id="searchForm" name="searchForm" action="${contextPath}/manage/category/list.rt" method="post">
			<input type="hidden" name="viewId" value="${viewId }" />
			<input type="hidden" name="leftId" value="${leftId }" />
			<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			<fieldset class="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
					所属查询
					<select name="channelId" id="channelId" onchange="loadColumn();">
						<option value="">请选择</option>
						<c:forEach items="${channeles }" var="chann">
						<option<c:if test="${chann.id==channelId }"> selected="selected"</c:if> value="${chann.id }">${chann.name }</option>
						</c:forEach>
					</select>
					<span id="columnes">
						<select name="category.columnId" id="columnId" onchange="searchSelect();">
							<option value="">请选择</option>
							<c:forEach items="${columnes }" var="col">
							<option<c:if test="${col.id==category.columnId }"> selected="selected"</c:if> value="${col.id }">${col.name }</option>
							</c:forEach>
						</select>
					</span>
					状态查询：
					<select class="mr40" name="category.status" onchange="searchSelect();">
					  <option<c:if test="${category.status==1 }"> selected="selected"</c:if> value="1">启用</option>
					  <option<c:if test="${category.status==0 }"> selected="selected"</c:if> value="0">禁用</option>
					</select>
					<input name="searchName" id="searchName" type="text" class="text" value="${category.name }" onfocus="if(this.value=='分类名称'){this.value=''}" onblur="if(this.value==''){this.value='分类名称'}" />
					<input name="" type="button" onclick="searchSubmit();" value="搜 索" class="sub" />
				</div>
			</fieldset>
			<!--查询.end-->
			<!--数据列表-->
			<div class="main">
				<table width="100%" border="0" id="At_table">
				  <tr>
					<th scope="col" width="7%"><input name="c0" type="checkbox" value="check" /></th>
					<th scope="col" width="21%">分类名称</th>
					<th scope="col" width="15%">排序号</th>
					<th scope="col" width="15%">描述</th>
					<th scope="col" width="8%">状态</th>
					<th scope="col" width="19%">操作</th>
				  </tr>
				  <c:forEach items="${page.results }" var="cates">
				  	<tr>
					<td><input name="channIds" type="checkbox" value="${cates.id }" /></td>
					<td>${cates.name }</td>
					<td>${cates.sortId }</td>
					<td>${cates.description }</td>
					<td>
					<c:if test="${cates.status==0 }"><span class="no">禁用</span></c:if>
					<c:if test="${cates.status==1 }"><span class="ok">启用</span></c:if>
					</td>
					<td>
						<a href="javascript:void(0);" onclick="edit(${cates.id})">编辑</a><span> -</span>
						<a href="javascript:void(0);" onclick="disableOrEnable(${cates.id})">
						<c:if test="${cates.status==0 }">启用</c:if>
						<c:if test="${cates.status==1 }">禁用</c:if>
						</a><span> -</span>
						<a href="javascript:void(0);" onclick="del(${cates.id})">删除</a>
					</td>
				  </tr>
				  </c:forEach>
				</table>
				<div class="page">
<%--					<div class="page_all"><input name="cc" type="checkbox" value="all" id="All" onClick="switchAll()" /></div>--%>
<%--					<div class="quanx fl"><label for="All">全选/反选</label></div>--%>
<%--					<div class="fl"><input type="button" value="删除选中角色" class="sub2 ml25" style="*margin-left:-170px;" /></div>--%>
					<jsp:include page="../common/page.jsp" >
					<jsp:param value="${contextPath}/manage/category/list.rt" name="pageUrl"/>
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

