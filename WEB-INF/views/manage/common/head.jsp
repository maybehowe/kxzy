<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<script type="text/javascript">
/*<![CDATA[*/
function addClassView(id,url){
	var redirectUrl = "";
	if(url.indexOf("?")<0){
		redirectUrl = url+"?viewId="+id;
	} else {
		redirectUrl = url+"&viewId="+id;
	}
	window.location.href=redirectUrl;
}
function addLeft(view,left,url){
	redirectUrl = url+"?viewId="+view+"&leftId="+left;
	window.location.href=redirectUrl;
}

/*]]>*/
</script>
<div class="top">
	<table width="100%" border="0">
	  <tr height="40" valign="top">
		<td align="left" rowspan="2" width="230">&nbsp;</td>
	    <td align="right" class="short" >
			<a href="${pageContext.request.contextPath}/manage/login/logout.rt" class="quit"></a>
			<a href="javascript:void(0);" class="back" onclick="javascript:window.location.reload();"></a>
			<a href="${pageContext.request.contextPath}/manage/home/index.rt" class="home"></a>
			<div id="time"><span><a href="${contextPath}/manage/user/userInfo.rt?userId=${sessionScope.user.id}&viewId=${viewId}&leftId=${leftId}" style="font-weight: bold;color:white; text-decoration: underline; background:none;float:left;width:auto; margin-right:0px;">${sessionScope.user.loginName}</a></span>&nbsp;，欢迎登录，资源共享服务平台！&nbsp;&nbsp;<span id="localtime"></span></div>
		</td>
	  </tr>
	  <tr>
		<td><!--nav-->
			<div id="menu">
					<c:forEach items="${resList }" var="res">
						<c:forEach items="${rrres }" var="rrr">
						<c:if test="${res.id==rrr.resId }">
						<dl>
							<dt<c:if test="${res.id==viewId }"> class="hover"</c:if>>
							<c:set var="childes" value="${res.childs }" />
							<c:set var="viewUrl" value="" />
							<c:forEach items="${childes }" var="child">
							<c:forEach items="${rrres }" var="r2">
								<c:if test="${child.id==r2.resId }">
								<c:if test="${ viewUrl==null || viewUrl==''}">
								<c:set var="viewUrl" value="${child.resUrl }" />
								</c:if>
								</c:if>
							</c:forEach>
							</c:forEach>
							<c:if test="${childes.size()==0 }">
							<c:set var="viewUrl" value="${res.resUrl }" />
							</c:if>
							 <a href="javascript:void(0);" onclick="addClassView(${res.id},'${contextPath }${viewUrl}')">${res.resName }</a>
							</dt>
							<dd></dd>
						</dl>
						</c:if>
					</c:forEach>
				</c:forEach>
			</div>
			<!--nav.end-->
		</td>
	  </tr>
	</table>
</div>
<script src="${contextPath}/js/time.js" type="text/javascript" charset="utf-8"></script>
<script src="${contextPath}/js/nav.js" type="text/javascript" charset="utf-8"></script>
