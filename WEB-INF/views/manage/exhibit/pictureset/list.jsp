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
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
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
   	   $("#searchForm").attr("action","${contextPath }/manage/exhibit/pictureset/showAdd.rt");
   	   $("#searchForm").submit();
   }
   
    //查看图片
   function addPicture(id){
    	var psParams = "viewId=${viewId}&leftId=${leftId}";
    	     psParams += "&pscurPage=${curPage}&pageSize=${pageSize}";
    	     psParams += "&searchName=${searchName}&channelId=${channelId}";
    	var url = "${contextPath }/manage/exhibit/picture/list.rt?picturesetId="+id+"&viewId=${viewId}&leftId=${leftId}"+"&psParams="+encodeURIComponent(psParams);
    	window.location.href = url;
   }
   
    //编辑
   function edit(id){
   	   $("#searchForm").attr("action","${contextPath }/manage/exhibit/pictureset/showEdit.rt?picturesetId="+id);
   	   $("#searchForm").submit();
   }
   //删除
   function del(picturesetId){
   	if(confirm("确定删除？")){
   			var url = "${contextPath }/manage/exhibit/pictureset/delete.rt";
   			var params = {
   				"picturesetId" : picturesetId,
   			};
   			$.post(url,params,function(result) {
   				if (result.flag) {
					 $.scojs_message('删除成功',{
						 "type":$.scojs_message.TYPE_OK,
						 "delay":1000,
						 "onAfterHidden" : function(){
			   				 $("#searchForm").attr("action","${contextPath }/manage/exhibit/pictureset/list.rt");
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
    	$("#searchForm").attr("action","${contextPath}/manage/exhibit/pictureset/showDetail.rt?picturesetId="+id);
   	    $("#searchForm").submit();
   }
   
    //主页置顶
   function homeTop(id,homeTop){
       var validateUrl = "${contextPath }/manage/exhibit/pictureset/validateHomeTop.rt";
	   var params = {
			"picturesetId" : id,
			"homeTop" : homeTop
		};
		$.post(validateUrl,params,function(result){
			if(result.flag == 1){
				 $("#searchForm").attr("action","${contextPath }/manage/exhibit/pictureset/setHomeTop.rt?picturesetId="+id+"&homeTop="+homeTop);
				 $("#searchForm").submit();
			}
			if(result.flag == 2){
				$.scojs_message(result.message,{
					 "type":$.scojs_message.TYPE_ERROR,
					 "delay":1000,
					 "onAfterHidden" : function(){
					   	   $("#searchForm").attr("action","${contextPath}/manage/exhibit/picture/list.rt?picturesetId="+id);
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
						   	   $("#searchForm").attr("action","${contextPath}/manage/exhibit/picture/showCrop.rt?picId="+result.pictureId);
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
	<jsp:include page="/WEB-INF/views/manage/common/head.jsp" />
	<div class="content">
		<jsp:include page="/WEB-INF/views/manage/common/left.jsp" />
		<div class="right">
			<div class="buts">
				<a href="javascript:void(0);" onclick="addPictureset()">添加展品图集</a>
			</div>
			<form name="searchForm" id="searchForm" action="${contextPath}/manage/exhibit/pictureset/list.rt" method="post">
			<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			<input type="hidden" name="viewId" id="viewId" value="${viewId }"/>
			<input type="hidden" name="leftId" id="leftId" value="${leftId }"/>
			<fieldset class="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
					<p class="fl">展品图集名称：</p>
					<p class="fl mr15"><input name="searchName" id="searchName"  type="text" class="text" value="${rt:escapeHtml(searchName)}"/></p>
					<p><input type="submit" value="搜 索" class="sub" onclick="searchSubmit()" /></p>
				</div>
			</fieldset>
			<div class="main">
				<table width="100%" border="0" id="At_table">
				  <tr>
					<th scope="col" width="20%">展品图集名称</th>
					<th scope="col" width="10%">分类</th>
					<th scope="col" width="15%">封面图</th>
					<th scope="col" width="15%">创建时间</th>
					<th scope="col" width="30%">操作</th>
				  </tr>
				  <c:forEach items="${page.results}" var="pictureset">
				  	 <tr>
						<td>
						  ${rt:escapeHtml(pictureset.name)}
   						  <c:if test="${pictureset.homeTop != null}">
						    <img src="${contextPath}/images/top.png" width="14" />
						  </c:if>
						</td>
						<td>
						   <c:forEach items="${cateMap}" var="cm" >
						      ${pictureset.cateId eq cm.key ? cm.value : ''}
						   </c:forEach>
						</td>
						<td>
						  <c:if test="${not empty pictureset.isCover}">
						    <img src="${contextPath}/manage/exhibit/picture/thumbnail.rt?picId=${pictureset.isCover}&size=128" alt="...">
						  </c:if>
						</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${pictureset.createTime }" /></td>
						<td>
						   <c:choose>
							 <c:when test="${pictureset.homeTop == null}">
							    <a href="javascript:void(0);" onclick="homeTop(${pictureset.id},${yes});"><span style="color:#FF9933;">主页置顶</span></a><span> -</span>
							 </c:when>
								<c:when test="${pictureset.homeTop != null}">
							    <a href="javascript:void(0);" onclick="homeTop(${pictureset.id},${no});"><span style="color:#FF9933;">取消主页置顶</span></a><span> -</span>
						     </c:when>
						   </c:choose>
						   <a href="javascript:void(0);" onclick="addPicture(${pictureset.id});">图片管理</a><span> -</span>
						   <a href="javascript:void(0);" onclick="edit(${pictureset.id});">编辑</a><span> -</span>
						   <a href="javascript:void(0);" onclick="del(${pictureset.id});">删除</a><span> -</span>
						   <a href="javascript:void(0);" onclick="detail(${pictureset.id});">详情</a>
						</td>
					  </tr>
				  </c:forEach>
				</table>
				<div class="page">
					<jsp:include page="/WEB-INF/views/manage/common/page.jsp" >
					<jsp:param value="${contextPath}/manage/exhibit/pictureset/list.rt" name="pageUrl"/>
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

