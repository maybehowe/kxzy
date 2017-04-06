<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="content">
	<a href="${contextPath }/" class="logo"><img src="${pageContext.request.contextPath}/front/images/logo.jpg" width="312" height="101" /></a>
	<div class="top_right">
		<div id="login">
		<jsp:include page="../common/login.jsp" />
		</div>
		<div class="weibo">
			<a href="${contextPath}/building.jsp" target="_blank" class="txweibo" title="腾讯微博"></a>
			<a href="${contextPath}/building.jsp" class="xlweibo" target="_blank" title="新浪微博"></a>
		</div>
		<div class="nav">
		   <c:forEach items="${channelList}" var="cl">
		     <a href="${contextPath}${cl.siteUrl}" class="${channel.id == cl.id ? 'hover' : '' }">${cl.name}</a>
		   </c:forEach>
		</div>
	</div>
</div>
