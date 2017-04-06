<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科普场馆详情-${museum.name }</title>
<%@include file="../common/form.jsp" %>
<link href="${contextPath }/front/css/video.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${contextPath }/front/css/css.css" />
<script type="text/javascript" src="${contextPath }/style-res2/js/common.js"></script>
<script type="text/javascript" src="${contextPath }/style-res2/js/bxCarousel.js"></script>
<script type="text/javascript" src="${contextPath }/front/js/galleria/galleria-1.3.5.js"></script>
<script type="text/javascript" src="${contextPath}/js/jwplayer-6.8/jwplayer.js"></script>
<%-- <link rel="stylesheet" href="${contextPath }/front/js/galleria/themes/classic/galleria.classic.css" /> --%>

<link rel="stylesheet" href="${contextPath }/front/js/galleria/themes/azur/galleria.azur.css" />

<style type="text/css">
.glyphicon-hide{
	display: none;
}
#galleria {
	height: 600px;
}
.tuji a:hover{ text-decoration: underline;}
</style>
<script type="text/javascript">
function AutoScroll(obj) {
	$(obj).find("ul:first").animate({
		marginTop : "-48px"
	}, 500, function() {
		$(this).css({
			marginTop : "0px"
		}).find("li:first").appendTo(this);
	});
}

$(function(){
/* 		// Load the classic theme
    Galleria.loadTheme('${contextPath}/front/js/galleria/themes/classic/galleria.classic.min.js');
    Galleria.ready( function(){
    	this.play(2000);
    });
    // Initialize Galleria
    Galleria.run('#galleria'); */
    		 // Load the classic theme
    Galleria.loadTheme('${contextPath }/front/js/galleria/themes/azur/galleria.azur.min.js');
	
    Galleria.ready( function(){
    	this.play(5000);
    });

    // Initialize Galleria
    Galleria.run('#galleria');
    
    var player = jwplayer("media_player");
    var videoPath = "${museum.videoPath}";
    var imgage,videoFile;
    var playerOptions = {
   	    "primary" : "flash",
   	    'width': '320',
   	    'height': '320'
   	 };
    if (/.+\.mp4$/.test(videoPath)) {
    	playerOptions.file = "${contextPath}" + videoPath;
    } else {
    	playerOptions.image = "${contextPath}/images/videos/error.png";
    	playerOptions.file = "${contextPath}/images/videos/default.mp4";
    }
    console.log(playerOptions);
    player.setup(playerOptions);
    
    setInterval('AutoScroll("#scrollDiv")', 3000);
});

function searchSubmit() {
	$("#curPage").val(1);
	$("#searchForm").submit();
}
</script>
</head>

<body>
 <div class="wrapper">
   <!--header start-->
	<div class="top">
		<div class="content">
			<a href="${contextPath }/front/museum/index.rt?columnId=147" class="logo"><img
				src="${contextPath }/front/images/v2/img_logo.jpg" width="312"
				height="101" />
			</a>
			<div class="top_right">
				<div id="login">
					<jsp:include page="../common/login.jsp" />
				</div>
				<div class="weibo">
					<a href="${contextPath}/building.jsp" target="_blank"
						class="txweibo" title="腾讯微博"></a> <a href="http://weibo.com/zikp"
						class="xlweibo" target="_blank" title="新浪微博"></a>
				</div>
				<div class="nav">
					<c:forEach items="${columnes.childs }" var="child">
						<a href="${contextPath }${child.siteUrl}" style="text-decoration: none;"
							<c:if test="${child.id==columnId }"> class="hover"</c:if>>${child.name}</a>
					</c:forEach>
					<a href="${contextPath }/" class="bank"><img
						src="${contextPath }/front/images/bank.jpg" />
					</a>
				</div>
			</div>
		</div>
	</div>
<!--header end-->

<!--main start-->
<div class="main">
	<!--热门搜索 开始-->
	<div class="ty_one" style="height: 20px">
		<div class="left" id="scrollDiv" style="margin-top: -15px">
		  <ul>
			<c:forEach items="${top}" var="m">
				<li><a target="_blank" href="${contextPath }/front/museum/detail.rt?id=${m.id}&columnId=${columnId}">[推荐] ${m.name }</a></li>
			</c:forEach>
		  </ul>
		</div>
        <div class="right" style="margin-top: -35px">
           <form id="searchForm" name="searchForm" action="${contextPath }/front/museum/list.rt" method="get">
			  <input type="hidden" name="columnId" value="${columnId }" />
        	  <select name="type">
        	    <option value="">全部</option>
  	         	<option value="1">省内场馆</option>
        	    <option value="2">国内场馆</option>
        	  </select>
              <input type="text" class="txt" name="searchName"/>
              <input type="button" onclick="searchSubmit();" class="btn" value="搜 索" />
            </form>
        </div>
    </div>
    <!--热门搜索 结束-->
    
    <!--浙江省科普场馆-->
    <div class="cp_one">
      <span>
         <c:if test="${museum.type == 1 }">
            ${museum.cityName}科普场馆
         </c:if>
         <c:if test="${museum.type == 2}">
           国内科普场馆
         </c:if>
      </span>
    </div>
   	<div class="cg_five">
    	<div class="left">${museum.name}</div>
        <a href="#" class="a">GO</a>
        <a href="#" class="a">访问原网站</a>
    </div>
    <div class="jd_six" >
    	<div id="galleria" style="height: 380px;">
			<c:forEach items="${pictures}" var="pic">
	            <a href="${contextPath }/front/museum/image.rt?picId=${pic.id}">
	                <img 
	                    src="${contextPath }/front/museum/thumbnail.rt?picId=${pic.id}&size=176"
	                    data-title=" "
	                    data-description="<c:out value='${pic.picDescription}' escapeXml='true'/>"
	                >
	            </a>
			</c:forEach>
    	</div>
    </div>
    <div class="jd_seven cg_six">
        <div class="top">
        	<div class="media_player" id="media_player"></div>
        </div>
        <div class="bottom">
            <a href="#">视频信息</a>
            <span>上传时间：<fmt:formatDate value="${museum.videoTime}" pattern="yyyy-MM-dd" /></span>
        </div>
    </div>
    <div class="cg_seven">
    	<div class="top2">科普馆介绍</div>
        <div class="bottom">
        	${museum.descript}
        </div>
    </div>
    <!--其他科普场馆-->
    <div class="cg_five">
    	<div class="left">其他科普场馆</div>
    </div>
    <div class="cg_eight">
        <a href="#" class="prev"></a>
        <a href="#" class="next"></a>
        <ul  id="example">
        <c:forEach items="${otherList}" var="otMuseum">
            <li>
            	<a href="${contextPath }/front/museum/detail.rt?id=${otMuseum.id}">
            		<img src="${contextPath }/front/museum/thumbnail.rt?picId=${otMuseum.isCover}&size=176" />
            	</a>
            	<p>
            		<a href="${contextPath }/front/museum/detail.rt?columnId=147&id=${otMuseum.id}">${otMuseum.name}</a>
            	</p>
            </li>
        </c:forEach>
        </ul>
    </div>
</div>
<!--main end-->
</div>
<!--footer start-->
<div class="footer">
	<div class="desc">
    	<div class="left">
    	 <a href="${pageContext.request.contextPath}/front/about/aboutByCate.rt?channelId=115&cateId=1">联系我们</a>
    	 |<a href="${pageContext.request.contextPath}/front/about/aboutByCate.rt?channelId=115&cateId=3">网站简介</a>
    	 |<a href="${pageContext.request.contextPath}/front/about/aboutByCate.rt?channelId=115&cateId=2">版权声明</a>
    	</div>
    	<div class="right">Copyright © 2014 rongtan.com All Rights Reserved 浙ICP备1234567 技术支持：杭州融坦</div>
    </div>
</div>
<!--footer end-->

</body>
</html>
