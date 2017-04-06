<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="rt" uri="http://www.roots.com/tags/commons"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科普场馆</title>
<%@include file="../common/form.jsp" %>
<link rel="stylesheet" type="text/css" href="${contextPath }/style-res2/css/css.css"/>
<link href="${contextPath }/front/css/video.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${contextPath }/front/css/css.css" />
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=PEmsTFv4c7PPlIcMPDcfcc91"></script>
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

$(function(){
	setInterval('AutoScroll("#scrollDiv")', 3000);
	
	$("#simpleSearchBtn").click(function() {
    	var museumName = encodeURIComponent($("#simpleSearchTxt").val());
    	var url = "${contextPath}/front/museum/list.rt?columnId=147&museum.name="+museumName;
    	window.location.href=url;
    });
	
	var citiePositions = [{
		"position" : {
			"left" : 264,
			"top" : 80
		},
		"name" : "湖州市"
	}, {
		"position" : {
			"left" : 373,
			"top" : 76
		},
		"name" : "嘉兴市"
	}, {
		"position" : {
			"left" : 544,
			"top" : 150
		},
		"name" : "舟山市"
	}, {
		"position" : {
			"left" : 213,
			"top" : 208
		},
		"name" : "杭州市"
	}, {
		"position" : {
			"left" : 347,
			"top" : 222
		},
		"name" : "绍兴市"
	}, {
		"position" : {
			"left" : 463,
			"top" : 209
		},
		"name" : "宁波市"
	}, {
		"position" : {
			"left" : 136,
			"top" : 360
		},
		"name" : "衢州市"
	}, {
		"position" : {
			"left" : 291,
			"top" : 314
		},
		"name" : "金华市"
	}, {
		"position" : {
			"left" : 442,
			"top" : 335
		},
		"name" : "台州市"
	}, {
		"position" : {
			"left" : 252,
			"top" : 458
		},
		"name" : "丽水市"
	}, {
		"position" : {
			"left" : 375,
			"top" : 489
		},
		"name" : "温州市"
	}];
	
	var mapContainer = $("#mapContainer");
	for(var i=0;i<citiePositions.length;i++) {
		var city = citiePositions[i];
		var style = "style='left:"+city.position.left+"px; top:"+city.position.top+"px;'";
		var html =
			["<a class='city-name' href='javascript:void(0)' "+style+">",
			 city.name,
			 "</a>"].join("");
		mapContainer.append(html);
	}
	$(".city-name", mapContainer).click(function(){
		var city = $(this).text();
		location.href="./list.rt?cityName="+encodeURIComponent(city)
	});
});

function searchSubmit() {
	$("#curPage").val(1);
	$("#searchForm").submit();
}
</script>
<style>
#mapContainer .city-name {
 position: absolute;
 z-index: 999;
 font-size: 16px;
 display: block;
 color: black;
 font-weight: 500;
}
#mapContainer .city-name:hover {
	text-decoration: none;
	color: rgb(30,93,161);
 	font-weight: 700;
}
</style>
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
			<c:forEach items="${top }" var="e">
				<li><a target="_blank" href="${contextPath }/front/museum/detail.rt?id=${e.id}&columnId=${columnId}">[推荐] ${e.name }</a></li>
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
			 <input type="text" name="searchName" class="txt" />
			 <input type="submit" class="btn" value="搜 索" />
			</form>
		</div>
	</div>
    <!--热门搜索 结束-->
    
    <!--科普场馆-->
    <div class="cg_one" id="mapContainer" style="position: relative;">
   		
	    <img style="position: absolute;" src="${contextPath }/style-res2/images/map_no_cityname.png" />
    </div>
    <div class="cg_two" style="height:auto; ">
    	<a href="${contextPath }/front/museum/detail.rt?columnId=147&id=${rightMuseum.id}" style="text-decoration: none;">
    	  <h2>${rightMuseum.name}</h2>
    	</a>
        <a href="${contextPath }/front/museum/detail.rt?columnId=147&id=${rightMuseum.id}">
          <img src="${contextPath }/manage/museum/picture/image.rt?picId=${rightMuseumPictureId}" class="img" />
        </a>
        <div class="top2">科普馆介绍</div>
        <div class="bottom" style="font-family:微软雅黑; height:338px">
          &nbsp;&nbsp;&nbsp;&nbsp;
          <c:if test="${fn:length(rightMuseum.descript) <= 250}">
             ${rightMuseum.descript}
          </c:if>
          <c:if test="${fn:length(rightMuseum.descript) > 250}">
             ${fn:substring(rightMuseum.descript, 0, 250)} ...... ...... 
          </c:if>
        </div>
    </div>
    <div class="cg_three"> <img src="${contextPath }/style-res2/images/img_03.png" />国家级科普场馆</div>
    <ul class="cg_four">
    	<li>
    	<c:forEach items="${nationMuseums}" varStatus="vs" var="museum">
        	<p>
        		<c:if test="${museum.id eq -1}">
        			<a href="javascript:void(0)">${museum.name}</a>
        		</c:if>
        		<c:if test="${museum.id ne -1}">
        			<a href="${contextPath }/front/museum/link.rt?columnId=147&museumId=${museum.id}">${museum.name}</a>
        		</c:if>
       		</p>
        	<c:if test="${(vs.index +1)%4 eq 0 and vs.index ne 19}">
	        </li>
	        <li>
        	</c:if>
    	</c:forEach>
        </li>
    </ul>
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

