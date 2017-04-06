<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>浙江省科普资源共享服务平台</title>
<%@include file="../common/form.jsp" %>
<meta name="description" content="浙江省科普资源共享服务平台"/>
<meta name="keywords" content="浙江省科普资源共享服务平台" />
<meta name="copyright" content="杭州融坦软件科技有限公司" />
<meta name="author" content="杭州融坦软件科技有限公司" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<link href="${contextPath }/front/css/video.css" rel="stylesheet" type="text/css" />
<!--[if lt IE 10]>
<script type="text/javascript" src="${contextPath }/front/js/PIE.js"></script>
<![endif]-->
<style>
.main_nav li.hover{behavior:url(${contextPath }/front/css/PIE.htc)\9;}
</style>
<script language="javascript">
$(function() {  
    $('.rounded').each(function() {  
        PIE.attach(this);  
    });  
}); 
function loadvideo(obj,status){
	if(obj != null){
		$(obj).parent().find("li").each(function(){
			$(this).removeClass("title");
		});
		$(obj).addClass("title");
	}
	$.ajax({
	   type: "POST",
	   url: "${contextPath }/front/video/ranking.rt",
	   data: {"video.order":status},
	   success: function(json){
	     if(json != null){
	    	 var html = '';
	    	 $(json).each(function(i,item){
	    		 html +='<li><a target="_blank" href="${contextPath }/front/video/detail.rt?id='+item.id+'&columnId=${columnId}">'+item.videoTitle+'</a></li>';
	    	 });
	    	 $(".newslist").html(html);
	     }
	   }
	});
}
</script>
</head>

<body>
<div class="wrapper">
	<div class="top">
		<div class="content">
			<a href="${contextPath }/front/video/index.rt?columnId=27" class="logo"><img src="${contextPath }/front/images/img_logo.jpg" width="312" height="101" /></a>
			<div class="top_right">
				<div id="login">
				<jsp:include page="../common/login.jsp" />
				</div>
				<div class="weibo">
					<a href="${contextPath}/building.jsp" target="_blank" class="txweibo" title="腾讯微博"></a>
					<a href="http://weibo.com/zikp" class="xlweibo" target="_blank" title="新浪微博"></a>
				</div>
				<div class="nav">
					<c:forEach items="${columnes.childs }" var="child">
						<a href="${contextPath }${child.siteUrl}"<c:if test="${child.id==columnId }"> class="hover"</c:if>>${child.name }</a>
					</c:forEach>
					<a href="${contextPath }/" class="bank"><img src="${contextPath }/front/images/bank.jpg" /></a>
				</div>
			</div>
		</div>
	</div>
	<div class="content">
		<div class="main_nav">
			<ul>
				<c:forEach items="${categoryes.childs }" var="cate">
					<li <c:if test="${cate.id==categoryId }"> class="hover"</c:if>>
						<a href="${contextPath }/front/video/index.rt?categoryId=${cate.id}&columnId=${columnId}">${cate.name }</a>
					</li>
				</c:forEach>
			</ul>
			<a href="${contextPath }/front/video/list.rt?categoryId=${categoryId}&columnId=${columnId}" class="more" style="margin-top:5px;"><img src="${contextPath }/front/images/more_0703.png" /></a>
		</div>
		<div class="main_nav_ie"></div>
		<div>
			<c:forEach items="${pageFive }" var="video" varStatus="index">
				<c:if test="${index.index==0 }">
					<div class="main_left">
						<a target="_blank" href="${contextPath }/front/video/detail.rt?id=${video.id}&columnId=${columnId}">
						<img src="${contextPath }${video.bigPic }" onerror="this.src='${contextPath }/front/images/load.jpg'" width="330" height="300" />
						</a>
						<p class="big_tit"><a href="${contextPath }/front/video/detail.rt?id=${video.id}&columnId=${columnId}" target="_blank">${video.videoTitle }</a></p>
					</div>
				</c:if>
				<c:if test="${index.index==1 }"><div class="main_cent"></c:if>
				<c:if test="${index.index>0 }">
					<ul>
						<li class="img"><a target="_blank" href="${contextPath }/front/video/detail.rt?id=${video.id}&columnId=${columnId}">
						<img src="${contextPath }${video.smallPic }" onerror="this.src='${contextPath }/front/images/load.jpg'" width="185" height="100" /></a></li>
						<li class="tit"><a target="_blank" href="${contextPath }/front/video/detail.rt?id=${video.id}&columnId=${columnId}">${video.videoTitle }</a></li>
						<li class="time"><fmt:formatDate value="${video.uploadTime }" pattern="yyyy-MM-dd HH:mm:ss" /></li>
					</ul>
				</c:if>
				<c:if test="${index.index+1==pageFive.size() }"></div></c:if>
			</c:forEach>
			<div class="main_right">
				<div class="search">
				<form id="searchForm" name="searchForm" action="${contextPath }/front/video/search.rt" method="get">
				<input type="hidden" name="columnId" value="${columnId }" />
					<select id="search_subCate" name="cateId" id="cateId">
						<option value="0">全部</option>
						<c:forEach items="${categoryes.childs}" var="cate">
							<option value="${cate.id}">${cate.name}</option>
						</c:forEach>
					</select>
					<input name="searchName" type="text" id="searchName" class="text" style="width:100px;" />
					<input name="" type="submit" value="搜 索" class="sub" />
				</form>
				</div>
				<div class="main">
					<p class="tit">科普影院排行榜</p>
					<div id="outer">
						<ul id="tab">
							<li class="title" onclick="loadvideo(this,1);">最新</li>
							<li onclick="loadvideo(this,2);">最热</li>
							<li>评分</li>
						</ul>
						<div id="content">
							<ul class="newslist" style="display:block;">
							</ul>
							<script language="javascript">loadvideo(null,1);</script>
						</div>
					</div>
				</div>
			</div>
			<div class="rollBox">
				<div class="LeftBotton" onMouseDown="ISL_GoUp()" onMouseUp="ISL_StopUp()" onMouseOut="ISL_StopUp()"></div>
				<div class="Cont" id="ISL_Cont">
					<div class="ScrCont">
						<div id="List1">
							<!-- 图片列表 begin -->
							<c:forEach items="${pageTen }" var="video">
								<div class="pic">
									<a target="_blank" href="${contextPath }/front/video/detail.rt?id=${video.id}&columnId=${columnId}"><img src="${contextPath }${video.smallPic }" width="150" height="98" /></a>
									<p class="img_tit"><a target="_blank" href="${contextPath }/front/video/detail.rt?id=${video.id}&columnId=${columnId}">${video.videoTitle }</a></p>
								</div>
							</c:forEach>
							<!-- 图片列表 end -->
						</div>
						<div id="List2"></div>
					</div>
				</div>
				<div class="RightBotton" onMouseDown="ISL_GoDown()" onMouseUp="ISL_StopDown()" onMouseOut="ISL_StopDown()"></div>
			</div>
		</div>
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
<!--<div class="bottom_png"></div>-->
<script src="${contextPath }/front/js/Scroll.js" type="text/javascript"></script>
</body>
</html>

