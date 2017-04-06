<%@page import="com.roots.kxzy.system.common.constant.SysEnum.AuditStauts"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roots.kxzy.system.common.constant.SysEnum"%>
<%@page import="com.roots.kxzy.system.common.constant.JudgeStatus"%>
<%
	request.setAttribute("yes",JudgeStatus.YES);
	request.setAttribute("no",JudgeStatus.NO);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>科协资源-待审核图集</title>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/sco.message.css" type="text/css"></link>
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/scojs.css" type="text/css"></link>
<script type="text/javascript" src="${contextPath}/bootstrap.sco/js/sco.message.js"></script>
<script type="text/javascript" src="${contextPath}/js/form.js"></script>
<script type="text/javascript">

	//同意
	function agree(picturesetId){
		auditPictureSet(picturesetId,<%=AuditStauts.AuditSuccess.getValue()%>);
	}
	//不同意
	function disagree(picturesetId){
		auditPictureSet(picturesetId,<%=AuditStauts.Auditfail.getValue()%>);
	}
   //审核
   function auditPictureSet(picturesetId,auditStatus){
	    var url = "${contextPath }/manage/work/auditPictureSet.rt";
		var params = {
			"picturesetId" : picturesetId,
			"status":auditStatus
		};
		if(confirm("确定提交吗？")){
			$.post(url,params,function(result) {
				if (result.flag){
					 window.location.href="${contextPath }/manage/work/auditPictureSetList.rt?viewId="+"${viewId}"+"&leftId="+"${leftId}";
				} else {
					 $.scojs_message('操作失败', $.scojs_message.TYPE_ERROR);
				}
			});
		}
   }
   
   //查看图片
   function addPicture(id){
    	window.location.href="${contextPath }/manage/work/atuditPictureList.rt?picturesetId="+id+"&viewId=${viewId}&leftId=${leftId}";
   }
   
</script>
</head>
<body>
<form>
<div class="wrapper">
	<jsp:include page="/WEB-INF/views/manage/common/head.jsp" />
	<div class="content">
		  <jsp:include page="/WEB-INF/views/manage/common/left.jsp"/>
		<div class="right">
			<!--[if lt IE 8]><div class="both"></div><![endif]-->
			<div class="main">
				<div class="tit">待审核图集</div>
				<div class="line">图集详情：</div>
				<table width="96%" border="0" class="data">
				  <tr>
					<th scope="row" width="110">封面图：</th>
					<td><img src="${contextPath}/manage/picture/thumbnail.rt?picId=${pictureset.isCover}&size=176" alt="..."></td>
				  </tr>
				  <tr>
					<th scope="row" width="110">所属分类：</th>
					<td>${channel.parent.name}-${channel.name}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">图集标题：</th>
					<td>${rt:escapeHtml(pictureset.name)}</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">学科名称：</th>
					<td>${subject.name}</td>
				  </tr>
				   <tr>
					<th scope="row" width="110">来源：</th>
					<td>
					   ${pictureset.sourceId eq 1 ? "无" : ""}
					   ${pictureset.sourceId eq 2 ? "原创" : ""}
					   ${pictureset.sourceId eq 3 ? "转载" : ""}
					   ${pictureset.sourceId eq 4 ? "购买版权" : ""}
					</td>
				  </tr>
   				  <tr>
					<th scope="row" width="110">是否为图片简介：</th>
					<td>
					   ${pictureset.isPictureDesc eq yes ? "是" : ""}
					   ${pictureset.isPictureDesc eq no ? "否" : ""}
					</td>
				  </tr>
				  <tr>
					<th scope="row" width="110">简介：</th>
					<td>${rt:escapeHtml(pictureset.description)}</td>
				  </tr>
				  <tr>
					<th scope="row">创建时间：</th>
					<td>
                       <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${pictureset.createTime }" />
					</td>
				  </tr>
				  <tr class="buttom">
					<th scope="row" align="right"></th>
					<td>
					    <input type="button" id="submit_btn" value="查看图片" onclick="addPicture(${pictureset.id})" class="add_but fl"/>
						<input type="button" id="submit_btn" value="同意" onclick="agree(${pictureset.id})" class="add_but fl"/>
						<input type="button" id="submit_btn" value="不同意" onclick="disagree(${pictureset.id})" class="add_but fl"/>
						<a href="javascript:window.history.back();" class="but_fanhui fl" style="height:24px;border:0px;font-size:14px;color:white;font-weight:bold;">返 回</a>
					</td>
				  </tr>
				</table>
			</div>
		</div>
		<div class="cb"></div>
	</div>
</div>
</form>
</body>
</html>