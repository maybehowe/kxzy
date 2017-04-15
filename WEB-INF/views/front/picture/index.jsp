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
<link href="${contextPath }/front/css/images.css" rel="stylesheet" type="text/css" />
<link href="${contextPath }/front/css/foucsbox.css" rel="stylesheet" type="text/css" />
<script src="${contextPath }/front/js/foucsbox.js" type="text/javascript"></script>
<script src="${contextPath }/front/js/tab2.js" type="text/javascript"></script>
<!--[if lt IE 10]>
<script type="text/javascript" src="js/PIE.js"></script>
<![endif]-->
<script language="javascript">
function a() {
    if (window.PIE) {
        $('.rounded').each(function() {
            PIE.attach(this);
        });
    }
};
function AutoScroll(obj){
        $(obj).find("ul:first").animate({
                marginTop:"-48px"
        },500,function(){
                $(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
        });
}
$(document).ready(function(){
	setInterval('AutoScroll("#scrollDiv")',3000);
});

function searchSelect(obj){
	var id = $(obj).val();
	if(id>0){
		$.ajax({
		   type: "POST",
		   url: "${contextPath}/front/picture/loadChannel.rt?id="+id,
		   success: function(json){
			   if(json != null && json != ''){
				    var html='';
			     	html +='<select name="secandCoulunId" id="secandCoulunId">';
			     	$(json).each(function(i,item){
			    		 html +='<option value="'+item.id+'">'+item.name+'</option>';
			     	});
			     	html +='</select>';
			     	$("#searchSelect").html(html);
			   }
		   }
		});
	} else {
		$("#searchSelect").html("");
	}
}

function searchSubmit(){
	$("#searchForm").attr("action","${contextPath}/front/picture/search.rt");
	$("#searchForm").submit();
}
</script>
</head>

<body>
<div class="wrapper">
	<div class="top">
		<div class="content">
			<a href="${contextPath }/front/video/index.rt?columnId=28" class="logo"><img src="${contextPath }/front/images/img_logo.jpg" width="312" height="101" /></a>
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
		<div class="images_nav">
			<ul>
				<c:forEach items="${categoryes.childs }" var="cate" varStatus="index">
					<li<c:if test="${index.index==categoryes.childs.size()-1 }"> style="margin-right:0px;"</c:if>> <%--<c:if test="${cate.id==categoryId }"> class="hover"</c:if>--%>
						<a href="#${cate.id }">${cate.name }</a>
					</li>
				</c:forEach>
			</ul>
			<div class="cb"></div>
		</div>
		<!--banner 代码 开始 -->
		<div id="foucsBox">
			<ul class="imgCon">
				<!--展示图片开始-->
				<c:forEach items="${pageFour}" var="pic">
					<li><a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${pic.id}&columnId=${columnId}">
						<img width="650" height="310" src="${contextPath }/front/picture/imageHomeBig.rt?picId=${pic.isCover}" onerror="this.src='${contextPath }/front/images/load.jpg'" />
						</a>
						<div class="imgTitle"><a href="#">${pic.name }</a></div>
						<div class="showPage"></div>
					</li>
				</c:forEach>
				<!--展示图片结束-->
			</ul>
			<div class="foucs"></div>
			<div class="rBtn foucsButton">
				<span></span>
				<img />
			</div>
			<div class="lBtn foucsButton">
				<span></span>
				<img />
			</div>
		</div>
		<!--banner 代码 结束 -->
		<div class="phb">
			<div class="phb_title">
				<span>最近更新</span>
			</div>
			<ul>
				<c:forEach items="${ranking.results }" var="pic">
					<li><a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${pic.id}">组图：${pic.name }</a></li>
				</c:forEach>
			</ul>
		</div>
		<div class="cb"></div>
		<div class="video_list_search" style="margin-top:20px;">
			<div id="scrollDiv">
				<ul>
				<c:forEach items="${list }" var="pic">
					<li><a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${pic.id}">[推荐] ${pic.name }</a></li>
				</c:forEach>
				</ul>
			</div>
			<div class="search">
				<form id="searchForm" name="searchForm" action="" method="get">
				<input type="hidden" name="categoryId" value="${categoryId }" />
				<input type="hidden" name="columnId" value="${columnId }" />
				<select name="firstChannId" id="firstChannId" onchange="searchSelect(this);">
				  <option value="0">全部</option>
				  <c:forEach items="${categoryes.childs }" var="cate">
				  <option value="${cate.id}">${cate.name }</option>
				  </c:forEach>
				</select>
				<span id="searchSelect"></span>
				<input name="searchName" id="searchName" type="text" class="text" />
				<input name="" type="button" value="搜 索" class="sub" onclick="searchSubmit();"/>
				</form>
			</div>
		</div>

		<c:forEach items="${array }" var="pic" varStatus="index">
			<div class="images_list<c:if test="${index.index==1 ||index.index==4}">2</c:if>">
			<div class="images_list_top">
			<p class="tit">${pic.name } <a id="${pic.id }" name="${pic.id }"> </a></p>
			<ul id="tab${index.index+1 }" class="tab">
				<c:forEach items="${pic.cates }" var="cate" varStatus="index1">
					<li index="${index1.index}" <c:if test="${index1.index==0 }"> class="title"</c:if>>${cate.cateName }</li>
				</c:forEach>
			</ul>
			<a target="_blank" href="${contextPath }/front/picture/list.rt?categoryId=${pic.id}&columnId=${columnId}" class="more">更多</a>
			</div>
			<div class="images_list_top_ie"></div>
			<div id="content${index.index+1 }" class="images_list_nr">
				<c:forEach items="${pic.childs }" var="child" varStatus="index2">
				<div class="newslist"<c:if test="${index2.index==0 }"> style="display:block;"</c:if>>
				<c:set var="bool" value="false"/>
					<c:forEach items="${child.contents }" var="childPic" varStatus="index3">
					<c:if test="${(index.index==0 || index.index==3) && (index3.index==0) }">
					<ul class="left">
						<li class="first_li">
							<a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${childPic.id}">
								<img src="${contextPath}/front/picture/imageBig.rt?picId=${childPic.isCover}" onerror="this.src='${contextPath }/front/images/load.jpg'" />
							</a>
						</li>
						<li class="tit">${childPic.title }</li>
						<li class="nr">${childPic.description }</li>
					</ul>
					<c:set var="bool" value="true"/>
					</c:if>
					<c:if test="${(index.index==2 || index.index==5) && (index3.index==0)}">
					<ul class="left" style="float:right;">
						<li  class="first_li"><a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${childPic.id}">
						<img src="${contextPath}/front/picture/imageBig.rt?picId=${childPic.isCover}" onerror="this.src='${contextPath }/front/images/load.jpg'"/></a></li>
						<li class="tit">${childPic.title }</li>
						<li class="nr">${childPic.description }</li>
					</ul>
					</c:if>
					<c:if test="${index3.index==0 }">
					<ul<c:if test="${index.index==0 ||index.index==3}"> class="right"</c:if><c:if test="${index.index==2 ||index.index==5}"> class="right2"</c:if><c:if test="${index.index==1 ||index.index==4}"> class="main"</c:if>>
					</c:if>
						<c:if test="${bool }">
						<c:if test="${(index3.index>0)}">
						<li>
							<p class="img"><a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${childPic.id}">
							<img src="${contextPath}/front/picture/thumbnail.rt?picId=${childPic.isCover}&size=176" onerror="this.src='${contextPath }/front/images/load.jpg'" /></a></p>
							<p class="tit2"><a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${childPic.id}">${childPic.title }</a></p>
						</li>
						</c:if>
						</c:if>
						<c:if test="${!bool }">
						<c:if test="${(index.index==1) || index.index==4 }">
						<li>
							<p class="img"><a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${childPic.id}">
							<img src="${contextPath}/front/picture/thumbnail.rt?picId=${childPic.isCover}&size=176" onerror="this.src='${contextPath }/front/images/load.jpg'"/></a></p>
							<p class="tit2"><a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${childPic.id}">${childPic.title }</a></p>
						</li>
						</c:if>
						</c:if>
						<c:if test="${!bool }">
						<c:if test="${index.index==2|| index.index==5}">
						<c:if test="${index3.index>0 }">
						<li>
							<p class="img"><a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${childPic.id}">
							<img src="${contextPath}/front/picture/thumbnail.rt?picId=${childPic.isCover}&size=176" onerror="this.src='${contextPath }/front/images/load.jpg'"/></a></p>
							<p class="tit2"><a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${childPic.id}">${childPic.title }</a></p>
						</li>
						</c:if>
						</c:if>
						</c:if>
					<c:if test="${index3.index==child.contents.size()-1}">
					</ul>
					<p class="cb"></p>
					</c:if>
				</c:forEach>
				</div>
				</c:forEach>
			</div>
		</div>
		</c:forEach>

		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
<!--<div class="bottom_png"></div>-->
<script src="${contextPath }/front/js/tab_ctrl.js" type="text/javascript"></script>
</body>
</html>

