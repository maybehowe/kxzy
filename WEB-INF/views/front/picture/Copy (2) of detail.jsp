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
<link href="${contextPath }/front/css/allinone_thumbnailsBanner.css" rel="stylesheet" type="text/css">
<script src="${contextPath }/front/js/jquery-ui.min.js"></script>
<script src="${contextPath }/front/js/allinone_thumbnailsBanner.js" type="text/javascript"></script>
<script type="text/javascript">
/*<![CDATA[*/
$(function(){
	$('#Banner_simple').allinone_thumbnailsBanner({
		skin: 'simple',
		numberOfThumbsPerScreen:7,
		width: 960,
		height: 384,
		thumbsReflection:0,
		defaultEffect: 'random'
	});	
});
/*]]>*/
</script>
</head>
<style type="text/css">
*{margin:0;padding:0;list-style-type:none;}
a,img{border:0;}
body{font:12px/180% Arial, Helvetica, sans-serif, "新宋体";}
.bannerbox{background:url(jquery ui幻灯片插件带进度条自动轮播滤镜百叶窗图片切换_files/simpleBg.jpg) no-repeat 50% 0;}
.bannerbox .frame960{width:960px;height:400px;margin:0 auto;padding:60px 0 0 0;}
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
	
		<div class="bannerbox" style="height: 600px;">
			<div class="frame960">
				<div id="Banner_simple">
					<ul class="Banner_list">
						<li data-bottom-thumb="${contextPath }/front/images/01_simple.jpg" data-text-id="#photoText1"><img src="${contextPath }/front/images/adde8400gw1e45qldu0yfj20qo0ao418.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/02_simple.jpg" data-text-id="#photoText2"><img src="${contextPath }/front/images/adde8400gw1e45qls1yctj20qo0aoacr.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/03_simple.jpg" data-text-id="#photoText3"><img src="${contextPath }/front/images/adde8400gw1e45qm2rnzgj20qo0aoac7.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/04_simple.jpg" data-text-id="#photoText4"><img src="${contextPath }/front/images/adde8400jw1e45qmb4deij20qo0aoq5s.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/05_simple.jpg" data-text-id="#photoText5"><img src="${contextPath }/front/images/adde8400jw1e45qmj98stj20qo0aotbh.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/01_simple.jpg" data-text-id="#photoText1"><img src="${contextPath }/front/images/adde8400gw1e45qldu0yfj20qo0ao418.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/02_simple.jpg" data-text-id="#photoText2"><img src="${contextPath }/front/images/adde8400gw1e45qls1yctj20qo0aoacr.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/03_simple.jpg" data-text-id="#photoText3"><img src="${contextPath }/front/images/adde8400gw1e45qm2rnzgj20qo0aoac7.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/04_simple.jpg" data-text-id="#photoText4"><img src="${contextPath }/front/images/adde8400jw1e45qmb4deij20qo0aoq5s.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/05_simple.jpg" data-text-id="#photoText5"><img src="${contextPath }/front/images/adde8400jw1e45qmj98stj20qo0aotbh.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/01_simple.jpg" data-text-id="#photoText1"><img src="${contextPath }/front/images/adde8400gw1e45qldu0yfj20qo0ao418.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/02_simple.jpg" data-text-id="#photoText2"><img src="${contextPath }/front/images/adde8400gw1e45qls1yctj20qo0aoacr.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/03_simple.jpg" data-text-id="#photoText3"><img src="${contextPath }/front/images/adde8400gw1e45qm2rnzgj20qo0aoac7.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/04_simple.jpg" data-text-id="#photoText4"><img src="${contextPath }/front/images/adde8400jw1e45qmb4deij20qo0aoq5s.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/05_simple.jpg" data-text-id="#photoText5"><img src="${contextPath }/front/images/adde8400jw1e45qmj98stj20qo0aotbh.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/01_simple.jpg" data-text-id="#photoText1"><img src="${contextPath }/front/images/adde8400gw1e45qldu0yfj20qo0ao418.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/02_simple.jpg" data-text-id="#photoText2"><img src="${contextPath }/front/images/adde8400gw1e45qls1yctj20qo0aoacr.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/03_simple.jpg" data-text-id="#photoText3"><img src="${contextPath }/front/images/adde8400gw1e45qm2rnzgj20qo0aoac7.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/04_simple.jpg" data-text-id="#photoText4"><img src="${contextPath }/front/images/adde8400jw1e45qmb4deij20qo0aoq5s.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/05_simple.jpg" data-text-id="#photoText5"><img src="${contextPath }/front/images/adde8400jw1e45qmj98stj20qo0aotbh.jpg" alt="" /></li>
						<li data-bottom-thumb="${contextPath }/front/images/02_simple.jpg" data-text-id="#photoText2"><img src="${contextPath }/front/images/adde8400gw1e45qls1yctj20qo0aoacr.jpg" alt="" /></li>
					</ul>
		
					<div id="photoText1" class="photo_texts">
						<div class="text_line textElement11_simple" data-initial-left="0" data-initial-top="60" data-final-left="0" data-final-top="307" data-duration="0.5" data-fade-start="0" data-delay="0">
							&nbsp;&nbsp;&nbsp;UP TO <a href="http://www.17sucai.com" target="_blank">4 TYPES</a> OF SLIDERS<br />&nbsp;&nbsp;&nbsp;Each with multiple SKINS
						</div>
					</div>
					
					<div id="photoText2" class="photo_texts">
						<div class="text_line textElement21_simple" data-initial-left="200" data-initial-top="60" data-final-left="45" data-final-top="60" data-duration="0.5" data-fade-start="0" data-delay="0">
							<span style="font-weight:bold;">16 TRANSITION EFFECTS<br />FOR IMAGES</span><br />optional can set the transition<br />for each image
						</div>
					</div>
					
					<div id="photoText3" class="photo_texts">
						<div class="text_line textElement31_simple" data-initial-left="70" data-initial-top="160" data-final-left="70" data-final-top="60" data-duration="0.5" data-fade-start="0" data-delay="0">
							<span>Animated text from any direction</span><br /><span style="text-transform:uppercase;font-weight:bold;">top, bottom, left<br />and right</span><br />Any color, CSS and HTML formated
						</div>
					</div>
					
					<div id="photoText4" class="photo_texts">
						<div class="text_line textElement41_simple" data-initial-left="100" data-initial-top="60" data-final-left="480" data-final-top="60" data-duration="0.5" data-fade-start="0" data-delay="0">
							<span style="text-transform:uppercase; font-weight:bold;">16 transition effects<br />for images</span><br />optional can set the transition<br />for each image
						</div>
					</div>
					
					<div id="photoText5" class="photo_texts">
						<div class="text_line textElement51_simple" data-initial-left="0" data-initial-top="200" data-final-left="0" data-final-top="0" data-duration="0.5" data-fade-start="0" data-delay="0">
							<span style="font-weight:bold;text-transform:uppercase;">Up to 4 types of <a href="http://www.17sucai.com" target="_blank">sliders</a></span><br />Each with multiple skins
						</div>
					</div>
		
				</div>
			</div>
		</div>
		
		
		上一个图集<span>${prevPic.id }-- ${prevPic.name }</span>+++++ ${picSet.id }--${picSet.name }+++++
		下一个图集<span>${nextPic.id }-- ${nextPic.name }</span>
		
		
		
		
		
		
		
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
<!--<div class="bottom_png"></div>-->
</body>
</html>