<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科协资源管理平台</title>
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<link href="${contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/css/jquery-webox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/sco.message.css" type="text/css"></link>
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/scojs.css" type="text/css"></link>
<script type="text/javascript" src="${contextPath}/bootstrap.sco/js/sco.message.js"></script>
<script type="text/javascript" src="${contextPath}/js/jquery-webox.js"></script>
<style type="text/css"> 

.select_img{
	width:184px; 
	height: 139px;
	border: 1px solid red;
	cursor:pointer; 
}
.cannel_img{ 
	width:184px; 
	height: 139px;
	border: 1px solid #eeeeee;
	cursor:pointer; 
}
.fengmian{
position:absolute;margin-left: -35px;margin-left: -42px\0; margin-top: 1px;background: #379DD5; font-size: 12px; color: #fff; display: inline; padding:2px 5px;
}
@media screen and (-webkit-min-device-pixel-ratio:0) {.fengmian{margin-left: 151px;margin-top: -140px;}}
</style> 
<script type="text/javascript">
$(function(){
    $("#picture_div img").bind("click",function(){
    	if($(this).attr("class") == "select_img"){
	    	$(this).removeClass("select_img");
	    	$(this).addClass("cannel_img");
    	}else if($(this).attr("class").toString() == "cannel_img"){
    		$(this).removeClass("cannel_img");
	    	$(this).addClass("select_img");
    	}
    })
    
    $("#delSelected").click(function(){
    	var arrayId = new Array();
    	$("#picture_div .select_img").each(function(){
    		arrayId.push($(this).attr("alt"))
    	});
    	if(arrayId.length > 0){
    		var ids = "";
			for ( var i = 0; i < arrayId.length; i++) {
				ids += arrayId[i] + ",";
			}
			ids = ids.substring(0, ids.length - 1);
			if(confirm("确定删除？")){
				var url = "${contextPath }/manage/museum/picture/delete.rt";
				var params = {
					"ids" : ids,
				};
				$.post(url,params,function(result) {
					if (result.flag){
						 $.scojs_message('删除成功',{
							 "type":$.scojs_message.TYPE_OK,
							 "delay":1000,
							 "onAfterHidden" : function(){
								 $("#searchForm").attr("action","${contextPath }/manage/museum/picture/list.rt?picturesetId="+${pictureset.id});
								 $("#searchForm").submit();
							 }
						 });
					} else {
						 $.scojs_message('删除失败', $.scojs_message.TYPE_ERROR);
					}
				});
			}
    	}else{
			 $.scojs_message('请选择要删除的图片！', $.scojs_message.TYPE_ERROR);
		}
    })
    
    initUploadDiv();
})

  //搜索
 function searchSubmit(){
	var searchName = $("#searchName").val();
	if(searchName=='输入搜索的关键词'){
		$("#searchName").val('');
	}
	$("#curPage").val(1);
	$("#searchForm").submit();
}

//初始化上传窗体
function initUploadDiv(){
    if(${page.results.size() == 0}){
    	showUploadDiv("${pictureset.id}");
    }
}

function showUploadDiv(id){
	var uploadUrl = "${contextPath}/manage/museum/picture/showUpload.rt?picturesetId="+id;	
	$.webox({
		height:400,
		width:900,
		bgvisibel:true,
		title:"上传图片",
		iframe:uploadUrl,
		onclosed:function(){
			$("#searchForm").submit();
		}
	});
}

//跳至编辑
function showEdit(id){
	 $("#searchForm").attr("action","${contextPath}/manage/museum/picture/showEdit.rt?picId="+id);
	 $("#searchForm").submit();
}

//设封面
function setCover(id){
	var url = "${contextPath}/manage/museum/picture/setPictureSetCover.rt";
	var params = {
		"pictureId" : id,
		"picturesetId" : ${pictureset.id}
	};
	$.post(url,params,function(result) {
			if(result.flag){
  				 $("#searchForm").attr("action","${contextPath}/manage/museum/picture/list.rt");
				 $("#searchForm").submit();
			} else {
				$.scojs_message('设置失败', $.scojs_message.TYPE_ERROR);
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
				<a href="javascript:void(0);" id="inside" onclick="showUploadDiv(${pictureset.id})">上传图片</a>
				<a href="${contextPath}${rt:escapeHtml(returnUtl)}">返 回</a>
			</div>
			<form name="searchForm" id="searchForm" action="${contextPath}/manage/museum/picture/list.rt" method="post">
			<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			<input type="hidden" name="viewId" id="viewId" value="${viewId }"/>
			<input type="hidden" name="leftId" id="leftId" value="${leftId }"/>
			<input type="hidden" name="picturesetId" id="picturesetId" value="${pictureset.id}"/>
			<input type="hidden" name="returnUrl" id="returnUrl" value="${rt:escapeHtml(returnUtl)}"/>
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
						<img src="${contextPath}/manage/museum/picture/thumbnail.rt?picId=${pic.id}&size=176" alt="${pic.id}" class="cannel_img">
						<c:if test="${pictureset.isCover == pic.id}">
						   <div style="" class="fengmian">封面</div>
						</c:if>
					<p>
					    <a href="${contextPath}/manage/museum/picture/view.rt?picId=${pic.id}&viewId=${viewId}&leftId=${leftId}" class="but_fanhui fl">查看</a>
					    <a href="javascript:showEdit(${pic.id})" class="but_fanhui fl">编辑</a>
					    <a href="javascript:setCover(${pic.id})"  class="but_fanhui fl">设封面</a>
					</p>
					</li>
				</c:forEach>
				</ul>
				</div>
				<div class="cb"></div>
			   <div class="page">
					<div class="fl"><input type="button" id="delSelected"  value="删除选中图片" class="sub2" style="*margin-left:-170px;" /></div>
					<jsp:include page="/WEB-INF/views/manage/common/page.jsp" >
					<jsp:param value="${contextPath}/manage/museum/picture/list.rt" name="pageUrl"/>
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

