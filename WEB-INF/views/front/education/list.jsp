<%@page import="com.roots.kxzy.system.common.utils.StringUtils"%>
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
			marginTop : "-48px"
		}, 500, function() {
			$(this).css({
				marginTop : "0px"
			}).find("li:first").appendTo(this);
		});
	}
	$(document).ready(function() {
		setInterval('AutoScroll("#scrollDiv")', 3000)
	});
	function searchSubmit() {
		$("#curPage").val(1);
		$("#searchForm").submit();
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
								<c:if test="${child.id==columnId }"> class="hover"</c:if>>${child.name
								}</a>
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
						  <input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
						  <input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
						  <input type="hidden" name="columnId" value="${columnId }" />
			        	  <select name="cateId">
			        	    <option value="">全部</option>
			        	    <c:forEach items="${cateList }" var="cate">
			        	        <option <c:if test="${cate.id==cateId }">selected="selected"</c:if> value="${cate.id}">${cate.cateName}</option>
			        	    </c:forEach>
			        	  </select>
			              <input type="text" class="txt" name="searchName"/>
			              <input type="button" onclick="searchSubmit();" class="btn" value="搜 索" />
			            </form>
			        </div>
			    </div>
			    <!--热门搜索 结束-->
			    
			    <!--科普成果-->
			    <div class="cp_one"><span>${cate.cateName}</span></div>
			    <ul class="cp_two">
			       <c:forEach items="${page.results }" var="ps">
			          <li>
			        	<a href="${contextPath }/front/education/detail.rt?id=${ps.id}&columnId=${columnId}">
			        	<img src="${contextPath}/front/education/imageBig.rt?picId=${ps.isCover}" class="img" /></a>
			            <h3><a href="${contextPath }/front/education/detail.rt?id=${ps.id}&columnId=${columnId}">${ps.name}</a></h3>
			          </li>
			       </c:forEach>
			    </ul>
  				<jsp:include page="../common/page.jsp" >
				<jsp:param value="${contextPath }/front/education/list.rt" name="pageUrl"/>
				<jsp:param value="searchForm" name="formName"/>
				</jsp:include>
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