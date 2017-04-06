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
			$("#searchName").val('类别名称');
		}
		$("#delSelected").click(function(){
			var arrayId = new Array();
			$("input[name='rescIds']:checked").each(function(){
				arrayId.push($(this).val());
			});
			if(arrayId.length > 0){
				if(confirm("确定删除？")){
					$("#searchForm").attr("action","${contextPath}/manage/resCategory/delSelected.rt");
					$("#searchForm").submit();
				}
			} else{
				alert("请至少选择一行数据");
			}
		});
	});
function del(id){
	if(confirm("确定删除？")){
		$("#searchForm").attr("action","${contextPath}/manage/resCategory/delete.rt?id="+id);
		$("#searchForm").submit();
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
				<a href="${contextPath}/manage/resCategory/add.rt?viewId=${viewId}&leftId=${leftId}">添加类别</a>
			</div>
			<!--查询-->
			<form name="searchForm" id="searchForm" action="${contextPath}/manage/resCategory/list.rt" method="post">
			<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			<input type="hidden" name="viewId" value="${viewId }" />
			<input type="hidden" name="leftId" value="${leftId }" />
			<fieldset class="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
					<p class="fl mr15"><input name="searchName" id="searchName" type="text" class="text" value="<c:out value="${searchName }" escapeXml="true"/>" onfocus="if(this.value=='类别名称'){this.value=''}" onblur="if(this.value==''){this.value='类别名称'}" /></p>
					<p><input name="" type="button" onclick="searchSubmit();" value="搜 索" class="sub" /></p>
				</div>
			</fieldset>
			<!--查询.end-->
			<!--数据列表-->
			<div class="main">
				<table width="100%" border="0" id="At_table">
				  <tr>
					<th scope="col" width="5%"><input name="c0" type="checkbox" value="check" onClick="selectAll(this);" /></th>
					<th scope="col" width="25%">资源名称</th>
					<th scope="col" width="25%">资源表</th>
					<th scope="col" width="20%">备注</th>
					<th scope="col" width="25%">操作</th>
				  </tr>
				  <c:forEach items="${page.results }" var="r">
				  	<tr>
						<td><input name="rescIds" type="checkbox" value="${r.id }" /></td>
						<td>${r.name }</td>
						<td>${r.resTable }</td>
						<td><c:out value="${r.remark }" escapeXml="true"/></td>
						<td>
							<a href="${contextPath }/manage/resCategory/edit.rt?id=${r.id}&viewId=${viewId}&leftId=${leftId}">编辑</a><span> -</span>
							<a href="javascript:void(0);" onclick="del(${r.id});">删除</a>
						</td>
					  </tr>
				  </c:forEach>
				</table>
				<div class="page">
					<div class="fl"><input type="button" id="delSelected" value="删除选中资源类别" class="sub2" style="*margin-left:-170px;" /></div>
					<jsp:include page="../common/page.jsp" >
					<jsp:param value="${contextPath}/manage/resCategory/list.rt" name="pageUrl"/>
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

