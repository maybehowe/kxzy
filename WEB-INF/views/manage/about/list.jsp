<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科协资源</title>
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<link href="${contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
//搜索
function searchSubmit(){
	var searchName = $("#searchName").val();
	if(searchName=='输入搜索的关键词'){
		$("#searchName").val('');
	}
	$("#curPage").val(1);
	$("#searchForm").submit();
}
//编辑
function edit(id){
	$("#searchForm").attr("action","${contextPath }/manage/about/showEdit.rt?aboutId="+id);
	$("#searchForm").submit();
}
//删除
function del(aboutId){
	if(confirm("确定删除？")){
			var url = "${contextPath }/manage/about/delete.rt";
			var params = {
				"ids" : aboutId,
			};
			$.post(url,params,function(result) {
				if (result.flag) {
					 $("#searchForm").attr("action","${contextPath }/manage/about/list.rt");
					 $("#searchForm").submit();
				} else {
					alert("该关于下存在内容，无法删除！");
				}
			});
		}else{
			return false;
		}
}
//详情
function detail(id){
	$("#searchForm").attr("action","${contextPath }/manage/about/showDetail.rt?aboutId="+id);
	$("#searchForm").submit();
}
</script>
</head>
<body>
<div class="wrapper">
	<jsp:include page="/WEB-INF/views/manage/common/head.jsp" />
	<div class="content">
		<jsp:include page="/WEB-INF/views/manage/common/left.jsp" />
		<div class="right">
			<div class="buts">
				<a href="${contextPath}/manage/about/showAdd.rt?viewId=${viewId}&leftId=${leftId}">添加关于</a>
			</div>
			<form name="searchForm" id="searchForm" action="${contextPath}/manage/about/list.rt" method="post">
			<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			<input type="hidden" name="viewId" id="viewId" value="${viewId }"/>
			<input type="hidden" name="leftId" id="leftId" value="${leftId }"/>
			<fieldset class="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
					<input name="searchName" id="searchName" type="text" class="text" value="关于标题" onfocus="if(this.value=='关于标题'){this.value='关于标题'}" onblur="if(this.value==''){this.value='关于标题'}" />
					<input type="submit" value="搜 索" class="sub" onclick="searchSubmit()"/>
				</div>
			</fieldset>
			<div class="main">
				<table width="100%" border="0" id="At_table">
				  <tr>
					<th scope="col" width="5%"></th>
					<th scope="col" width="10%">关于标题</th>
					<th scope="col" width="25%">关于内容</th>
					<th scope="col" width="10%">创建时间</th>
					<th scope="col" width="20%">操作</th>
				  </tr>
				  <c:forEach items="${page.results}" var="about">
				  	 <tr>
						<td></td>
						<td>${about.aboutName}</td>
						<td>
						<c:choose>
						   <c:when test="${fn:length(about.content) > 20}">
						       ${fn:substring(about.content,0,10)} ........
						       ${fn:substring(about.content, fn:length(about.content)-10,-1)}
						   </c:when> 
						   <c:otherwise>
						       ${about.content}
						   </c:otherwise>
						</c:choose>
						</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${about.createTime }" /></td>
						<td>
							<a href="javascript:void(0);" onclick="edit(${about.id});">编辑</a><span> -</span>
							<a href="javascript:void(0);" onclick="detail(${about.id});">详情</a><span> -</span>
							<a href="javascript:void(0);" onclick="del(${about.id});">删除</a>
						</td>
					  </tr>
				  </c:forEach>
				</table>
			</div>
			</form>
			<!--数据列表.end-->
		</div>
		<div class="cb"></div>
	</div>
</div>
<script src="${contextPath}/js/checkbox.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	var Ptr=document.getElementById("At_table").getElementsByTagName("tr");
    for (i=1;i<Ptr.length+1;i++) { 
    	Ptr[i-1].className = (i%2>0)?"t1":"t2"; 
    }
</script>
</body>
</html>
