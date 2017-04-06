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
	loadTeam(null,[${teamId}]);
});
function loadTeam(obj,nextPath){
	$(obj).nextAll().remove();
	var id;
	if(obj == null){
		id = 0;
	} else {
		id = $(obj).val();
	}
	$.ajax({
	   type: "POST",
	   url: "${contextPath}/manage/team/loadTeam.rt?parentId="+id,
	   success: function(json){
		   if(json != null && json != ''){
			    var html='';
		     	html +='<select name="teamId" onchange="loadTeam(this);">';
		     	html +='<option value="">请选择</option>';
		     	$(json).each(function(i,item){
		    		 html +='<option value="'+item.id+'">'+item.teamName+'</option>';
		     	});
		     	html +='</select>';
		     	var newSelect = $(html);
		     	newSelect.appendTo("#teames");
		    	if(nextPath && nextPath.length > 0){
		    		$(newSelect).find("option[value="+ nextPath[0] +"]").attr("selected","selected");
		    		if(nextPath.length>1){
		    			loadTeam(newSelect,nextPath.slice(1,nextPath.length))
		    		}
		    	}
		   }
	   }
	});
}
function searchSubmit(){
	$("#curPage").val(1);
	$("#searchForm").submit();
}
/*]]>*/
</script>
<style>
#teames select{ margin-right:5px;}
</style>
</head>
<body>
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp" />
		<div class="right">
			<!--查询-->
			<form name="searchForm" id="searchForm" action="${contextPath}/manage/statistics/list2.rt" method="post">
			<input type="hidden" name="viewId" value="${viewId }" />
			<input type="hidden" name="leftId" value="${leftId }" />
			<fieldset class="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
				科普团体:
				<u id="teames"></u>
				<input name="" type="button" onclick="searchSubmit();" value="搜 索" class="sub" />
				</div>
			</fieldset>
			<!--查询.end-->
			<!--数据列表-->
			<div class="main">
				<table width="100%" border="0" id="At_table">
				  <tr>
					<th scope="col" width="7%">序号</th>
					<c:if test="${teamId!=null && teamId!='' }">
					<th scope="col" width="21%">用户名</th>
					</c:if>
					<th scope="col" width="21%">所属团体</th>
					<th scope="col" width="11%">上传量</th>
				  </tr>
				  <c:forEach items="${list }" var="u" varStatus="index">
				  	<tr>
						<td>${index.index+1 }</td>
						<c:if test="${teamId!=null && teamId!=''  }">
						<td>${u[0] }</td>
						</c:if>
						<td>${u[1] }</td>
						<td>${u[2]==null?0:u[2] }</td>
					  </tr>
				  </c:forEach>
				</table>
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

