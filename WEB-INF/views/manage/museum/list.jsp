<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roots.kxzy.system.common.constant.JudgeStatus"%>
<%@page import="com.roots.kxzy.system.common.constant.SysEnum"%>
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
<link  href="${contextPath}/bootstrap.sco/css/bootstrap.min.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="${contextPath}/bootstrap.sco/js/bootbox.min.js"></script>
<script type="text/javascript" src="${contextPath}/bootstrap.sco/js/bootstrap.min.js"></script>
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
   
   function addPictureset(){
   	   $("#searchForm").attr("action","${contextPath }/manage/museum/showAdd.rt");
   	   $("#searchForm").submit();
   }
   
    //编辑
   function edit(id){
   	   $("#searchForm").attr("action","${contextPath }/manage/museum/showEdit.rt?museumId="+id);
   	   $("#searchForm").submit();
   }
   //删除
   function del(picturesetId){
   	if(confirm("确定删除？")){
   			var url = "${contextPath }/manage/museum/delete.rt";
   			var params = {
   				"picturesetId" : picturesetId,
   			};
   			$.post(url,params,function(result) {
   				if (result.flag) {
					 $.scojs_message('删除成功',{
						 "type":$.scojs_message.TYPE_OK,
						 "delay":1000,
						 "onAfterHidden" : function(){
			   				 $("#searchForm").attr("action","${contextPath }/manage/museum/list.rt");
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
   }
    //详情
	function detail(id){
		$("#searchForm").attr("action","${contextPath}/manage/museum/showDetail.rt?museumId="+id);
		$("#searchForm").submit();
   }
   
    //上下架
	function upOrDownPictureset(id){
		$("#searchForm").attr("action","${contextPath}/manage/museum/upOrDownPictureset.rt?museumId="+id);
		$("#searchForm").submit();
	}
    
	function goPicturesManage(museumId) {
    	var psParams = "viewId=${viewId}&leftId=${leftId}";
	    psParams += "&pscurPage=${curPage}&pageSize=${pageSize}";
	    psParams += "&searchName=${searchName}&channelId=${channelId}";
	    var url = "${contextPath }/manage/museum/picture/list.rt?picturesetId="+museumId+"&viewId=${viewId}&leftId=${leftId}"+"&psParams="+encodeURIComponent(psParams);
	    window.location.href = url;

	}
	
	function goVideoManage(museumId) { 
	   	   $("#searchForm").attr("action","${contextPath }/manage/museum/showAddVideo.rt?picturesetId="+museumId);
	   	   $("#searchForm").submit();
	}
	
    //主页置顶
	   function homeTop(id,homeTop){
	       var validateUrl = "${contextPath }/manage/museum/validateHomeTop.rt";
		   var params = {
				"picturesetId" : id,
				"homeTop" : homeTop
			};
			$.post(validateUrl,params,function(result){
				if(result.flag == 1){
					 $("#searchForm").attr("action","${contextPath }/manage/museum/setHomeTop.rt?picturesetId="+id+"&homeTop="+homeTop);
					 $("#searchForm").submit();
				}
				if(result.flag == 2){
					$.scojs_message(result.message,{
						 "type":$.scojs_message.TYPE_ERROR,
						 "delay":1000,
						 "onAfterHidden" : function(){
						   	   $("#searchForm").attr("action","${contextPath}/manage/museum/picture/list.rt?picturesetId="+id);
						   	   $("#searchForm").submit();
						 }
					 });
				}
				if(result.flag == 3){
					 bootbox.dialog({
						message : result.message,
						title : "主页置顶",
						buttons : {
							success : {
								label : "是",
								callback : function() {
							   	   $("#searchForm").attr("action","${contextPath}/manage/museum/picture/showCrop.rt?picId="+result.pictureId);
							   	   $("#searchForm").submit();
								}
							},
							danger : {
								label : "否",
								className : "green"
							}
						}
					});
				}
			});

	   }
</script>
</head>
<body>
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp" />
		<div class="right">
			<div class="buts">
				<a href="javascript:void(0);" onclick="addPictureset()">添加场馆</a>
			</div>
			<form name="searchForm" id="searchForm" action="${contextPath}/manage/museum/list.rt" method="post">
			<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			<input type="hidden" name="viewId" id="viewId" value="${viewId }"/>
			<input type="hidden" name="leftId" id="leftId" value="${leftId }"/>
			<fieldset class="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
					<p class="fl">图集名称：</p>
					<p class="fl mr15"><input name="searchName" id="searchName"  type="text" class="text" value="${rt:escapeHtml(searchName)}"/></p>
					<p class="fl">分类：</p>
					<u id="channels" class="mr15 fl"></u>
					<p><input type="submit" value="搜 索" class="sub" onclick="searchSubmit()" /></p>
				</div>
			</fieldset>
			<div class="main">
				<table width="100%" border="0" id="At_table">
				  <tr>
					<th scope="col" width="15%">场馆名称</th>
					<th scope="col" width="10%">分类</th>
					<th scope="col" width="15%">封面图</th>
					<th scope="col" width="15%">视频名称</th>
					<th scope="col" width="10%">创建时间</th>
					<th scope="col" width="35%">操作</th>
				  </tr>
				  <c:forEach items="${page.results}" var="museum">
				  	 <tr>
						<td>
						  ${rt:escapeHtml(museum.name)}
						  <c:if test="${museum.homeTop != null}">
						    <img src="${contextPath}/images/top.png" width="14" />
						  </c:if>
						</td>
						<td>						   
						   ${museum.type eq 1 ? '省内' : '国内' }
						</td>
						<td>
						  <c:if test="${not empty museum.isCover}">
						    <img src="${contextPath}/manage/museum/picture/thumbnail.rt?picId=${museum.isCover}&size=128" alt="...">
						  </c:if>
						</td>
						<td>
						  ${rt:escapeHtml(museum.videoName)}
						</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${museum.createTime }" /></td>
						<td>
						   <c:choose>
							 <c:when test="${museum.homeTop == null}">
							    <a href="javascript:void(0);" onclick="homeTop(${museum.id},${yes});"><span style="color:#FF9933;">主页置顶</span></a><span> -</span>
							 </c:when>
								<c:when test="${museum.homeTop != null}">
							    <a href="javascript:void(0);" onclick="homeTop(${museum.id},${no});"><span style="color:#FF9933;">取消主页置顶</span></a><span> -</span>
						     </c:when>
						    </c:choose>
							<a href="javascript:void(0);" onclick="goPicturesManage(${museum.id})">图片管理</a><span> -</span>
							<a href="javascript:void(0);" onclick="goVideoManage(${museum.id})">视频管理</a><span> -</span>
							<a href="javascript:void(0);" onclick="edit(${museum.id});">编辑</a><span> -</span>
							<a href="javascript:void(0);" onclick="del(${museum.id});">删除</a><span> -</span>
							<a href="javascript:void(0);" onclick="detail(${museum.id});">详情</a>
						</td>
					  </tr>
				  </c:forEach>
				</table>
				<div class="page">
					<jsp:include page="/WEB-INF/views/manage/common/page.jsp" >
					<jsp:param value="${contextPath}/manage/museum//list.rt" name="pageUrl"/>
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

