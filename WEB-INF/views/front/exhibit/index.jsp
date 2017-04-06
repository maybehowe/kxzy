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
<script type="text/javascript" src="${contextPath }/front/js//v2/jQuery.js"></script>
<script type="text/javascript" src="${contextPath }/front/js/v2/Xslider.js"></script>
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
		  <!--main start-->
			<div class="main">
				<!--热门搜索 开始-->
				<div class="ty_one" style="height: 20px">
				   <div class="left" id="scrollDiv" style="margin-top: -15px">
					  <ul>
						<c:forEach items="${top}" var="ps">
							<li><a target="_blank" href="${contextPath }/front/exhibit/detail.rt?id=${ps.id}&columnId=${columnId}">[推荐] ${ps.name }</a></li>
						</c:forEach>
					  </ul>
					</div>
			        <div class="right" style="margin-top: -35px">
			           <form id="searchForm" name="searchForm" action="${contextPath }/front/exhibit/list.rt" method="get">
						  <input type="hidden" name="columnId" value="${columnId }" />
			        	  <select name="cateId">
			        	    <option value="">全部</option>
			        	    <c:forEach items="${cateList }" var="cate">
			        	        <option value="${cate.id}">${cate.cateName}</option>
			        	    </c:forEach>
			        	  </select>
			              <input type="text" class="txt" name="searchName"/>
			              <input type="submit" class="btn" value="搜 索" />
			            </form>
			        </div>
			    </div>
			    <!--热门搜索 结束-->
			    <c:forEach items="${list}" var="idnexlist" varStatus="index">
			      <c:if test="${index.index == 0 }">
     			     <c:forEach items="${idnexlist}" var="l">
			            <!--科普成果-->
					    <div class="jd_title">
					    	<span> ${l.key.cateName}</span>
					        <a href="${contextPath }/front/exhibit/list.rt?cateId=${l.key.id}&columnId=${columnId}">更多</a>
					    </div>
					    <div id="slider3" class="cp_three">
			              <div class="conbox">
			          		<c:forEach items="${l.value}" var="page" varStatus="ps_index">
		          		      <div>
			          		    <ul>
			          		     <c:forEach items="${page}" var="ps" varStatus="index">
			          		       <li class="<c:if test="${index.index == 0 || index.index == 1 || index.index == 2}">li</c:if>">
		                            <a href="${contextPath }/front/exhibit/detail.rt?id=${ps.id}&columnId=${columnId}">
		                              <img src="${contextPath}/front/exhibit/imageBig.rt?picId=${ps.isCover}" />
		                              <p class="bottom">
		                                <span> 
                                           <c:if test="${fn:length(ps.description) <= 200}">
								             ${ps.description}
								           </c:if>
								           <c:if test="${fn:length(ps.description) > 200}">
								             ${fn:substring(ps.description, 0, 200)} ...... ......
								           </c:if>
		                                 </span>
		                              </p>
		                    	     </a>
		                           </li>
			          		     </c:forEach>
		                       </ul>
		                      </div>
		                    </c:forEach>
		                  </div>
		                   <div class="switcher">
					          <c:forEach items="${l.value}" varStatus="ps_index">
		                        <a href="#" class="<c:if test="${ps_index.index == 1}">cur</c:if>"></a>
		                      </c:forEach>
					        </div>
		               </div>
			         </c:forEach>
			      </c:if>
			      <c:if test="${index.index == 1 }">
			         <c:forEach items="${idnexlist}" var="l">
			            <!--科普成果-->
					    <div class="jd_title">
					    	<span> ${l.key.cateName}</span>
					        <a href="${contextPath }/front/exhibit/list.rt?cateId=${l.key.id}&columnId=${columnId}">更多</a>
					    </div>
					    <div id="slider1" class="cp_four">
			              <div class="conbox">
			          		<c:forEach items="${l.value}" var="page" varStatus="ps_index">
		          		      <div>
			          		     <c:forEach items="${page}" var="ps" varStatus="index">
    		     		           <c:choose>
				          		       <c:when test="${index.index == 0 || index.index == 7}">
				          		          <dl class="left">
				                            <a href="${contextPath }/front/exhibit/detail.rt?id=${ps.id}&columnId=${columnId}">
				                              <dd><img src="${contextPath}/front/exhibit/imageBig.rt?picId=${ps.isCover}" /></dd>
				                              <dt>
				                                 <span>
                                                   <c:if test="${fn:length(ps.description) <= 100}">
										             ${ps.description}
										           </c:if>
										           <c:if test="${fn:length(ps.description) > 100}">
										             ${fn:substring(ps.description, 0, 100)} ...... ......
										           </c:if>  
				                                 </span>
				                              </dt>
				                    	     </a>
				          		           </dl>
				          		         </c:when>
				          		         <c:otherwise>
				          		          <c:if test="${index.index == 1}"><ul></c:if>
				          		          <c:if test="${index.index == 8 }"><ul class="ul"></c:if>
						          		      <li>
					                            <a href="${contextPath }/front/exhibit/detail.rt?id=${ps.id}&columnId=${columnId}">
					                              <img src="${contextPath}/front/exhibit/imageBig.rt?picId=${ps.isCover}" />
					                              <p class="bottom">
					                                <span> 
					                                   <c:if test="${fn:length(ps.description) <= 100}">
											             ${ps.description}
											           </c:if>
											           <c:if test="${fn:length(ps.description) > 100}">
											             ${fn:substring(ps.description, 0, 100)} ...... ......
											           </c:if>  
					                                </span>
					                              </p>
					                    	     </a>
					                           </li>
					                        <c:if test="${index.index == 6 || index.index == 9}"></ul></c:if>
				          		         </c:otherwise>
				          		       </c:choose>
			          		     </c:forEach>
		                      </div>
		                    </c:forEach>
		                  </div>
		                    <div class="switcher">
		                      <c:forEach items="${l.value}" varStatus="ps_index">
		                        <a href="#" class="<c:if test="${ps_index.index == 1}">cur</c:if>"></a>
		                      </c:forEach>
					        </div>
		               </div>
			         </c:forEach>
			      </c:if>
			    </c:forEach>
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