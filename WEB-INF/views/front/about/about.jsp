<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roots.kxzy.system.common.constant.AboutCategories"%>
<%
  request.setAttribute("lxwm",AboutCategories.lxwm);
  request.setAttribute("bqsm",AboutCategories.bqsm);
  request.setAttribute("wzjj",AboutCategories.wzjj);
%>
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
<link href="${contextPath }/front/css/about.css" rel="stylesheet" type="text/css" />
<script language="javascript">
  function getAboutByCate(cateId){
	  window.location.href = "${contextPath}/front/about/aboutByCate.rt?channelId="+"${channel.id}"+"&cateId="+cateId;
  }
</script>
</head>

<body>
<div class="wrapper">
	<div class="top">
		<jsp:include page="../common/head.jsp" />
	</div>
	<div class="content">
		<div class="register_banner"><img src="${contextPath }/front/images/about_banner.jpg" width="1000" height="153" /></div>
		<div class="about_left">
			<div class="tit">关于我们 <span>About Us</span></div>
			<ul class="left_nav">
				<li class="${wzjj == cateId ? 'hover' : ''}"><a href="javascript:getAboutByCate(${wzjj})">网站简介</a></li>
				<li class="${lxwm == cateId ? 'hover' : ''}"><a href="javascript:getAboutByCate(${lxwm})">联系我们</a></li>
				<li class="${bqsm == cateId ? 'hover' : ''}"><a href="javascript:getAboutByCate(${bqsm})">版权声明</a></li>
			</ul>
		</div>
		<div class="about_right">
			<p class="dizhi">当前位置：首页 > ${channel.name} > ${cateId == wzjj ? '网站简介' : (cateId == lxwm ? '联系我们' : (cateId == bqsm ? '版权声明' : ''))}</p>
			<p class="en">${cateId == wzjj ? 'Description' : (cateId == lxwm ? 'Contact Us' : (cateId == bqsm ? 'Copyright' : ''))}</p>
			<div class="about_right_main">
				${about.content}
			</div>
		</div>
		<div class="cb"></div>
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
</body>
</html>

