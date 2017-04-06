<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
</head>
<script type="text/javascript">
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
	
	$(function(){
			$("#zj_three").click(function() {
			$("#zj_three_popup").css($(this).offset());
			$("#zj_three_popup ").width($(".left", this).width());
			$("#zj_three_popup").show();
		});
		
		$("#zj_three_popup .item").click(function() {
			$("#zj_three_popup .item.sel").removeClass("sel");
			$(this).addClass("sel");
			$("#zj_three .sel").text( $(this).text());
			var selectedCateId = $(this).attr("data-cate-id");
			$("#zj_three .sel").attr("data-cate-id", selectedCateId);
			$("#zj_three_popup").hide();
			switchExpert(selectedCateId);
		});
	});
	
	function switchExpert(selectedCateId) {
		window.location.href="${contextPath }/front/expert/index.rt?cateId="+selectedCateId+"&columnId=${columnId}#zj_three";
	}
	
</script>
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
		<div class="main">
			<!--热门搜索 开始-->
			<div class="ty_one" style="height: 20px">
				<div class="left" id="scrollDiv" style="margin-top: -15px">
				<ul>
					<c:forEach items="${top }" var="e">
						<li><a target="_blank" href="${contextPath }/front/expert/detail.rt?id=${e.id}&columnId=${columnId}">[推荐] ${e.userName }</a></li>
					</c:forEach>
				</ul>
				</div>
				<div class="right" style="margin-top: -35px">
				  <form id="searchForm" name="searchForm" action="${contextPath }/front/expert/list.rt" method="get">
				     <input type="hidden" name="columnId" value="${columnId }" />
				     <select name="cateId">
		        	    <option value="">全部</option>
		        	    <c:forEach items="${cateList }" var="cate">
		        	        <option value="${cate.id}">${cate.cateName}</option>
		        	    </c:forEach>
		        	 </select> 
					 <input type="text" name="searchName" class="txt" />
					 <input type="submit" class="btn" value="搜 索" />
					</form>
				</div>
			</div>
			<!--热门搜索 结束-->

			<!--专家风采-->
			<div class="zj_one">
				<div class="left">专家风采</div>
			</div>
			<ul class="zj_two">
				<c:forEach items="${epicycleList}" var="el">
				   <li>
				      <div class="nr">
				        <p class="img"><a href="${contextPath }/front/expert/detail.rt?id=${el.id}&columnId=${columnId}"><img src="${contextPath }/${empty el.thumbnailPath ? el.pictureUrl : el.thumbnailPath}" /></a></p>
				        <p class="name">${el.userName }</p>
				        <div class="jian">
				          <c:forEach items="${epicycleCateMap}" var="em" >
						      ${el.cateId eq em.key ? em.value : ''}
						   </c:forEach>
				        </div>
				        <div class="desc">
				        &nbsp;&nbsp;&nbsp;&nbsp;
				          <c:if test="${fn:length(el.introduction) <= 420}">
				             ${rt:escapeHtml(el.introduction)}
				          </c:if>
				          <c:if test="${fn:length(el.introduction) > 420}">
				             ${rt:escapeHtml(fn:substring(el.introduction, 0, 420))} ...... ......
				          </c:if>
				         </div>
				      </div>
				   </li>
				</c:forEach>
			</ul>
			<!--国家规定时间感觉都是加速度专家-->
			<div class="zj_three" id="zj_three">
		    	<div class="left">
		        	<div class="sel" data-cate-id="${selectedCate.id}">${selectedCate.cateName}</div>
		        </div>
				<a href="${contextPath }/front/expert/list.rt?cateId=${cate.id}&columnId=${columnId}" class="a_more">更多>></a>
			</div>
			<div class="zj_three_popup" id="zj_three_popup">
		       	<c:forEach items="${cateList}"  var="cl" varStatus="vs">
		       	   <div class="${cl.id eq selectedCate.id ? 'sel item':'item'}" data-cate-id="${cl.id}">${cl.cateName}</div>
		       	</c:forEach>
			</div>
			<ul class="zj_four">
			  <c:forEach items="${indexList}" var="il">
   				<li>
   				  <a href="${contextPath }/front/expert/detail.rt?id=${il.id}&columnId=${columnId}"><img src="${contextPath }/${empty il.thumbnailPath ? il.pictureUrl : il.thumbnailPath}" class="img" /></a>
				  <p class="name">${il.userName }</p>
				  <div class="desc">
			         <c:forEach items="${indexListCateMap}" var="im" >
					      ${il.cateId eq im.key ? im.value : ''}
		  		     </c:forEach>
				  </div>
				</li>
			  </c:forEach>
			</ul>
		</div>
		<!--main end-->
		</div>
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