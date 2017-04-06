<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科协资源</title>
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<link href="${contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/sco.message.css" type="text/css"></link>
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/scojs.css" type="text/css"></link>
<script type="text/javascript" src="${contextPath}/bootstrap.sco/js/sco.message.js"></script>
<script type="text/javascript">
$(function(){
	//批量删除
	$("#delSelected").click(function(){
		var arrayId = new Array();
		$("input[name='idList']:checked").each(function(){
			arrayId.push($(this).val());
		});
		if(arrayId.length > 0){
			var ids = "";
			for ( var i = 0; i < arrayId.length; i++) {
				ids += arrayId[i] + ",";
			}
			ids = ids.substring(0, ids.length - 1);
			if(confirm("确定删除？")){
				var url = "${contextPath }/manage/education/category/delete.rt";
				var params = {
					"ids" : ids,
				};
				$.post(url,params,function(result) {
					if (result.flag){
						 $.scojs_message('删除成功',{
							 "type":$.scojs_message.TYPE_OK,
							 "delay":1000,
							 "onAfterHidden" : function(){
								 $("#searchForm").attr("action","${contextPath }/manage/education/category/list.rt");
								 $("#searchForm").submit();
							 }
						 });
					} else {
						$.scojs_message('该类别下存在内容', $.scojs_message.TYPE_ERROR);
					}
				});
			}else{
				return false;
			}
		} else{
			$.scojs_message('请至少选择一行数据', $.scojs_message.TYPE_ERROR);
		}
	});
});
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
	$("#searchForm").attr("action","${contextPath }/manage/education/category/showEdit.rt?cateId="+id);
	$("#searchForm").submit();
}
//删除
function del(cateId){
	if(confirm("确定删除？")){
			var url = "${contextPath }/manage/education/category/delete.rt";
			var params = {
				"ids" : cateId,
			};
			$.post(url,params,function(result) {
				if (result.flag) {
					 $.scojs_message('删除成功',{
						 "type":$.scojs_message.TYPE_OK,
						 "delay":1000,
						 "onAfterHidden" : function(){
							 $("#searchForm").attr("action","${contextPath }/manage/education/category/list.rt");
							 $("#searchForm").submit();
						 }
					 });
				} else {
					$.scojs_message('该类别下存在内容', $.scojs_message.TYPE_ERROR);
				}
			});
		}else{
			return false;
		}
}
//详情
function detail(id){
	$("#searchForm").attr("action","${contextPath }/manage/education/category/showDetail.rt?cateId="+id);
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
				<a href="${contextPath}/manage/education/category/showAdd.rt?viewId=${viewId}&leftId=${leftId}">添加教育基地类别</a>
			</div>
			<form name="searchForm" id="searchForm" action="${contextPath}/manage/education/category/list.rt" method="post">
			<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			<input type="hidden" name="viewId" id="viewId" value="${viewId }"/>
			<input type="hidden" name="leftId" id="leftId" value="${leftId }"/>
			<fieldset class="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
					<p class="fl">类别名称：</p>
					<p class="fl mr15"><input name="searchName" id="searchName" type="text" class="text" value="${searchName}"/></p>
					<p><input type="submit" value="搜 索" class="sub" onclick="searchSubmit()"/></p>
				</div>
			</fieldset>
			<div class="main">
				<table width="100%" border="0" id="At_table">
				  <tr>
					<th scope="col" width="5%"><input name="c0" type="checkbox" value="check" onclick="selectAll(this)" /></th>
					<th scope="col" width="25%">类别名称</th>
					<th scope="col" width="20%">类别描述</th>
					<th scope="col" width="20%">创建时间</th>
					<th scope="col" width="30%">操作</th>
				  </tr>
				  <c:forEach items="${page.results}" var="cate">
				  	 <tr>
						<td><input name="idList" id="idList" type="checkbox" value="${cate.id}" /></td>
						<td>${cate.cateName}</td>
						<td>
						<c:choose>
						   <c:when test="${fn:length(cate.description) > 20}">
						       ${fn:substring(cate.description,0,10)} ........
						       ${fn:substring(cate.description, fn:length(cate.description)-10,-1)}
						       </c:when> 
						   <c:otherwise>
						       ${cate.description}
						   </c:otherwise>
						</c:choose>
						</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${cate.createTime }" /></td>
						<td>
							<a href="javascript:void(0);" onclick="edit(${cate.id});">编辑</a><span> -</span>
							<a href="javascript:void(0);" onclick="detail(${cate.id});">详情</a><span> -</span>
							<!-- <a href="javascript:void(0);" onclick="del(${cate.id});">删除</a> -->
						</td>
					  </tr>
				  </c:forEach>
				</table>
				<div class="page">
					<div class="fl"><input type="button" id="delSelected" value="删除选中教育基地类别" class="sub2" style="*margin-left:-170px;" /></div>
					<jsp:include page="/WEB-INF/views/manage/common/page.jsp" >
					<jsp:param value="${contextPath}/manage/education/category/list.rt" name="pageUrl"/>
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
<script src="${contextPath}/js/checkbox.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	var Ptr=document.getElementById("At_table").getElementsByTagName("tr");
    for (i=1;i<Ptr.length+1;i++) { 
    	Ptr[i-1].className = (i%2>0)?"t1":"t2"; 
    }
</script>
</body>
</html>
