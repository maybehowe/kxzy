<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>科协资源管理平台</title>
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
/*<![CDATA[*/

/*]]>*/
</script>
</head>
<style> 
#star{position:relative;}
#star ul,#star span{float:left;display:inline;height:19px;line-height:19px;}
#star li{float:left;width:24px;cursor:pointer;text-indent:-9999px;background:url(${contextPath}/images/star/star.png) no-repeat;}
#star strong{color:#f60;padding-left:10px;}
#star li.on{background-position:0 -28px;}
#star p{position:absolute;top:20px;width:159px;height:60px;display:none;background:url(${contextPath}/images/star/icon.gif) no-repeat;padding:7px 10px 0;}
#star p em{color:#f60;display:block;font-style:normal;}
</style>
<body>
<div class="wrapper">
<div id="tishi" style="position: absolute; top: 0px; background: none repeat scroll 0% 0% rgb(119, 119, 119); opacity: 0.6; left: 0px; width: 100%; height: 100%; z-index: 100;display: none;">
	<div id="loading" style="background: none repeat scroll 0% 0% white; position: absolute; border:3px solid #333; left: 45%; top: 45%; width: 100px; height: 40px; padding-top:7px; text-align: center; z-index: 101;">
		<img src="${contextPath}/images/auth.gif"/>
	</div>
</div>
	<jsp:include page="/WEB-INF/views/manage/common/head.jsp" />
	<div class="content">
		<jsp:include page="/WEB-INF/views/manage/common/left.jsp" />
		<div class="right">
			<!--[if lt IE 8]><div class="both"></div><![endif]-->
			<div class="main">
				<div class="tit">添加视频</div>
				<div class="line">视频详情：</div>
				<form id="videoForm" name="videoForm" action="${contextPath}/manage/video/save.rt" method="post" enctype="multipart/form-data">
				<input type="hidden" name="viewId" value="${viewId }" />
				<input type="hidden" name="leftId" value="${leftId }" />
				<table width="96%" border="0" class="data">
				  <tr>
					<td colspan="2">
						<jsp:include page="/WEB-INF/views/manage/education/pictureset/video.jsp" />
					</td>
				  </tr>
				  <tr>
				  	<td>
				  	上传中，请勿离开此页面。
				  	</td>
				  </tr>
				  <tr class="buttom">
					<td colspan="2">
						<a href="javascript:window.history.back();" class="but_fanhui fl" style="height:24px;border:0px;font-size:14px;color:white;font-weight:bold;">返 回</a>
					</td>
				  </tr>
				</table>
				</form>
			</div>
		</div>
		<div class="cb"></div>
	</div>
</div>
</body>
</html>
