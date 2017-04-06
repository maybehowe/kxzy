<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roots.kxzy.system.common.constant.JudgeStatus"%>
<%@page import="com.roots.kxzy.system.common.constant.SysEnum"%>
<%
	request.setAttribute("yes",JudgeStatus.YES);
	request.setAttribute("no",JudgeStatus.NO);
	request.setAttribute("auditsuccess",SysEnum.AuditStauts.AuditSuccess.getValue());
	request.setAttribute("audit",SysEnum.AuditStauts.Audit.getValue());
	request.setAttribute("auditfail",SysEnum.AuditStauts.Auditfail.getValue());
	request.setAttribute("down",SysEnum.ReleaseStauts.down.getValue());
	request.setAttribute("up",SysEnum.ReleaseStauts.up.getValue());
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
$(function(){
	loadChannel(null,[${channelId}]);
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
   
   function addPictureset(){
   	   $("#searchForm").attr("action","${contextPath }/manage/pictureset/showAdd.rt");
   	   $("#searchForm").submit();
   }
   
    //查看图片
   function addPicture(id){
	   /*var psParams = "viewId="+encodeURIComponent(${viewId})+"&leftId="+encodeURIComponent(${leftId})
       + "&pscurPage="+encodeURIComponent(${curPage})+"&pspageSize="+encodeURIComponent(${pageSize})
       + "&pssearchName="+encodeURIComponent("${searchName}")+"&pschannelId="+encodeURIComponent("${channelId}");*/
       
    	var psParams = "viewId=${viewId}&leftId=${leftId}";
    	     psParams += "&pscurPage=${curPage}&pageSize=${pageSize}";
    	     psParams += "&searchName=${searchName}&channelId=${channelId}";
    	var url = "${contextPath }/manage/picture/list.rt?picturesetId="+id+"&viewId=${viewId}&leftId=${leftId}"+"&psParams="+encodeURIComponent(psParams);
    	window.location.href = url;
   }
   
    //编辑
   function edit(id){
   	   $("#searchForm").attr("action","${contextPath }/manage/pictureset/showEdit.rt?picturesetId="+id);
   	   $("#searchForm").submit();
   }
   //删除
   function del(picturesetId){
   	if(confirm("确定删除？")){
   			var url = "${contextPath }/manage/pictureset/delete.rt";
   			var params = {
   				"picturesetId" : picturesetId,
   			};
   			$.post(url,params,function(result) {
   				if (result.flag) {
					 $.scojs_message('删除成功',{
						 "type":$.scojs_message.TYPE_OK,
						 "delay":1000,
						 "onAfterHidden" : function(){
			   				 $("#searchForm").attr("action","${contextPath }/manage/pictureset/list.rt");
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
    	$("#searchForm").attr("action","${contextPath}/manage/pictureset/showDetail.rt?picturesetId="+id);
   	    $("#searchForm").submit();
   }
   
    //上下架
   function upOrDownPictureset(id){
		$("#searchForm").attr("action","${contextPath}/manage/pictureset/upOrDownPictureset.rt?picturesetId="+id);
		$("#searchForm").submit();
	}
    
    //主页置顶
   function homeTop(id,homeTop){
       var validateUrl = "${contextPath }/manage/pictureset/validateHomeTop.rt";
	   var params = {
			"picturesetId" : id,
			"homeTop" : homeTop
		};
		$.post(validateUrl,params,function(result){
			if(result.flag == 1){
				 $("#searchForm").attr("action","${contextPath }/manage/pictureset/setHomeTop.rt?picturesetId="+id+"&homeTop="+homeTop);
				 $("#searchForm").submit();
			}
			if(result.flag == 0){
				$.scojs_message( result.message, $.scojs_message.TYPE_ERROR);
			}
			if(result.flag == 2){
				$.scojs_message(result.message,{
					 "type":$.scojs_message.TYPE_ERROR,
					 "delay":1000,
					 "onAfterHidden" : function(){
					   	   $("#searchForm").attr("action","${contextPath}/manage/picture/list.rt?picturesetId="+id);
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
						   	   $("#searchForm").attr("action","${contextPath}/manage/picture/showCrop.rt?picId="+result.pictureId);
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
    //栏目置顶
   function channelTop(id,channelTop){
	   var validateUrl = "${contextPath }/manage/pictureset/validateChannelTop.rt";
	   var topUrl = "${contextPath}/manage/pictureset/setChannelTop.rt";
	   var params = {
			"picturesetId" : id,
			"channelTop" : channelTop
		};
	   $.post(validateUrl,params,function(result){
		   if(result.flag == 1){
				 $("#searchForm").attr("action","${contextPath }/manage/pictureset/setChannelTop.rt?picturesetId="+id+"&channelTop="+channelTop);
				 $("#searchForm").submit();
		   }
		  if(result.flag == 0){
				$.scojs_message( result.message, $.scojs_message.TYPE_ERROR);
			}
		  if(result.flag == 2){
				$.scojs_message(result.message,{
					 "type":$.scojs_message.TYPE_ERROR,
					 "delay":1000,
					 "onAfterHidden" : function(){
					   	   $("#searchForm").attr("action","${contextPath}/manage/picture/list.rt?picturesetId="+id);
					   	   $("#searchForm").submit();
					 }
				 });
			}
			if(result.flag == 3){
				 bootbox.dialog({
					message : result.message,
					title : "栏目置顶",
					buttons : {
						success : {
							label : "是",
							callback : function() {
						   	   $("#searchForm").attr("action","${contextPath}/manage/picture/showChannelCrop.rt?picId="+result.pictureId);
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
    
   function loadChannel(obj,nextPath){
		$(obj).nextAll().remove();
		var id;
		if(obj == null){
			id = 28;
		} else {
			id = $(obj).val();
		}
		$.ajax({
		   type: "POST",
		   url: "${contextPath}/manage/pictureset/loadChannel.rt?parentId="+id,
		   success: function(json){
			   if(json != null && json != ''){
				    var html='';
			     	html +='<select name="channelId" onchange="loadChannel(this);">';
			     	html +='<option value="">--请选择--</option>';
			     	$(json).each(function(i,item){
			    		 html +='<option value="'+item.id+'">'+item.name+'</option>';
			     	});
			     	html +='</select>';
			     	var newSelect = $(html);
			     	newSelect.appendTo("#channels");
			    	if(nextPath && nextPath.length > 0){
			    		$(newSelect).find("option[value="+ nextPath[0] +"]").attr("selected","selected");
			    		if(nextPath.length>1){
			    			loadChannel(newSelect,nextPath.slice(1,nextPath.length));
			    		}
			    	}
			   }
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
				<a href="javascript:void(0);" onclick="addPictureset()">添加图集</a>
			</div>
			<form name="searchForm" id="searchForm" action="${contextPath}/manage/pictureset/list.rt" method="post">
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
					<th scope="col" width="15%">图集名称</th>
					<th scope="col" width="10%">封面图</th>
					<th scope="col" width="15%">分类</th>
					<th scope="col" width="10%">学科分类</th>
					<th scope="col" width="10%">审核状态</th>
					<th scope="col" width="10%">发布状态</th>
					<th scope="col" width="20%">操作</th>
				  </tr>
				  <c:forEach items="${page.results}" var="pictureset">
				  	 <tr>
						<td>
						  ${rt:escapeHtml(pictureset.name)}
						  <c:if test="${pictureset.homeTop != null || pictureset.channelTop != null}">
						    <img src="${contextPath}/images/top.png" width="14" />
						  </c:if>
						</td>
						<td>
						  <c:if test="${not empty pictureset.isCover}">
						    <img src="${contextPath}/manage/picture/thumbnail.rt?picId=${pictureset.isCover}&size=128" alt="...">
						  </c:if>
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
						<td>
						    <c:if test="${pictureset.status== auditsuccess }">审核通过</c:if>
							<c:if test="${pictureset.status== audit }">审核中</c:if>
							<c:if test="${pictureset.status== auditfail }">审核失败</c:if>
						</td>
						<td>${pictureset.releaseStauts eq up ? '发布' : '未发布'}</td>
						<td>
							<c:if test="${pictureset.status eq auditsuccess}">
							  <c:if test="${pictureset.releaseStauts eq up}">
							     <a href="javascript:void(0);" onclick="upOrDownPictureset(${pictureset.id});"><span class="no">下架</span></a><span> -</span>
							  </c:if>
							   <c:if test="${pictureset.releaseStauts eq up}">
							      <c:choose>
								  <c:when test="${pictureset.homeTop == null}">
								     <a href="javascript:void(0);" onclick="homeTop(${pictureset.id},${yes});"><span style="color:#FF9933;">主页置顶</span></a><span> -</span>
								  </c:when>
	 							  <c:when test="${pictureset.homeTop != null}">
								     <a href="javascript:void(0);" onclick="homeTop(${pictureset.id},${no});"><span style="color:#FF9933;">取消主页置顶</span></a><span> -</span>
								  </c:when>
								</c:choose>
					        	<c:choose>
								  <c:when test="${pictureset.channelTop == null}">
								     <a href="javascript:void(0);" onclick="channelTop(${pictureset.id},${yes});"><span style="color:#FF9933;">栏目置顶</span></a><span> -</span>
								  </c:when>
	 							  <c:when test="${pictureset.channelTop != null}">
								     <a href="javascript:void(0);" onclick="channelTop(${pictureset.id},${no});"><span style="color:#FF9933;">取消栏目置顶</span></a><span> -</span>
								  </c:when>
							     </c:choose>
							   </c:if>
   							   <c:if test="${pictureset.releaseStauts eq down}">
							     <a href="javascript:void(0);" onclick="upOrDownPictureset(${pictureset.id});"><span class="ok">上架</span></a><span> -</span>
							   </c:if>
							</c:if>
							<c:if test="${pictureset.status eq audit}">
							   <a href="javascript:void(0);" onclick="addPicture(${pictureset.id});">管理</a><span> -</span>
							   <a href="javascript:void(0);" onclick="edit(${pictureset.id});">编辑</a><span> -</span>
							</c:if>
					    	<c:if test="${pictureset.releaseStauts eq down}">
							   <a href="javascript:void(0);" onclick="addPicture(${pictureset.id});">管理</a><span> -</span>
							   <a href="javascript:void(0);" onclick="edit(${pictureset.id});">编辑</a><span> -</span>
							   <a href="javascript:void(0);" onclick="del(${pictureset.id});">删除</a><span> -</span>
							</c:if>
							<c:if test="${pictureset.status eq audit || pictureset.status eq auditfail}">
							  <a href="javascript:void(0);" onclick="del(${pictureset.id});">删除</a><span> -</span>
							</c:if>
							<a href="javascript:void(0);" onclick="detail(${pictureset.id});">详情</a>
						</td>
					  </tr>
				  </c:forEach>
				</table>
				<div class="page">
					<jsp:include page="/WEB-INF/views/manage/common/page.jsp" >
					<jsp:param value="${contextPath}/manage/pictureset/list.rt" name="pageUrl"/>
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

