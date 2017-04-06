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
			$("#searchName").val('视频名称');
		}
		$("#delSelected").click(function(){
			var arrayId = new Array();
			$("input[name='videoIds']:checked").each(function(){
				arrayId.push($(this).val());
			});
			if(arrayId.length > 0){
				if(confirm("确定删除？")){
					$("#searchForm").attr("action","${contextPath}/manage/video/delSelected.rt");
					$("#searchForm").submit();
				}
			} else{
				 $.scojs_message('请至少选择一行数据！', $.scojs_message.TYPE_ERROR);
			}
		});
		loadTeam(null,[${teamId}]);
	});
function checkState(state, id){
	
	var stateText;
	var transcoding = false;
	switch(state){
	case 0:
		stateText = "未转码";
		break;
	case 1:
		stateText = "等待转码";
		doPostQueryState(id);
		break;
	case 2:
		stateText = "转码中";
		transcoding = true;
		doPostQueryState(id);
		break;
	case 3:
		stateText = "已完成";
		break;
	case 4:
		stateText = "转码异常";
		break;
	}
	if(!transcoding){
		$("#codeState"+id).html(stateText);
	}
}

function doPostQueryState(id){
	var url = "${contextPath}/manage/video/getTranscodeState.rt?video.id="+id;
	$.post(url,function(data){
		//进度表示：style="width: 60%;"
		if(data.percent !=null && data.percent !=""){
			var per = parseInt(data.percent*100)+"%";
			// 添加到div层
			$("#codeState"+id).html(per);
		} else{
			$("#codeState"+id).html("已完成");
		}
		setTimeout(checkState(data.state, id), 500);
	},"json");
}
function del(id){
	if(confirm("确定删除？")){
		$("#searchForm").attr("action","${contextPath}/manage/video/delete.rt?id="+id);
		$("#searchForm").submit();
	}
}

function upOrDownVideo(id){
	$("#searchForm").attr("action","${contextPath}/manage/video/upOrDown.rt?id="+id);
	$("#searchForm").submit();
}

function top1(id){
	$("#searchForm").attr("action","${contextPath}/manage/video/top.rt?id="+id);
	$("#searchForm").submit();
}
function down(id){
	$("#searchForm").attr("action","${contextPath}/manage/video/down.rt?id="+id);
	$("#searchForm").submit();
}
function edit(id){
	$("#searchForm").attr("action","${contextPath }/manage/video/edit.rt?id="+id);
	$("#searchForm").submit();
}

function searchSelect(){
	$("#searchForm").attr("action","${contextPath}/manage/video/list.rt");
	$("#searchForm").submit();
}

function move(id, move){
	$("#searchForm").attr("action","${contextPath}/manage/video/move.rt?id="+id+"&move="+move);
	$("#searchForm").submit();
}

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
			<div class="buts">
				<a href="${contextPath}/manage/video/add.rt?viewId=${viewId}&leftId=${leftId}">添加视频</a>
			</div>
			<!--查询-->
			<form name="searchForm" id="searchForm" action="${contextPath}/manage/video/list.rt" method="post">
			<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			<input type="hidden" name="viewId" value="${viewId }" />
			<input type="hidden" name="leftId" value="${leftId }" />
			<fieldset class="search" id="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
					<p class="fl">团体：</p>
					<p class="fl"><u id="teames" class="mr15"></u></p>
					<p class="fl">所属栏目：</p>
					<p class="fl"><select name="columnId" id="columnId" class="mr15" onchange="searchSelect();">
						<option value="">请选择</option>
						<c:forEach items="${columnes }" var="col">
						<option<c:if test="${col.id==columnId }"> selected="selected"</c:if> value="${col.id }">${col.name }</option>
						</c:forEach>
					</select></p>
					<p class="fl">审核状态：</p>
					<p class="fl"><select name="status" id="status" class="mr15" onchange="searchSelect();">
						<option value="">请选择</option>
						<option<c:if test="${status==0 }"> selected="selected"</c:if> value="0">审核通过</option>
						<option<c:if test="${status==1 }"> selected="selected"</c:if> value="1">审核中</option>
						<option<c:if test="${status==2 }"> selected="selected"</c:if> value="2">审核失败</option>
					</select></p>
					<p class="fl">视频名称：</p>
					<p class="fl"><input name="searchName" id="searchName" type="text" class="text mr15" value="<c:out value="${searchName }" escapeXml="true"/>" onfocus="if(this.value=='视频名称'){this.value=''}" onblur="if(this.value==''){this.value='视频名称'}" /></p>
					<p class=""><input name="" type="button" onclick="searchSubmit();" value="搜 索" class="sub" /></p>
				</div>
			</fieldset>
			<!--查询.end-->
			<!--数据列表-->
			<div class="main">
				<table width="100%" border="0" id="At_table">
				  <tr>
					<th scope="col" width="5%"><input name="c0" type="checkbox" value="check" onclick="selectAll(this)" /></th>
					<th scope="col" width="20%">视频名称</th>
					<th scope="col" width="10%">视频类别</th>
					<th scope="col" width="13%">转码状态</th>
					<th scope="col" width="10%">审核状态</th>
					<th scope="col" width="12%">发布状态</th>
					<th scope="col" width="10%">创建时间</th>
					<th scope="col" width="20%">操作</th>
				  </tr>
				  <c:forEach items="${page.results }" var="v">
				  	<tr>
						<td><input name="videoIds" type="checkbox" value="${v.id }" /></td>
						<td><c:out value="${v.videoTitle }" escapeXml="true"/> <c:if test="${v.sortTime!=null }"><img src="${contextPath}/images/top.png" width="14" /></c:if></td>
						<td>${v.resource }</td>
						<td><span id="codeState${v.id }" style="display: block;"></span>
							<script type="text/javascript">checkState(${v.transcodeState }, ${v.id});</script>
						</td>
						<td>
							<c:if test="${v.status==0 }">审核通过</c:if>
							<c:if test="${v.status==1 }">审核中</c:if>
							<c:if test="${v.status==2 }">审核失败</c:if>
						</td>
						<td>
							<c:if test="${v.releaseStauts==0 }">发布</c:if>
							<c:if test="${v.releaseStauts!=0 }">未发布</c:if>
						</td>
						<td><fmt:formatDate value="${v.uploadTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td>
						
							<c:if test="${v.status==0 }">
							<c:if test="${v.releaseStauts==0 }">
								<a href="javascript:void(0);" onclick="upOrDownVideo(${v.id});"><span class="no">下架</span></a>
							</c:if>
							<c:if test="${v.releaseStauts==0 }">
								<c:if test="${v.sortTime==null }">
								<a href="javascript:void(0);" onclick="top1(${v.id});"><span style="color:#FF9933;">置顶</span></a>
								</c:if>
								<c:if test="${v.sortTime!=null }">
									<a href="javascript:void(0);" onclick="down(${v.id});"><span style="color:#FF9933;">取消置顶</span></a>
								</c:if>
							</c:if>
							
							
							<c:if test="${v.releaseStauts==1 }">
								<a href="javascript:void(0);" onclick="upOrDownVideo(${v.id});"><span class="ok">上架</span></a>
							</c:if>
							</c:if>
							<c:if test="${v.status==1 }">
								<a href="javascript:void(0);" onclick="edit(${v.id});">编辑</a>
							</c:if>
							<c:if test="${v.releaseStauts==1 }">
								<a href="javascript:void(0);" onclick="edit(${v.id});">编辑</a>
							</c:if>
							<c:if test="${v.releaseStauts==1 }">
							<a href="javascript:void(0);" onclick="del(${v.id});">删除</a>
							</c:if>
							<c:if test="${v.status==1 ||v.status==2 }">
								<a href="javascript:void(0);" onclick="del(${v.id});">删除</a>
							</c:if>
							<c:if test="${v.path ==null || v.path == '' }">
							<a href="${contextPath}/manage/video/upload1.rt?id=${v.id }&viewId=${viewId}&leftId=${leftId}">上传</a>
							</c:if>
							<a href="javascript:void(0);" onclick="move(${v.id},1);"><span style="color:#00CD00;">上移</span></a>
							<a href="javascript:void(0);" onclick="move(${v.id},-1);"><span style="color:#00CD00;">下移</span></a>
						</td>
					  </tr>
				  </c:forEach>
				</table>
				<div class="page">
					<jsp:include page="../common/page.jsp" >
					<jsp:param value="${contextPath}/manage/video/list.rt" name="pageUrl"/>
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

