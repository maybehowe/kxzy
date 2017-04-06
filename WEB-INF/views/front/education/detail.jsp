<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="rt" uri="http://www.roots.com/tags/commons"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>浙江省科普资源共享服务平台</title>
<%@include file="../common/form.jsp"%>
<meta name="description" content="浙江省科普资源共享服务平台" />
<meta name="keywords" content="浙江省科普资源共享服务平台" />
<meta name="copyright" content="杭州融坦软件科技有限公司" />
<meta name="author" content="杭州融坦软件科技有限公司" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<link href="${contextPath }/front/css/video.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${contextPath }/front/css/css.css" />
<script type="text/javascript" src="${contextPath }/front/js/v2/common.js"></script>
<script type="text/javascript" src="${contextPath}/js/jwplayer-6.8/jwplayer.js"></script>
<script type="text/javascript" src="${contextPath }/front/js/galleria/galleria-1.3.5.js"></script>
<%-- <link rel="stylesheet" href="${contextPath }/front/js/galleria/themes/classic/galleria.classic.css" /> --%>


<%-- <link rel="shortcut icon" href="${contextPath }/favicon.ico" type="image/x-icon" /> --%>
<%-- <script type="text/javascript" src="${contextPath }/front/js/galleria/galleria-1.3.5.js"></script> --%>
<link rel="stylesheet" href="${contextPath }/front/js/galleria/themes/azur/galleria.azur.css" />

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
</head>
<script type="text/javascript">
	$(function(){
		jwplayer("media_player").setup({
			"primary" : "flash",
		    "file" : "${contextPath}${picSet.videoPath}",
		    //"image":"${contextPath}/js/jwplayer-6.8/jw-poster-adp.png",
		    //"file" : "rtmpt://${rt:prop('media_server')}/rms/flv:${picSet.videoPath}",//rtmpt\://192.168.17.3\:5080/rms/flv
		    'width': '335',
		    'height': '250'
		 });
		 // Load the classic theme
    Galleria.loadTheme('${contextPath }/front/js/galleria/themes/azur/galleria.azur.min.js');
	
    Galleria.ready( function(){
    	this.play(5000);
    });

    // Initialize Galleria
    Galleria.run('#galleria');
	});
	function AutoScroll(obj) {
		$(obj).find("ul:first").animate({
			marginTop : "-40px"
		}, 500, function() {
			$(this).css({
				marginTop : "0px"
			}).find("li:first").appendTo(this);
		});
	}
	$(document).ready(function() {
		setInterval('AutoScroll("#scrollDiv")', 3000)
	});
	
	/* $(function(){
		// Load the classic theme
	    Galleria.loadTheme('${contextPath }/front/js/galleria/themes/classic/galleria.classic.min.js');
	    Galleria.ready( function(){
	    	this.play(3000);
	    });
	    // Initialize Galleria
	    Galleria.run('#galleria');
	}); */
	
	$(function() {
		$(".btn-slide").click(function(){
			$("#panel").slideToggle("slow");
			$(this).toggleClass("active");
			return false; 
		});
		
		$(".btn").click(function(){
			var psId = $(".jd_eight select").find("option:selected").val();
			window.location.href = "${contextPath}/front/education/detail.rt?id="+psId+"&columnId=${columnId}";
		});
	})
</script>
<style type="text/css">
.glyphicon-hide{
	display: none;
}
#galleria {
	height: 380px;
}
.tuji a:hover{ text-decoration: underline;}
</style>
<body>
	<div class="wrapper">
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
		<!--main start-->
		<div class="main">
		   	<!--热门搜索 开始-->
			<div class="ty_one" style="height: 20px">
			   <div class="left" id="scrollDiv" style="margin-top: -15px">
				  <ul>
					<c:forEach items="${top}" var="ps">
						<li><a target="_blank" href="${contextPath }/front/education/detail.rt?id=${ps.id}&columnId=${columnId}">[推荐] ${ps.name }</a></li>
					</c:forEach>
				  </ul>
				</div>
		        <div class="right" style="margin-top: -35px">
		           <form id="searchForm" name="searchForm" action="${contextPath }/front/education/list.rt" method="get">
					  <input type="hidden" name="columnId" value="${columnId }" />
		        	  <select name="cateId">
		        	    <option value="">全部</option>
		        	    <c:forEach items="${cateList }" var="cate">
		        	        <option <c:if test="${cate.id==cateId }">selected="selected"</c:if> value="${cate.id}">${cate.cateName}</option>
		        	    </c:forEach>
		        	  </select>
		              <input type="text" class="txt" name="searchName"/>
		              <input type="submit"  class="btn" value="搜 索" />
		            </form>
		        </div>
		    </div>
            <div class="cp_one"><span>${cate.cateName}</span></div>
			  <p class="slide"><img  src="${contextPath}/front/images/v2/01.png" href="javascript:;" rel="external nofollow" class="btn-slide"></p>
			  <div style="display: block;" id="panel">
			  	<ul class="new">
		          <c:forEach items="${picSetFinalList }" var="ps">
		             <li><a href="${contextPath }/front/education/detail.rt?id=${ps.id}&columnId=${columnId}">${ps.name}</a></li>
		          </c:forEach>
				</ul>
			  </div>  
	        <div class="jd_six">
		      <div class="col-md-9" style="margin-bottom:20px;">
				<div class="panel panel-default" style="height: 100%">
					<div class="panel-body">
						<div id="galleria">
						<c:forEach items="${picList}" var="pic">
				            <a href="${contextPath }/front/education/image.rt?picId=${pic.id}">
				                <img 
				                    src="${contextPath }/front/education/thumbnail.rt?picId=${pic.id}&size=176"
				                    data-title=" "
				                    data-description="<c:out value='${pic.picDescription}' escapeXml='true'/>"
				                >
				            </a>
						</c:forEach>
			            </div>
					</div>
				</div>
			  </div>
	          <div class="bottom" style="margin-top: -10px">
		        	<h1>${picSet.name } 介绍：</h1>
		            <div class="desc" style="font-family: 微软雅黑;">
		            	&nbsp;&nbsp;
           	          <c:if test="${fn:length(picSet.description) <= 200}">
			             ${rt:escapeHtml(picSet.description)}
			          </c:if>
			          <c:if test="${fn:length(picSet.description) > 200}">
			             ${rt:escapeHtml(fn:substring(picSet.description, 0, 200))} ...... ......
			          </c:if>
		            </div>
		      </div>
		    </div>
	        <div class="jd_right">
		    	<div class="jd_seven">
		        	<div class="top" >
		        	   <div class="media_player" id="media_player"></div>
		        	</div>
		            <div class="bottom">
		            	<a href="#">视频信息</a>
		                <span>上传时间：<fmt:formatDate pattern="yyyy-MM-dd" value="${picSet.videoTime}" /></span>
		            </div>
		        </div>
		        <div class="jd_eight">
		        	<span class="sel">友情链接</span>
		            <select class="txt" style="height: 45px;width: 63.75%">
            		  <c:forEach items="${picSetFinalList }" var="ps">
			             <option value="${ps.id}">${ps.name}</option>
			          </c:forEach>
		            </select>
		            <input type="button" class="btn" value="GO" style="height: 45px"/>
		        </div>
		    	<div class="jd_nine">
		        	<img src="${contextPath}/front/detailimage/09.jpg" />
		        </div>
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
	    	<div class="right">Copyright &copy; 2014 All Rights Reserved 浙ICP备05008719号  技术支持：浙江科协</div>
	    </div>
	</div>
	<!--footer end-->
</body>
</html>