<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科协资源管理平台</title>
<%@include file="../common/form.jsp" %>
<link href="${contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/css/jquery-webox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/sco.message.css" type="text/css"></link>
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/scojs.css" type="text/css"></link>
<script type="text/javascript" src="${contextPath}/bootstrap.sco/js/sco.message.js"></script>
<script type="text/javascript" src="${contextPath}/js/jquery-webox.js"></script>
<style type="text/css"> 
.cannel_img{ 
	width:184px; 
	height: 139px;
	cursor:pointer; 
}
.fengmian{
position:absolute;margin-left: -34px;margin-left: -41px\0; margin-top: 0px;background: #379DD5; font-size: 12px; color: #fff; display: inline; padding:2px 5px;
}
@media screen and (-webkit-min-device-pixel-ratio:0) {.fengmian{margin-left: 150px;margin-top: -142px;}}
</style> 
<script type="text/javascript">
$(function(){
    $("#picture_div img").bind("click",function(){
    	var pictureId = $(this).attr("alt");
    	window.location.href="${contextPath}/manage/work/pictureview.rt?picId="+pictureId+"&viewId=${viewId}&leftId=${leftId}";
    })
})

</script>
</head>
<body>
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp" />
		<div class="right">
			<div class="buts">
				<a href="javascript:window.history.back();">返 回</a>
			</div>
			<form name="searchForm" id="searchForm" action="${contextPath}/manage/work/atuditPictureList.rt" method="post">
			<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			<input type="hidden" name="viewId" id="viewId" value="${viewId }"/>
			<input type="hidden" name="leftId" id="leftId" value="${leftId }"/>
			<input type="hidden" name="picturesetId" id="picturesetId" value="${pictureset.id}"/>
			<fieldset class="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
					<p class="fl">图片名称：</p>
					<p class="fl mr15"><input name="searchName" id="searchName"  type="text" class="text" value="${rt:escapeHtml(searchName)}"/></p>
					<p><input type="submit" value="搜 索" class="sub" onclick="searchSubmit()" /></p>
				</div>
			</fieldset>
			<div class="main">
			<div style="padding-left: 9px;" id="picture_div">
			   <ul>
				  <c:forEach items="${page.results}" var="pic">
					<li style="float: left; padding-left: 10px;padding-bottom: 10px">
						<img src="${contextPath}/manage/picture/thumbnail.rt?picId=${pic.id}&size=176" alt="${pic.id}" class="cannel_img">
						<c:if test="${pictureset.isCover == pic.id}">
						   <div class="fengmian">封面</div>
						</c:if>
					</li>
				</c:forEach>
				</ul>
				</div>
				<div class="cb"></div>
			   <div class="page">
					<jsp:include page="/WEB-INF/views/manage/common/page.jsp" >
					<jsp:param value="${contextPath}/manage/work/atuditPictureList.rt" name="pageUrl"/>
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
<script src="${contextPath}/js/checkbox.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>

