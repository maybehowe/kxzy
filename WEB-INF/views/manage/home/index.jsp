<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>浙江省科普资源共享服务平台</title>
<%@include file="../common/form.jsp" %>
<link href="${contextPath}/css/index.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content2">
		<div class="content">
			<div class="left">
				<!--系统日志-->
				<div class="dome fl">
					<div class="tit">待审核用户</div>
					<div class="nr">
						<table width="435" border="0">
						<c:forEach items="${useres.results }" var="u">
							<tr>
							<td>${u.loginName }</td>
							<td>${u.agencyName }</td>
							<td><a href="${contextPath }/manage/work/showTeamUserDetail.rt?userId=${u.id}&viewId=${viewId}&leftId=3">详情</a></td>
						  </tr>
						</c:forEach>
						</table>
					</div>
					<div class="bo"></div>
				</div>
				<!--系统日志.end-->
				<!--时事消息-->
				<div class="dome2 fr">
					<div class="tit">待审核视频</div>
					<div class="nr">
						<table width="320" border="0">
						  <c:forEach items="${page.results }" var="video">
						  <tr>
							<td>${video.agencyName }</td>
							<td>${video.uploadName }</td>
							<td><p style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 100px;">${video.videoTitle }</p></td>
							<td><a href="${contextPath }/manage/work/audit.rt?id=${video.id}&viewId=2&leftId=3">详情</a></td>
						  </tr>
						  </c:forEach>
						</table>
					</div>
					<div class="bo"></div>
				</div>
				<!--时事消息.end-->
				<!--快捷操作-->
				<div class="dome3 both">
					<div class="tit">快捷操作</div>
					<div class="nr">
						<a href="${contextPath }/manage/video/add.rt?viewId=20&leftId=21"><img src="${contextPath}/images/video_1_03.jpg" /></a>
						<a href="${contextPath }/manage/pictureset/showAdd.rt?viewId=20&leftId=23"><img src="${contextPath}/images/picture_1_07.jpg" /></a>
						<a href="#"><img src="${contextPath}/images/shu_1_05.jpg" /></a>
						<a href="${contextPath }/manage/user/showAdd.rt?viewId=80&leftId=81"><img src="${contextPath}/images/user_1_09.jpg" /></a>
						<p class="cb"></p>
					</div>
					<div class="bo"></div>
				</div>
				<!--快捷操作.end-->
			</div>
			<div class="right">
				<!--站内信息-->
				<div class="dome4">
					<div class="tit">系统日志</div>
					<div class="nr">
						<table width="280" border="0">
						<c:forEach items="${logs.results }" var="log">
							<tr>
								<td>${log.agencyName }</td>
								<td>${log.operName }</td>
								<td>${log.description }</td>
							  </tr>
						</c:forEach>
						</table>
					</div>
					<div class="bo"></div>
				</div>
				<!--站内信息.end-->
			</div>
			<div class="cb"></div>
		</div>
	</div>
</div>

</body>
</html>

