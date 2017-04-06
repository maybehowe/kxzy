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
<link href="${contextPath }/front/css/list.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath }/front/js/list.js"></script>
<script type="text/javascript">
/*<![CDATA[*/

/*]]>*/
</script>
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
	
		<div class="scrolltab">
			<span id="sLeftBtnA" class="sLeftBtnA"></span>
			<span id="sRightBtnA" class="sRightBtnA"></span>
			<ul class="ulBigPic">
				<li class="">
					<span class="sPic">
						<i class="iBigPic"><a href="http://www.17sucai.com/" target="_blank" title="东南亚民族风的家 品味跨时空异域情怀">
							<center><img alt="大图" max-width="860" max-height="860" src="${contextPath }/front/images/01.jpg"></center>
						</a></i>
					</span>
					<span class="sSideBox">
						<span class="sTitle"><a href="http://www.17sucai.com/" target="_blank" title="东南亚民族风的家 品味跨时空异域情怀">东南亚民族风的家 品味跨时空异域情怀</a></span>
						<span class="sIntro">简介： 东南亚风格的家居物品多用实木、竹、藤、麻等材料打造，比如印度尼西亚的藤、马来西亚河道里的水草以及泰国的木皮等等纯天然的材质。 这些材质会使居室显得自然古朴，彷佛沐浴着阳光雨露般舒畅。正所谓其崇尚自然、原汁、原味的特点， 被越来越多的人喜爱。</span>
						<span class="sMore"><a href="http://www.17sucai.com/" target="_blank">查看详细方案&gt;&gt;</a></span>
					</span>
				</li>
				<li class="">
					<span class="sPic">
						<i class="iBigPic"><a href="http://www.17sucai.com/" target="_blank" title="永恒的经典  黑白家居带您回味每一秒的精彩"><img alt="大图" width="960" height="420" src="${contextPath }/front/images/02.jpg"></a></i>			</span>
					<span class="sSideBox">
						<span class="sTitle"><a href="http://www.17sucai.com/" target="_blank" title="永恒的经典  黑白家居带您回味每一秒的精彩">永恒的经典  黑白家居带您回味每一秒的精彩</a></span>	
						<span class="sIntro">简介： 黑色与白色的格调都给人时尚的家居感觉。透过多元材质搭配、对比色彩铺排，整个空间立即个性鲜明，令人印象深刻。经典就是经典，任何时候都不会过时。</span>
						<span class="sMore"><a href="http://www.17sucai.com/" target="_blank">查看详细方案&gt;&gt;</a></span>
					</span>
				</li>	
				<li class="">
					<span class="sPic">
						<i class="iBigPic"><a href="http://www.17sucai.com/" target="_blank" title="蓝色格调 倾力打造幸福家居魅力"><img alt="大图" width="860" height="620" src="${contextPath }/front/images/03.jpg"></a></i>			</span>
					<span class="sSideBox">
						<span class="sTitle"><a href="http://www.17sucai.com/" target="_blank" title="蓝色格调 倾力打造幸福家居魅力">蓝色格调 倾力打造幸福家居魅力</a></span>
						<span class="sIntro">简介： 　蓝色拥有这样一种魅力，能让空间的气氛安静了下来，一切的喧嚣扰嚷似乎都被隔绝在屋外。无论在外有多么的疲惫与烦躁，回到家，回到这个宁静的港湾，一切压力都可以被它包容、被它融化。生活变得简单而舒适。</span>
						<span class="sMore"><a href="http://www.17sucai.com/" target="_blank">查看详细方案&gt;&gt;</a></span>
					</span>
				</li>	
				<li class="">
					<span class="sPic">
						<i class="iBigPic"><a href="http://www.17sucai.com/" target="_blank" title="迷你小客厅 萌翻你的家"><img alt="大图" width="560" height="820" src="${contextPath }/front/images/04.jpg"></a></i>			</span>
					<span class="sSideBox">
						<span class="sTitle"><a href="http://www.17sucai.com/" target="_blank" title="迷你小客厅 萌翻你的家">迷你小客厅 萌翻你的家</a></span>
						<span class="sIntro">简介： 迷你小客厅，时尚的设计，精巧的家具，让小客厅也变得更宽敞了许多。鲜活的色彩可以营造浪漫、可以妆点时尚，让我们共同来了解一下迷你小客厅的搭配吧。</span>
						<span class="sMore"><a href="http://www.17sucai.com/" target="_blank">查看详细方案&gt;&gt;</a></span>
					</span>
				</li>
				<li class="">
					<span class="sPic">
						<i class="iBigPic"><a href="http://www.17sucai.com/" target="_blank" title="时尚的诱惑 5000元搭出摩登五彩客厅"><img alt="大图" width="560" height="420" src="${contextPath }/front/images/05.jpg"></a></i>			</span>
					<span class="sSideBox">
						<span class="sTitle"><a href="http://www.17sucai.com/" target="_blank" title="时尚的诱惑 5000元搭出摩登五彩客厅">时尚的诱惑 5000元搭出摩登五彩客厅</a></span>
						<span class="sIntro">简介： 色彩的多样能够为家居带来焕然一新的变化，正如时装服饰每年都有流行色彩，家居也有流行色。家居空间，依据各厅室相互间的功能关系组合形成，通过功能空间相互渗透，家居的美感、舒适以及空间的利用率才能达到最高。巧妙利用空间，打造出具有不同创意的灵动空间！</span>
						<span class="sMore"><a href="http://www.17sucai.com/" target="_blank">查看详细方案&gt;&gt;</a></span>
					</span>
				</li>
				<li class="liSelected">
					<span class="sPic">
						<i class="iBigPic"><a href="http://www.17sucai.com/" target="_blank" title="实用又百搭 同一款沙发的不同搭配"><img alt="大图" width="560" height="420" src="${contextPath }/front/images/06.jpg"></a></i>			</span>
					<span class="sSideBox">
						<span class="sTitle"><a href="http://www.17sucai.com/" target="_blank" title="实用又百搭 同一款沙发的不同搭配">实用又百搭 同一款沙发的不同搭配</a></span>
						<span class="sIntro">简介： &lt;p&gt;中国传统室内设计融合了庄重与优雅双重气质，简单的一套沙发就可以搭配出古典、时尚、大气的家居客厅。家具颜色体现着中式的古朴，配上不同的软装，表现出不同的空间，在传统中透着现代，在现代中揉着古典，&lt;/p&gt;</span>
						<span class="sMore"><a href="http://www.17sucai.com/" target="_blank">查看详细方案&gt;&gt;</a></span>
					</span>
				</li>
				<li class="">
					<span class="sPic">
						<i class="iBigPic"><a href="http://www.17sucai.com/" target="_blank" title="炫出好心情 多彩沙发搭出缤纷现代感客厅"><img alt="大图" width="560" height="420" src="${contextPath }/front/images/07.jpg"></a></i>			</span>
					<span class="sSideBox">
						<span class="sTitle"><a href="http://www.17sucai.com/" target="_blank" title="炫出好心情 多彩沙发搭出缤纷现代感客厅">炫出好心情 多彩沙发搭出缤纷现代感客厅</a></span>
						<span class="sIntro">简介： 热情的波普、鲜艳的色彩，多元的几何，展现出客厅的与众不同，有个性爱张扬，让美家尽情炫起来。</span>
						<span class="sMore"><a href="http://www.17sucai.com/" target="_blank">查看详细方案&gt;&gt;</a></span>
					</span>
				</li>
				<li class="">
					<span class="sPic">
						<i class="iBigPic"><a href="http://www.17sucai.com/" target="_blank" title="水韵深邃 东南亚风情家具软装搭配"><img alt="大图" width="560" height="420" src="${contextPath }/front/images/08.jpg"></a></i>			</span>
					<span class="sSideBox">
						<span class="sTitle"><a href="http://www.17sucai.com/" target="_blank" title="水韵深邃 东南亚风情家具软装搭配">水韵深邃 东南亚风情家具软装搭配</a></span>
						<span class="sIntro">简介： 东南亚家居设计秉承了原生态风情，追求自然美，在快节奏的今天能享受、聆听原生态风情已经是一种享受，一起去感受那最美妙的声音吧。</span>
						<span class="sMore"><a href="http://www.17sucai.com/" target="_blank">查看详细方案&gt;&gt;</a></span>
					</span>
				</li>
			</ul><!--ulBigPic end-->
			<div class="cb"></div>
			<div style="float:left;width:110px; font-size:12px; border:1px solid #ccc; padding:5px;">
				<p><img alt="炫出好心情 多彩沙发搭出缤纷现代感客厅" src="${contextPath }/front/images/s07.jpg" width="110" height="100"></p>
				<p class="sTitle">永恒的经典  黑白家居带您回味每一秒的精彩</p>
			</div>
			<div class="dSmallPicBox" style="float:left;">
				<div class="dSmallPic">
					<ul class="ulSmallPic" style="width: 2646px; left: 0px; " rel="stop">
						<li class="">
							<span class="sPic"><img alt="东南亚民族风的家 品味跨时空异域情怀" src="${contextPath }/front/images/s01.jpg" width="110" height="100"></span>
						</li>
						<li class="">
							<span class="sPic"><img alt="永恒的经典  黑白家居带您回味每一秒的精彩" src="${contextPath }/front/images/s02.jpg" width="110" height="100"></span>
						</li>
						<li class="">
							<span class="sPic"><img alt="蓝色格调 倾力打造幸福家居魅力" src="${contextPath }/front/images/s03.jpg" width="110" height="100"></span>
						</li>
						<li class="">
							<span class="sPic"><img alt="迷你小客厅 萌翻你的家" src="${contextPath }/front/images/s04.jpg" width="110" height="100"></span>
						</li>
						<li class="">
							<span class="sPic"><img alt="时尚的诱惑 5000元搭出摩登五彩客厅" src="${contextPath }/front/images/s05.jpg" width="110" height="100"></span>
						</li>
						<li class="">
							<span class="sPic"><img alt="实用又百搭 同一款沙发的不同搭配" src="${contextPath }/front/images/s06.jpg" width="110" height="100"></span>
						</li>
						<li>
							<span class="sPic"><img alt="炫出好心情 多彩沙发搭出缤纷现代感客厅" src="${contextPath }/front/images/s07.jpg" width="110" height="100"></span>
						</li>
						<li>
							<span class="sPic"><img alt="水韵深邃 东南亚风情家具软装搭配" src="${contextPath }/front/images/s08.jpg" width="110" height="100"></span>
						</li>
					</ul>
				</div>
				<span id="sLeftBtnB" class="sLeftBtnBBan"></span>
				<span id="sRightBtnB" class="sRightBtnB"></span>
			</div><!--dSmallPicBox end-->
			<div style="float:right; width:110px; font-size:12px; border:1px solid #ccc; padding:5px;">
				<p><img alt="炫出好心情 多彩沙发搭出缤纷现代感客厅" src="${contextPath }/front/images/s07.jpg" width="110" height="100"></p>
				<p class="sTitle">永恒的经典  黑白家居带您回味每一秒的精彩</p>
			</div>
			<div class="cb"></div>
		</div>
		
		
		
		
		
		
		
		
		
		
		
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
<!--<div class="bottom_png"></div>-->
</body>
</html>