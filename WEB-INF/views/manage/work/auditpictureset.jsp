<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roots.kxzy.system.common.constant.JudgeStatus"%>
<%
	request.setAttribute("yes",JudgeStatus.YES);
	request.setAttribute("no",JudgeStatus.NO);
%>
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
  //搜索
 function searchSubmit(){
	var searchName = $("#searchName").val();
	if(searchName=='输入搜索的关键词'){
		$("#searchName").val('');
	}
	$("#curPage").val(1);
	$("#searchForm").submit();
 }
 
  //详情
 function auditDetail(id){
  	$("#searchForm").attr("action","${contextPath }/manage/work/auditPictureSetDetail.rt?picturesetId="+id);
    $("#searchForm").submit();
 }
    
</script>
</head>
<body>
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp" />
		<div class="right">
			<form name="searchForm" id="searchForm" action="${contextPath}/manage/work/auditPictureSetList.rt" method="post">
			<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			<input type="hidden" name="viewId" id="viewId" value="${viewId }"/>
			<input type="hidden" name="leftId" id="leftId" value="${leftId }"/>
			<fieldset class="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
					<p class="fl">图集名称：</p>
					<p class="fl mr15"><input name="searchName" id="searchName"  type="text" class="text" value="${rt:escapeHtml(searchName)}"/></p>
					<p><input type="submit" value="搜 索" class="sub" onclick="searchSubmit()" /></p>
				</div>
			</fieldset>
			<div class="main">
				<table width="100%" border="0" id="At_table">
				  <tr>
					<th scope="col" width="15%">图集名称</th>
					<th scope="col" width="10%">封面图</th>
					<th scope="col" width="15%">类别</th>
					<th scope="col" width="10%">学科分类</th>
					<th scope="col" width="10%">审核状态</th>
					<th scope="col" width="15%">创建时间</th>
					<th scope="col" width="10%">操作</th>
				  </tr>
				  <c:forEach items="${page.results}" var="pictureset">
				  	 <tr>
						<td>${rt:escapeHtml(pictureset.name)}</td>
						<td>
						  <img src="${contextPath}/manage/picture/thumbnail.rt?picId=${pictureset.isCover}&size=128" alt="...">
						</td>
						<td>						   
						   <c:forEach items="${channelMap}" var="cm" >
						      <c:if test="${pictureset.channelId eq cm.key}">
						         ${cm.value.parent.name}-${cm.value.name}
						      </c:if>
						   </c:forEach>
						</td>
						<td>
						   <c:forEach items="${subjectMap}" var="sm" >
						      ${pictureset.disciplineCateId eq sm.key ? sm.value : ''}
						   </c:forEach>
						</td>
						<td><c:if test="${pictureset.status==1 }">待审核</c:if></td>
						<td><fmt:formatDate value="${pictureset.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td>
						    <a href="javascript:void(0);" onclick="auditDetail(${pictureset.id});">审核</a>
						</td>
					  </tr>
				  </c:forEach>
				</table>
				<div class="page">
					<jsp:include page="/WEB-INF/views/manage/common/page.jsp" >
					<jsp:param value="${contextPath}/manage/work/auditPictureSetList.rt" name="pageUrl"/>
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

