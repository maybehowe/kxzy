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

<body>
<div class="wrapper">
	<div class="top">
		<div class="content">
			<a href="${contextPath }/" class="logo"><img src="${contextPath }/front/images/logo.jpg" width="312" height="101" /></a>
			<div class="top_right">
				<div id="login">
					<jsp:include page="../common/login.jsp" />
				</div>
				<div class="weibo">
					<a href="${contextPath}/building.jsp" target="_blank" class="txweibo" title="腾讯微博"></a>
					<a href="${contextPath}/building.jsp" class="xlweibo" target="_blank" title="新浪微博"></a>
				</div>
				<div class="nav">
					<a href="${contextPath }/front/video/index.rt?columnId=27">科普多媒体中心</a>
					<a href="/building.jsp">科普图书馆</a>
					<a href="/building.jsp">科普资源中心</a>
					<a href="/building.jsp">互动社区</a>
					<a href="${contextPath }/front/about/about.rt?channelId=38">关于我们</a>
				</div>
			</div>
		</div>
	</div>
	<div style="width:1050px; margin:0 auto;">
		<div class="building2">
			<p class="tit">很抱歉，您访问的页面不存在或暂时无法访问。</p>
			<p>您可以：</p>
			<p>1.直接访问浙江省科普资源共享服务平台首页 <a href="${contextPath }/"> 首页</a></p>
			<p>2.BUG反馈，请致电：0000-1234567</p>
			<p><a href="javascript:history.back(-1)">&lt;&lt;&nbsp;返回上一页</a></p>
		</div>
	</div>
	<div class="content">
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
<!--<div class="bottom_png"></div>-->
</body>
</html>

