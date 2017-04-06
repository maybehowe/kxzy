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
			<a href="${contextPath }/front/video/index.rt?columnId=27" class="logo"><img src="${contextPath }/front/images/img_logo.jpg" width="312" height="101" /></a>
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
		<div class="video_list_nav">
			<c:forEach items="${categoryes.childs }" var="cate">
			<div style="width:20%; float:left;">
				<div class="list_nav_l"></div><div class="list_nav_r"></div>
				<div class="list_nav_c <c:if test="${cate.id==categoryId }">hover</c:if>" ><a href="${contextPath }/front/video/list.rt?categoryId=${cate.id }&columnId=${columnId}">${cate.name }<p>${cate.englishName }</p></a></div>
			</div>
			</c:forEach>
			<div class="cb"></div>
		</div>
		<div class="video_list_search">
			<div class="search_div">
				<!--<p class="tit">检索类别：</p>-->
				<a href="${contextPath }/front/video/list.rt?categoryId=${channel.id}&columnId=${columnId}" style="background:#62a055;" class="<c:if test="${empty categoryChilId}">hover</c:if>">全部</a>
				<c:forEach items="${channel.childs}" var="cl" varStatus="idx">
				   <a href="${contextPath }/front/video/list.rt?categoryChilId=${cl.id}&categoryId=${cl.parent.id}&columnId=${columnId}" class="a${idx.index + 1} <c:if test="${cl.id==categoryChilId}">hover</c:if>">${cl.name}</a>
				</c:forEach>
			</div>
			<div class="search">
				<form id="searchForm" name="searchForm" action="${contextPath }/front/video/search.rt" method="get">
				<input type="hidden" name="columnId" value="${columnId }" />
					<select id="search_subCate" name="cateId" id="cateId">
						<option value="0">全部</option>
						<c:forEach items="${categoryes.childs}" var="cate">
							<option value="${cate.id}">${cate.name}</option>
						</c:forEach>
					</select>
					<input name="searchName" type="text" id="searchName" class="text" style="width:200px;" />
					<input name="" type="submit" value="搜 索" class="sub" />
				</form>
			</div>
		</div>
		<div class="video_list_main">
			<div class="list_main_top">
				<p class="tit">${categoryName }</p>
				<p class="dizhi">当前位置：首页 > ${channelName} > ${columnName } > ${categoryName }<c:if test="${not empty categoryChilName}"> > ${categoryChilName}</c:if></p>
				<p class="hot">
					<a href="${contextPath }/front/video/list.rt?categoryId=${categoryId }&columnId=${columnId}&video.order=1" class="one<c:if test="${video.order==1 ||video.order==null }"> hover</c:if>">最新</a>
					<a href="${contextPath }/front/video/list.rt?categoryId=${categoryId }&columnId=${columnId}&video.order=2" class="two<c:if test="${video.order==2 }"> hover</c:if>">最热</a>
					<a href="#" class="three">评分</a>
				</p>
				<form id="videoForm" name="videoForm" action="" method="post">
				<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
				<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
				<input type="hidden" name="categoryId" value="${categoryId }" />
				<input type="hidden" name="categoryChilId" value="${categoryChilId}" />
				<input type="hidden" name="columnId" value="${columnId }" />
				</form>
				<div class="list_main_div">
					<c:forEach items="${page.results }" var="video">
						<ul>
							<li class="img"><a target="_blank" href="${contextPath }/front/video/detail.rt?id=${video.id}&columnId=${columnId}">
							<img src="${contextPath }${video.smallPic}" onerror="this.src='${contextPath }/front/images/load.jpg'" height="100" width="180" />
							</a>
							</li>
							<li class="tit"><a target="_blank" href="${contextPath }/front/video/detail.rt?id=${video.id}&columnId=${columnId}">${video.videoTitle }</a></li>
							<li class="time">${video.playCount }次播放</li>
						</ul>
					</c:forEach>
					<div class="cb"></div>
				</div>
				<jsp:include page="../common/page.jsp" >
				<jsp:param value="${contextPath }/front/video/list.rt?video.order=${video.order }" name="pageUrl"/>
				<jsp:param value="videoForm" name="formName"/>
				</jsp:include>
			</div>
		</div>
		<img src="${contextPath }/front/images/list_03.jpg" width="1000" height="120" class="mt20" />
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
<!--<div class="bottom_png"></div>-->
</body>
</html>

