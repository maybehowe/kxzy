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
<script language="javascript">
function AutoScroll(obj){
        $(obj).find("ul:first").animate({
                marginTop:"-48px"
        },500,function(){
                $(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
        });
}
$(document).ready(function(){
	setInterval('AutoScroll("#scrollDiv")',3000);
	if(${firstChannId!=0}){
		$("#secandCoulunId").attr("style","");
	}
	
});

function searchSelect(obj){
	var id = $(obj).val();
	$("#secandCoulunId").html("");
	$("#cateId").val("");
	if(id>0){
		$.ajax({
		   type: "POST",
		   url: "${contextPath}/front/picture/loadChannel.rt?id="+id,
		   success: function(json){
			   if(json != null && json != ''){
				    var html='';
			     	$(json).each(function(i,item){
			    		 html +='<option value="'+item.id+'">'+item.name+'</option>';
			     	});
			     	$("#secandCoulunId").append(html);
			     	$("#secandCoulunId").attr("style","");
			   }
		   }
		});
	} else {
		$("#secondView").html("");
		$("#secandCoulunId").attr("style","display:none;");
	}
}
function searchSubmit(){
	$("#searchForm").attr("action","${contextPath}/front/picture/search.rt");
	$("#curPage").val(1);
	$("#searchForm").submit();
}
</script>
</head>

<body>
<div class="wrapper">
	<div class="top">
		<div class="content">
			<a href="#" class="logo"><img src="${contextPath }/front/images/img_logo.jpg" width="312" height="101" /></a>
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
					<li<c:if test="${index.index==categoryes.childs.size()-1 }"> style="margin-right:0px;"</c:if><c:if test="${cate.id==categoryId }"> class="hover"</c:if>>
						<a href="${contextPath }/front/picture/list.rt?categoryId=${cate.id}&columnId=${columnId}">${cate.name }</a>
					</li>
				</c:forEach>
			</ul>
			<div class="cb"></div>
		</div>
		<div class="video_list_search">
			<div id="scrollDiv">
				<ul>
					<c:forEach items="${list }" var="pic">
						<li><a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${pic.id}">[推荐] ${pic.name }</a></li>
					</c:forEach>
				</ul>
			</div>
			<div class="search">
				<form id="searchForm" name="searchForm" action="" method="post">
				<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
				<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
				<input type="hidden" name="cateId" id="cateId" value="${cateId }" />
				<input type="hidden" name="columnId" value="${columnId }" />
				<select name="firstChannId" id="firstChannId" onchange="searchSelect(this);">
				  <option value="0">全部</option>
				  <c:forEach items="${categoryes.childs }" var="cate">
				  <option<c:if test="${cate.id==firstChannId }"> selected="selected"</c:if> value="${cate.id}">${cate.name }</option>
				  </c:forEach>
				</select>
				<select name="secandCoulunId" id="secandCoulunId" style="display: none;">
				 <c:forEach items="${secCate.childs }" var="cate">
				  <option<c:if test="${cate.id==secandCoulunId }"> selected="selected"</c:if> value="${cate.id}">${cate.name }</option>
				  </c:forEach>
				</select>
				<input name="searchName" id="searchName" type="text" class="text" value="<c:out value="${searchName }" escapeXml="true" />"/>
				<input name="" type="button" value="搜 索" class="sub" onclick="searchSubmit();"/>
				</form>
			</div>
		</div>
		<div class="video_list_main">
			<div class="list_main_top">
				<p class="tit">搜索</p>
				<p class="dizhi">当前位置：首页 > ${channelName} > ${columnName } > 搜索</p>
				<form id="picForm" name="picForm" action="" method="post">
				<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
				<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
				<input type="hidden" name="categoryId" value="${categoryId }" />
				<input type="hidden" name="columnId" value="${columnId }" />
				</form>
				<div class="list_main_div">
					<c:forEach items="${page.results }" var="pic">
						<ul>
							<li class="img">
								<a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${pic.id}">
								<img src="${contextPath}/front/picture/thumbnail.rt?picId=${pic.isCover}&size=176" onerror="this.src='${contextPath }/front/images/load.jpg'" width="175" height="134" />
								</a>
							</li>
							<li class="tit"><a target="_blank" href="${contextPath }/front/picture/detail.rt?id=${pic.id}">${pic.title }</a></li>
							<li class="time"><fmt:formatDate value="${pic.createTime }" pattern="yyyy-MM-dd HH:mm:ss" /></li>
						</ul>
					</c:forEach>
					<div class="cb"></div>
				</div>
				<jsp:include page="../common/page.jsp" >
				<jsp:param value="${contextPath }/front/picture/search.rt" name="pageUrl"/>
				<jsp:param value="searchForm" name="formName"/>
				</jsp:include>
			</div>
		</div>
		
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
<!--<div class="bottom_png"></div>-->
<script type="text/javascript">
<!--
var Ptr=document.getElementById("search").getElementsByTagName("li");
function b() {
    for (i=1;i<Ptr.length+1;i++) { 
    Ptr[i-1].className = (i%2>0)?"t1":""; 
    }
}
window.onload=b;
//-->
</script>
</body>
</html>

