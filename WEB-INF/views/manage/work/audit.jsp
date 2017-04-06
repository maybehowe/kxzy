<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="rt" uri="http://www.roots.com/tags/commons"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>科协资源管理平台</title>
<%@include file="../common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/js/xheditor/xheditor-1.1.14-zh-cn.min.js"></script>
<script type="text/javascript" src="${contextPath}/js/jwplayer-6.8/jwplayer.js"></script>
<script type="text/javascript">
/*<![CDATA[*/
$(function(){
	jwplayer("media_player").setup({
		"primary" : "flash",
	    "file" : "${contextPath}${video.path}",
 	    //"image":"${rt:prop('media_server')}/statics/src/jw-poster-adp.png",
 	    //"file" : "rtmpt://${rt:prop('media_server')}/rms/flv:${video.path}",
 	    'width': '640',
 	    'height': '360'
 	  });
	var count = "${video.heat }";
	for(var i=0;i<count ;i++){
		$("#star").find("li").each(function(j){
			if(i==j){
				$(this).addClass("on");
			}
		});
	}
 });
window.onload = function ()
{
	var oStar = document.getElementById("star");
	var aLi = oStar.getElementsByTagName("li");
	var oUl = oStar.getElementsByTagName("ul")[0];
	var oSpan = oStar.getElementsByTagName("span")[0];
	var oP = oStar.getElementsByTagName("p")[0];
	var i = iScore = iStar = 0;
	var aMsg = [
				"很不满意|差得太离谱，与卖家描述的严重不符，非常不满",
				"不满意|部分有破损，与卖家描述的不符，不满意",
				"一般|质量一般，没有卖家描述的那么好",
				"满意|质量不错，与卖家描述的基本一致，还是挺满意的",
				"非常满意|质量非常好，与卖家描述的完全一致，非常满意"
				]
	
	for (i = 1; i <= aLi.length; i++)
	{
		aLi[i - 1].index = i;
		//鼠标移过显示分数
		aLi[i - 1].onmouseover = function ()
		{
			//fnPoint(this.index);
			//浮动层显示
			//oP.style.display = "block";
			//计算浮动层位置
			//oP.style.left = oUl.offsetLeft + this.index * this.offsetWidth - 104 + "px";
			//匹配浮动层文字内容
			//oP.innerHTML = "<em><b>" + this.index + "</b> 分 " + aMsg[this.index - 1].match(/(.+)\|/)[1] + "</em>" + aMsg[this.index - 1].match(/\|(.+)/)[1]
		};
		//鼠标离开后恢复上次评分
		aLi[i - 1].onmouseout = function ()
		{
			//fnPoint();
			//关闭浮动层
			//oP.style.display = "none"
		};
		//点击后进行评分处理
		aLi[i - 1].onclick = function ()
		{
			//iStar = this.index;
			//oP.style.display = "none";
			//oSpan.innerHTML = "<strong>" + (this.index) + " 分</strong> (" + aMsg[this.index - 1].match(/\|(.+)/)[1] + ")"
			//$("#heat").val(this.index);
		}
	}
	//评分处理
	function fnPoint(iArg)
	{
		//分数赋值
		iScore = iArg || iStar;
		for (i = 0; i < aLi.length; i++) aLi[i].className = i < iScore ? "on" : "";	
	}
};
function audit(obj,id,status){
	$.ajax({
	   type: "POST",
	   url: "${contextPath}/manage/work/save.rt",
	   data: {"id":id,"status":status},
	   success: function(json){
	     if(json.flag){
	    	 window.location.href="${contextPath}/manage/work/list.rt?viewId="+${viewId}+"&leftId="+${leftId};
	     }
	   }
	}); 
}
/*]]>*/
</script>
</head>
<style> 
body,div,ul,li,p{margin:0;padding:0;}
body{color:#666;font:12px/1.5 Arial;}
ul{list-style-type:none;}
#star{position:relative;margin:10px auto;}
#star ul,#star span{float:left;display:inline;height:19px;line-height:19px;}
#star ul{margin:0 10px;}
#star li{float:left;width:24px;cursor:pointer;text-indent:-9999px;background:url(${contextPath}/images/star/star.png) no-repeat;}
#star strong{color:#f60;padding-left:10px;}
#star li.on{background-position:0 -28px;}
#star p{position:absolute;top:20px;width:159px;height:60px;display:none;background:url(${contextPath}/images/star/icon.gif) no-repeat;padding:7px 10px 0;}
#star p em{color:#f60;display:block;font-style:normal;}
</style>
<body>
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp" />
		<div class="right">
			<!--[if lt IE 8]><div class="both"></div><![endif]-->
			<div class="main">
				<div class="tit">添加视频</div>
				<div class="line">视频详情：</div>
				<form id="videoForm" name="videoForm" action="" method="post">
				<input type="hidden" name="viewId" value="${viewId }" />
				<input type="hidden" name="leftId" value="${leftId }" />
				<input type="hidden" name="video.id" value="${video.id }" />
				<table width="96%" border="0" class="data">
				  <tr>
					<th scope="row" width="110">所属分类：</th>
					<td >${video.category }</td>
					<td><span class="fl" id="columnIdTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" width="110">视频标题：</th>
					<td>${video.videoTitle }</td>
					<td><span class="fl" id="videoTitleTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" width="110">学科分类：</th>
					<td>${video.subject }</td>
					<td><span class="fl" id="disciplineCateIdTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" width="110">缩略图：</th>
					<td>
						大图：<img src="${contextPath}${video.bigPic}" alt="" width="330" height="300"/>
						小图：<img src="${contextPath}${video.smallPic}" alt="" height="100" width="185" />
					</td>
					<td><span class="fl" id="txtRoleNameTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" width="110">作者：</th>
					<td>${video.author }</td>
					<td><span class="fl" id="authorTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" width="110">视频源：</th>
					<td><div id="media_player"></div></td>
					<td><span class="fl" id="videoFileTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" width="110">视频来源：</th>
					<td>${video.resource }</td>
					<td><span class="fl" id="sourceIdTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" width="110">视频热度：</th>
					<td><input type="hidden" name="video.heat" id="heat" value="" />
						<div id="star">
						    <ul>
						        <li><a href="javascript:;">1</a></li>
						        <li><a href="javascript:;">2</a></li>
						        <li><a href="javascript:;">3</a></li>
						        <li><a href="javascript:;">4</a></li>
						        <li><a href="javascript:;">5</a></li>
						    </ul>
						    <span></span>
						    <p></p>
						</div>
					</td>
					<td><span class="fl" id="sourceIdTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" align="right">简介：</th>
					<td>${video.introduction }</td>
					<td><span class="fl" id="introductionTip"></span></td>
				  </tr>
				  <tr class="buttom">
					<th scope="row" align="right"></th>
					<td>
						<input name="" type="button" onclick="audit(this,${video.id},0)" value="同意" class="add_but fl" />
						<input name="" type="button" onclick="audit(this,${video.id},2)" value="不同意" class="add_but fl" />
						<a href="javascript:window.history.back();" class="but_fanhui fl" style="height:24px;border:0px;font-size:14px;color:white;font-weight:bold;">返 回</a>
					</td>
				  </tr>
				</table>
				</form>
			</div>
		</div>
		<div class="cb"></div>
	</div>
</div>
</body>
</html>
