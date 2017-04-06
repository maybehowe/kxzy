<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>科协资源管理平台</title>
<%@include file="../common/form.jsp" %>
<link href="${contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/sco.message.css" type="text/css"></link>
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/scojs.css" type="text/css"></link>
<script type="text/javascript" src="${contextPath}/bootstrap.sco/js/sco.message.js"></script>
<script type="text/javascript">
/*<![CDATA[*/
	$(function(){
		var searchName = $("#searchName").val();
		if(searchName==''){
			$("#searchName").val('角色名称');
		}
		
	//批量删除
	$("#delSelected").click(function(){
		var arrayId = new Array();
		$("input[name='roleIds']:checked").each(function(){
			arrayId.push($(this).val());
		});
		if(arrayId.length > 0){
			var ids = "";
			for ( var i = 0; i < arrayId.length; i++) {
				ids += arrayId[i] + ",";
			}
			ids = ids.substring(0, ids.length - 1);
			if(confirm("确定删除？")){
				var url = "${contextPath }/manage/role/delete.rt";
				var params = {
					"ids" : ids,
				};
				$.post(url,params,function(result) {
					if (result.flag){
						 $.scojs_message('删除成功',{
							 "type":$.scojs_message.TYPE_OK,
							 "delay":4000,
							 "onAfterHidden" : function(){
								 $("#searchForm").attr("action","${contextPath }/manage/role/list.rt");
								 $("#searchForm").submit();
							 }
						 });
					} else {
						 $.scojs_message('删除失败', $.scojs_message.TYPE_ERROR);
					}
				});
			}else{
				return false;
			}
		} else{
			$.scojs_message('请至少选择一行数据！', $.scojs_message.TYPE_ERROR);
		}
	});
});

	//删除
	function del(roleId){
		if(confirm("确定删除？")){
				var url = "${contextPath }/manage/role/delete.rt";
				var params = {
					"ids" : roleId,
				};
				$.post(url,params,function(result) {
					if (result.flag){
						 $.scojs_message('删除成功',{
							 "type":$.scojs_message.TYPE_OK,
							 "delay":4000,
							 "onAfterHidden" : function(){
								 $("#searchForm").attr("action","${contextPath }/manage/role/list.rt");
								 $("#searchForm").submit();
							 }
						 });
						 $("#searchForm").attr("action","${contextPath }/manage/role/list.rt");
						 $("#searchForm").submit();
					} else {
						 $.scojs_message('删除失败', $.scojs_message.TYPE_ERROR);
					}
				});
			}else{
				return false;
			}
	}

function searchSubmit(){
	$("#curPage").val(1);
	$("#searchForm").submit();
}

//上移
function upMove(roleId) {
	var url = "${contextPath}/manage/role/move.rt";
	var params = {
			roleId : roleId,
			"doup" : true
		};
		$.post(url, params, function(result) {
			if (result.success==true) {
				window.location.reload();
			} else {
				alert("排序失败！");
			}
		});
}

//下移
function downMove(roleId) {
	var url = "${contextPath}/manage/role/move.rt";
	var params = {
			roleId : roleId,
			"doup" : false
		};
		$.post(url, params, function(result) {
			if (result.success==true) {
				window.location.reload();
			} else {
				alert("排序失败！");
			}
		});
}
function edit(id){
	$("#searchForm").attr("action","${contextPath }/manage/role/edit.rt?id="+id);
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
				<a href="${contextPath}/manage/role/add.rt?viewId=${viewId}&leftId=${leftId}">添加角色</a>
			</div>
			<!--查询-->
			<form name="searchForm" id="searchForm" action="${contextPath}/manage/role/list.rt" method="post">
			<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			<input type="hidden" name="viewId" value="${viewId }" />
			<input type="hidden" name="leftId" value="${leftId }" />
			<fieldset class="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
					<p class="fl mr15"><input name="searchName" id="searchName" type="text" class="text" value="<c:out value="${searchName }" escapeXml="true"/>" onfocus="if(this.value=='角色名称'){this.value=''}" onblur="if(this.value==''){this.value='角色名称'}" /></p>
					<p class=""><input name="" type="button" onclick="searchSubmit();" value="搜 索" class="sub" /></p>
				</div>
			</fieldset>
			<!--查询.end-->
			<!--数据列表-->
			<div class="main">
				<table width="100%" border="0" id="At_table">
				  <tr>
					<th scope="col" width="7%"><input name="c0" type="checkbox" value="check" /></th>
					<th scope="col" width="15%">角色名称</th>
					<th scope="col" width="15%">备注</th>
					<th scope="col" width="10%">级别数</th>
					<th scope="col" width="15%">创建时间</th>
					<th scope="col" width="34%">操作</th>
				  </tr>
				  <c:forEach items="${page.results }" var="r">
				  	<tr>
						<td><input name="roleIds" type="checkbox" value="${r.id }" /></td>
						<td>${r.roleName }</td>
						<td><c:out value="${r.roleDes }" escapeXml="true"/></td>
						<td>${r.sortId }</td>
						<td><fmt:formatDate value="${r.createtime }" pattern="yyyy-MM-dd"/></td>
						<td>
<%--							<a href="${contextPath }/manage/role/allocation.rt?id=${r.id}&viewId=${viewId}&leftId=${leftId}">分配用户</a><span> -</span>--%>
							<a href="${contextPath }/manage/role/resAllo.rt?id=${r.id}&viewId=${viewId}&leftId=${leftId}">资源分配</a><span> -</span>
							<a href="${contextPath }/manage/role/addPermission.rt?id=${r.id}&viewId=${viewId}&leftId=${leftId}">分配权限</a><span> -</span>
							<a href="javascript:void(0);" onclick="edit(${r.id});">编辑</a>
							<!--<c:if test="${r.sortId != 1}">
							   <a href="javascript:void(0);" onclick="del(${r.id});">删除</a><span> -</span>
							</c:if>
							<a href="javascript:void(0);" onclick="upMove(${r.id});">上移</a><span> -</span>
							<a href="javascript:void(0);" onclick="downMove(${r.id});">下移</a>-->
						</td>
					  </tr>
				  </c:forEach>
				</table>
				<div class="page">
					<%--<div class="page_all"><input name="cc" type="checkbox" value="all" id="All" onClick="selectAll(this);" /></div>--%>
					<%--<div class="quanx fl"><label for="All">全选/反选</label></div>--%>
					<%--<div class="fl"><input type="button" id="delSelected" value="删除选中角色" class="sub2 ml25" style="*margin-left:-170px;" /></div>--%>
					<jsp:include page="../common/page.jsp" >
					<jsp:param value="${contextPath}/manage/role/list.rt" name="pageUrl"/>
					<jsp:param value="searchForm" name="formName"/>
					</jsp:include>
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

