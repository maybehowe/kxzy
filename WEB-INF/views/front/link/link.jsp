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
<link href="${contextPath }/front/css/about.css" rel="stylesheet" type="text/css" />
<script language="javascript">
  function getLinkByCate(cateId){
	  window.location.href = "${contextPath}/front/link/linkByCate.rt?cateId="+cateId;
  }
</script>
</head>

<body>
<div class="wrapper">
	<div class="top">
		<jsp:include page="../common/head.jsp" />
	</div>
	<div class="content">
		<div class="register_banner"><img src="${contextPath }/front/images/link_banner.jpg" width="1000" height="153" /></div>
		<div class="about_left">
			<div class="tit">友情链接 <span>Friendly Link</span></div>
			<ul class="left_nav">
				<c:forEach items="${linkcateList}" var="lc" begin="0" step="1" varStatus="vs">
				    <li class="${lc.id == linkCate.id ? 'hover' : ''}"><a href="javascript:getLinkByCate(${lc.id})">${lc.cateName}</a></li>
				</c:forEach>
			</ul>
		</div>
		<div class="about_right">
			<p class="dizhi">当前位置：首页 > 友情链接 > ${linkCate.cateName}</p>
			<p class="en">Friendly Link</p>
			<div class="about_right_main">
				<ul class="link_ul">
				   <c:forEach items="${linkList}" var="l" begin="0" step="1" varStatus="vs">
				      <li>
				        <img src="${contextPath }${l.pictureUrl}" width="225" height="80" />
						<a href="${l.address}" target="_blank">${l.linkName}<br />${l.address}</a>
					  </li>
				   </c:forEach>
					
				</ul>
			</div>
		</div>
		<div class="cb"></div>
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
</body>
</html>

