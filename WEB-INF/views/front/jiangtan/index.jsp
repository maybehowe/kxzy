<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="rt" uri="http://www.roots.com/tags/commons"  %>
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
<link rel="shortcut icon" href="${contextPath }/favicon.ico" type="image/x-icon" />
<link href="${contextPath }/front/css/video.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/js/jwplayer-6.8/jwplayer.js"></script>
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/bootstrap.min.css" type="text/css"></link>
<script type="text/javascript" src="${contextPath}/bootstrap.sco/js/bootbox.min.js"></script>
<script type="text/javascript" src="${contextPath}/bootstrap.sco/js/bootstrap.min.js"></script>
<script type="text/javascript">
/*<![CDATA[*/
$(function(){
	var stream = "rtmp://119.37.199.114/live/stream1459081346047";
	jwplayer("media_player").setup({
		"primary" : "flash",
	    "file" : stream,
	    //"image":"${contextPath}/js/jwplayer-6.8/jw-poster-adp.png",
	    //"file" : "rtmpt://${rt:prop('media_server')}/rms/flv:${video.path}",//rtmpt\://192.168.17.3\:5080/rms/flv
	    'width': '1000',
	    'height': '520'
	 });
	var count = "${video.heat }";
	for(var i=0;i<count ;i++){
		$("#star").find("li").each(function(j){
			if(i==j){
				$(this).addClass("on");
			}
		});
	}
});


/*]]>*/
</script>
</head>
<style> 
#star{position:relative;}
#star ul,#star span{float:left;display:inline;height:19px;line-height:19px;}
#star ul{margin:0 10px;}
#star li{float:left;width:24px;text-indent:-9999px;background:url(${contextPath}/front/images/star/star.png) no-repeat;}
#star strong{color:#f60;padding-left:10px;}
#star li.on{background-position:0 -28px;}
#star p{position:absolute;top:20px;width:159px;height:60px;display:none;background:url(${contextPath}/front/images/star/icon.gif) no-repeat;padding:7px 10px 0;}
#star p em{color:#f60;display:block;font-style:normal;}
</style>
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
					<a href="${contextPath}/building.jsp" class="xlweibo" target="_blank" title="新浪微博"></a>
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
		<p class="video_play_tit">${video.videoTitle }</p>
		<div class="media_player" id="media_player">
		
		</div>
		
		<div class="video_play_main">
			<table width="960" class="video_play_table">
			  <tr valign="top">
				<td width="65">视频名称：</td>
				<td colspan="3">科普讲坛</td>
			  </tr>
			  <tr valign="top">
				<td>视频简介：</td>
				<td colspan="4"><div style="width:890px;">科普讲坛</div></td>
				</tr>
			</table>
		</div>
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
<!--<div class="bottom_png"></div>-->
</body>
</html>
