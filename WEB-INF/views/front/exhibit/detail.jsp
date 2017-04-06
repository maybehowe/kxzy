<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="rt" uri="http://www.roots.com/tags/commons"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
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
<script type="text/javascript" src="${contextPath }/front/js/galleria/galleria-1.3.5.js"></script>
<link rel="stylesheet" href="${contextPath }/front/js/galleria/themes/azur/galleria.azur.css" />
<script type="text/javascript">
/*<![CDATA[*/
$(function(){
	// Load the classic theme
    Galleria.loadTheme('${contextPath }/front/js/galleria/themes/azur/galleria.azur.min.js');
	
    Galleria.ready( function(){
    	this.play(5000);
    });

    // Initialize Galleria
    Galleria.run('#galleria');
});
/*]]>*/
</script>
</head>
<style type="text/css">
.glyphicon-hide{
	display: none;
}
#galleria {
	height: 600px;
}
.tuji a:hover{ text-decoration: underline;}
</style>
<body>
<div class="wrapper">
	<div class="top">
		<div class="content">
			<a href="${contextPath }/front/museum/index.rt?columnId=147" class="logo"><img src="${contextPath }/front/images/v2/img_logo.jpg" width="312" height="101" /></a>
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
			<div class="col-md-9" style="margin-bottom:20px;">
				<div class="panel panel-default" style="height: 100%">
					<div class="video_play_tit"><c:out value='${picSet.name}' escapeXml='true'/></div>
					<div class="panel-body">
						<div id="galleria">
						<c:forEach items="${picList}" var="pic">
				            <a href="${contextPath }/front/exhibit/image.rt?picId=${pic.id}">
				                <img 
				                    src="${contextPath }/front/exhibit/thumbnail.rt?picId=${pic.id}&size=176"
				                    data-title=" "
				                    data-description="<c:out value='${pic.picDescription}' escapeXml='true'/>"
				                >
				            </a>
						</c:forEach>
			            </div>
					</div>
				</div>
			</div>
		<div class="tuji">
			<div style="float: left;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;width: 300px;">
			<a href="${contextPath }/front/exhibit/detail.rt?id=${prevPic.id }&columnId=${columnId }" style=" color: #1E5DA2">
			上一个图集:${fn:substring(prevPic.name, 0, 12) }
			</a></div>
			<div style="float: right;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;width: 300px; text-align: right;">
			<a href="${contextPath }/front/exhibit/detail.rt?id=${nextPic.id }&columnId=${columnId }" style=" color: #1E5DA2;">
			下一个图集:${fn:substring(nextPic.name, 0, 12) }
			</a></div>
			<div class="cb"></div>
		</div>
		
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
<!--<div class="bottom_png"></div>-->
</body>
</html>