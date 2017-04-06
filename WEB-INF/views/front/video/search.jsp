<%@page import="com.roots.kxzy.system.common.utils.StringUtils"%>
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
</head>
<script type="text/javascript">
function AutoScroll(obj){
        $(obj).find("ul:first").animate({
                marginTop:"-48px"
        },500,function(){
                $(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
        });
}
$(document).ready(function(){
setInterval('AutoScroll("#scrollDiv")',3000)
});
function searchSubmit(){
	$("#curPage").val(1);
	$("#searchForm").submit();
}
</script>
<body>
<div class="wrapper">
	<div class="top">
		<div class="content">
			<a href="#" class="logo"><img src="${contextPath }/front/images/img_logo.jpg" width="312" height="101" /></a>
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
		<div class="register_banner"><img src="${contextPath }/front/images/search_banner.jpg" width="1000" height="153" /></div>
		<div class="video_list_search">
			<div id="scrollDiv">
				<ul>
					<c:forEach items="${top }" var="v">
						<li><a target="_blank" href="${contextPath }/front/video/detail.rt?id=${v.id}&columnId=${columnId}">[推荐] ${v.videoTitle }</a></li>
					</c:forEach>
				</ul>
			</div>
			<div class="search">
				<form id="searchForm" name="searchForm" action="${contextPath }/front/video/search.rt" method="get">
				<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
				<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
				<input type="hidden" name="columnId" value="${columnId }" />
					<select id="search_subCate" name="cateId" id="cateId">
						<option value="0">全部</option>
						<c:forEach items="${categoryes.childs}" var="cate">
							<option <c:if test="${cate.id==cateId }">selected="selected"</c:if> value="${cate.id}">${cate.name}</option>
						</c:forEach>
					</select>
					<input name="searchName" type="text" id="searchName" class="text" value="<c:out value="${searchName }" escapeXml="true" />" style="width:200px;" />
					<input name="" type="button" onclick="searchSubmit();" value="搜 索" class="sub" />
				</form>
			</div>
		</div>
		<div class="video_list_main">
			<div class="list_main_top">
				<p class="tit">视频搜索</p>
				<p class="dizhi">当前位置：首页 > ${channelName} > ${columnName } > 搜索</p>
				<div class="list_main_div">
					<c:forEach items="${page.results }" var="video">
						<ul>
							<li class="img"><a target="_blank" href="${contextPath }/front/video/detail.rt?id=${video.id}&columnId=${columnId}">
							<img src="${contextPath }${video.smallPic}" onerror="this.src='${contextPath }/front/images/load.jpg'" height="100" width="180" />
							</a>
							</li>
							<li class="tit">
								<a target="_blank" href="${contextPath }/front/video/detail.rt?id=${video.id}&columnId=${columnId}">
									${video.videoName }
								</a>
							</li>
							<li class="time">${video.playCount }次播放</li>
						</ul>
					</c:forEach>
					<div class="cb"></div>
				</div>
				<jsp:include page="../common/page.jsp" >
				<jsp:param value="${contextPath }/front/video/search.rt" name="pageUrl"/>
				<jsp:param value="searchForm" name="formName"/>
				</jsp:include>
			</div>
		</div>
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
<!--<div class="bottom_png"></div>-->
</body>
</html>


