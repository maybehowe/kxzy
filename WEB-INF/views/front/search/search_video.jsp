<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="rt" uri="http://www.roots.com/tags/commons" %>
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
<style>
a.label-active{
	background-color: #62a055;
	color: white;
	font-weight: bold;
}
a.label {
	background-color: rgb(153,153,153);
}
.search select{
	width: 75px;
}
.video_list_search .search input.text{
	width: 205px;
}
.highlight{
	color: #1e5da2;
}
</style>
<script type="text/javascript">
$(function(){
	$("#search_subCate option[value='${subCate}']").attr("selected","selected");
});
function doSearch(){
	var url = "${contextPath }/front/search/index.rt";
	url += "?scope=video";
	url += "&subCate="+encodeURIComponent($("#search_subCate").val()) +"&text="+encodeURIComponent($("#search_text").val());
	window.location.href=url;
}
function turnPage(index){
	var url = "${contextPath}/front/search/index.rt?scope=video&text="+encodeURIComponent($("#last_search_text").val())+"&subCate=${subCate}&paging.index="+index;
	window.location.href=url;
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
					<c:forEach items="${channeles }" var="ch">
						<a href="${contextPath }${ch.siteUrl}"<c:if test="${ch.id==columnId }"> class="hover"</c:if>>${ch.name }</a>
					</c:forEach>
					<a href="${contextPath }/" class="bank"><img src="${contextPath }/front/images/bank.jpg" /></a>
				</div>
			</div>
		</div>
	</div>
	<div class="content">
		<div class="register_banner"><img src="${contextPath }/front/images/search_banner.jpg" width="1000" height="153" /></div>
		<div class="video_list_search">
			<div class="search_div">
				<p class="tit">检索类别：</p>
				<c:forEach items="${scopes}" var="scpEntry">
					<c:choose>
						<c:when test="${scpEntry.value.enable}">
							<a href="javascript:void(0);"
								class="${(scpEntry.value.value eq 'video') ? 'label-active':'label'}">[${scpEntry.value.name}]</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:void(0);" class="label">[${scpEntry.value.name}]</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
			<div class="search">
				<select id="search_subCate" name="subCate">
					<option value="all" ${subCate eq "all" ? "selected='selected'" :""}>全部</option>
					<c:forEach items="${subCates}" var="cate">
						<option value="${cate.key}" ${subCate eq cate.key ? "selected='selected'" :""}>${cate.value}</option>
					</c:forEach>
				</select>
				<input id="last_search_text" type="hidden" class="text" value="${rt:escapeHtml(text)}" />
				<input id="search_text" name="text" type="text" class="text" value="${rt:escapeHtml(text)}" />
				<input type="button" value="搜 索" class="sub" onclick="doSearch();" />
			</div>
		</div>
		<div class="video_list_main">
			<div class="list_main_top">
				<p class="tit">视频搜索</p>
				<p class="dizhi">当前位置：首页 &gt; 搜索</p>
				<div class="list_main_div">
					<c:forEach items="${queryResponse.results}" var="doc">
						<ul>
							<li class="img"><a target="_blank" href="${contextPath }/front/video/detail.rt?id=${doc.id}">
							<img class="video-front" src="${contextPath }${doc.small_pic}" onerror="this.src='${contextPath }/front/images/load.jpg'" width="180" height="100" />
							</a>
							</li>
							<li class="tit"><a target="_blank" href="${contextPath }/front/video/detail.rt?id=${doc.id}">${doc.title}</a></li>
							<li class="time">${doc.play_count}次播放</li>
						</ul>
					</c:forEach>
					<div class="cb"></div>
				</div>
				<div class="video_list_page">
					<c:if test="${paging.hasPrevIndex }">
						<a href="javascript:turnPage(${paging.index-1 });" class="prev">&lt;</a>
					</c:if>
					<c:forEach var="index" begin="${paging.displayIndexRange.left}" end="${paging.displayIndexRange.right}" >
						<a href="javascript:turnPage(${index});" class="${index eq paging.index ?'hover':'' }">${index}</a>
					</c:forEach>
        			<c:if test="${paging.hasNextIndex }">
						<a href="javascript:turnPage(${paging.index+1 });" class="next">&gt;</a>
					</c:if>
					<span>共${paging.total}个结果</span>
					<div class="cb"></div>
				</div>
			</div>
		</div>
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
<!--<div class="bottom_png"></div>-->
<script type="text/javascript">
$(function(){
	 $("#search li:even").addClass("t1");
});
</script>
</body>
</html>

