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
.search input.text{
	width: 205px;
}
.video_list_search .search input.text{
	width: 205px;
}
.highlight{
	color: #1e5da2;
}
</style>
<script type="text/javascript">
function doSearch(){
	var url = "${contextPath }/front/search/index.rt";
	url += "?scope="+encodeURIComponent($("#search_scope").val()) +"&text="+encodeURIComponent($("#search_text").val());
	window.location.href=url;
}
function turnPage(index){
	var url = "${contextPath}/front/search/index.rt?&text="+encodeURIComponent($("#last_search_text").val())+"&paging.index="+index+"&scope=${coreName}";
	window.location.href=url;
}
$(function(){
	$("#search_text").keydown(function (evt){
		if(evt.keyCode == 13){
			doSearch();
		}
	});
});

</script>
</head>

<body>
<div class="wrapper">
	<div class="top">
		<div class="content">
			<a href="${contextPath }/" class="logo"><img src="${contextPath }/front/images/logo2.png" width="316" height="47" /></a>
			<div class="top_right">
				<div id="login">
				<jsp:include page="../common/login.jsp" />
				</div>
				<div class="weibo">
					<a href="${contextPath}/building.jsp" target="_blank" class="txweibo" title="腾讯微博"></a>
					<a href="http://weibo.com/zikp" class="xlweibo" target="_blank" title="新浪微博"></a>
				</div>
				<div class="nav">
				<c:forEach items="${channeles }" var="cm">
				<a href="${contextPath}${cm.siteUrl}">${cm.name }</a>
				</c:forEach>
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
							<a href="${contextPath}/front/search/index.rt?scope=${scpEntry.value.value}"
								class="${(scpEntry.value.value eq scope) ? 'label-active':'label'}">[${scpEntry.value.name}]</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:void(0);" class="label">[${scpEntry.value.name}]</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
			<div class="search" align="right">
				<select id="search_scope" name="scope">
					<c:forEach items="${scopes}" var="scpEntry">
						<c:if test="${scpEntry.value.enable}">
							<option<c:if test="${scpEntry.value.value==coreName }"> selected="selected"</c:if> value="${scpEntry.value.value}">${scpEntry.value.name}</option>
							
						</c:if>
					</c:forEach>
				</select>
				<input id="last_search_text" type="hidden" class="text" value="${rt:escapeHtml(text)}" />
				<input id="search_text" name="text" type="text" class="text" value="${rt:escapeHtml(text)}" />
				<input type="button" value="搜 索" class="sub" onclick="doSearch();" />
			</div>
		</div>
		<div class="video_list_main">
			<div class="list_main_top">
				<p class="tit">全部搜索</p>
				<p class="dizhi">当前位置：首页  &gt; 搜索</p>
				<div class="search_main">
					<ul id="search">
						<c:set var="hi" value="${queryResponse.highlighting}"></c:set>
						<c:forEach items="${queryResponse.results}" var="doc">
						<li>
							<c:if test="${doc.scope!=null }">
							<span class="tit2"
							<c:if test="${doc.scope!=null }">
								<c:if test="${doc.scope=='video' }">
								style="background:#62a055;"
								</c:if>
								<c:if test="${doc.scope=='picture' }">
								style="background:#43749a;"
								</c:if>
								<c:if test="${doc.scope=='museum' }">
								style="background:#43749a;"
								</c:if>
								<c:if test="${doc.scope=='expert' }">
								style="background:#43749a;"
								</c:if>
								<c:if test="${doc.scope=='education' }">
								style="background:#43749a;"
								</c:if>
								<c:if test="${doc.scope=='exhibit' }">
								style="background:#43749a;"
								</c:if>
							</c:if>
							>[${scopes[doc.scope].name}]</span>
							</c:if>
							<c:if test="${doc.scope!=null }">
								<c:if test="${doc.scope=='video' }">
								<a target="_blank" href="${contextPath }/front/video/detail.rt?id=${doc.id}">${doc.title}</a>
								</c:if>
								<c:if test="${doc.scope=='picture' }">
								<a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${doc.id}">${doc.title}</a>
								</c:if>
								<c:if test="${doc.scope=='museum' }">
								<a target="_blank" href="${contextPath }/front/museum/detail.rt?id=${doc.id}&columnId=147">${doc.title}</a>
								</c:if>
								<c:if test="${doc.scope=='expert' }">
								<a target="_blank" href="${contextPath }/front/expert/detail.rt?id=${doc.id}&columnId=146">${doc.title}</a>
								</c:if>
								<c:if test="${doc.scope=='education' }">
								<a target="_blank" href="${contextPath }/front/education/detail.rt?id=${doc.id}&columnId=149">${doc.title}</a>
								</c:if>
								<c:if test="${doc.scope=='exhibit' }">
								<a target="_blank" href="${contextPath }/front/exhibit/detail.rt?id=${doc.id}&columnId=148">${doc.title}</a>
								</c:if>
							</c:if>
							<c:if test="${scope=='video' }">
							<a target="_blank" href="${contextPath }/front/video/detail.rt?id=${doc.id}">${doc.title}</a>
							</c:if>
							<c:if test="${scope=='picture' }">
							<a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${doc.id}">${doc.title}</a>
							</c:if>
							<c:if test="${scope=='museum' }">
							<a target="_blank" href="${contextPath }/front/museum/detail.rt?id=${doc.id}&columnId=147">${doc.title}</a>
							</c:if>
							<c:if test="${scope=='expert' }">
							<a target="_blank" href="${contextPath }/front/expert/detail.rt?id=${doc.id}&columnId=146">${doc.title}</a>
							</c:if>
							<c:if test="${scope=='education' }">
							<a target="_blank" href="${contextPath }/front/education/detail.rt?id=${doc.id}&columnId=149">${doc.title}</a>
							</c:if>
							<c:if test="${scope=='exhibit' }">
							<a target="_blank" href="${contextPath }/front/exhibit/detail.rt?id=${doc.id}&columnId=148">${doc.title}</a>
							</c:if>
							<span class="time"><fmt:formatDate value="${doc.time}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
						</li>
						</c:forEach>
					</ul>
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
