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
<script type="text/javascript" src="${contextPath}/js/jwplayer-6.8/jwplayer.js"></script>
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/bootstrap.min.css" type="text/css"></link>
<script type="text/javascript" src="${contextPath}/bootstrap.sco/js/bootbox.min.js"></script>
<script type="text/javascript" src="${contextPath}/bootstrap.sco/js/bootstrap.min.js"></script>
<script type="text/javascript">
/*<![CDATA[*/
$(function(){
	jwplayer("media_player").setup({
		"primary" : "flash",
	    "file" : "${contextPath}${video.path}",
	    //"image":"${contextPath}/js/jwplayer-6.8/jw-poster-adp.png",
	    //"file" : "rtmpt://${rt:prop('media_server')}/rms/flv:${video.path}",//rtmpt\://192.168.17.3\:5080/rms/flv
	    'width': '1000',
	    'height': '520'
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
//检查下载按钮权限
function checkDownloadButton(){
	var url = "${contextPath}/front/permission/requestDownLoad.rt";
	var params = {
			"action" : "front.Video:download",
			"query" : "id=${video.id}&columnId=${columnId}"
		}; 
	$.post(url,params,function(result){
		if(result.success == "no_login"){
			bootbox.dialog({
				message : result.message,
				title : "消息提醒",
				buttons : {
					success : {
						label : "关闭",
						callback : function() {
							formSubmit();
						}
					}
				}
			});
		}else if(result.success){
			var download_url = "${contextPath}"+result.url;
			checkDownLoadUserRole(download_url);
		}else{
			bootbox.dialog({
				message : result.message,
				title : "消息提醒",
				buttons : {
					danger : {
						label : "关闭"
					}
				}
			});
		}
	});
}

//检查用户身份权限
function checkDownLoadUserRole(download_url){
	var url = "${contextPath}/front/video/checkDownLoadUserRole.rt";
	$.post(url,function(result){
		if(result.flag){
			window.location.href = download_url;
		}else{
			bootbox.dialog({
				message : result.message,
				title : "消息提醒",
				buttons : {
					danger : {
						label : "关闭"
					}
				}
			});
		}
	});
}

//执行下载
function videoDownload(url){
	$.post(url,function(result){
		if(!result.flag){
			bootbox.dialog({
				message : result.message,
				title : "消息提醒",
				buttons : {
					danger : {
						label : "关闭"
					}
				}
			});
		}
	});
}

/*]]>*/
</script>
</head>
<style> 
#star{position:relative;}
#star ul,#star span{float:left;display:inline;height:19px;line-height:19px;}
#star ul{margin:0 10px;}
#star li{float:left;width:24px;text-indent:-9999px;background:url(${contextPath}/front/images/star/star.png) no-repeat;}
#star strong{color:#f60;padding-left:10px;}
#star li.on{background-position:0 -28px;}
#star p{position:absolute;top:20px;width:159px;height:60px;display:none;background:url(${contextPath}/front/images/star/icon.gif) no-repeat;padding:7px 10px 0;}
#star p em{color:#f60;display:block;font-style:normal;}
</style>
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
		<p class="video_play_tit">${video.videoTitle }</p>
		<div class="media_player" id="media_player">
		
		</div>
		
		<div class="video_play_main">
			<table width="960" class="video_play_table">
			  <tr valign="top">
				<td width="65">视频名称：</td>
				<td colspan="3">${video.videoTitle }</td>
				<td rowspan="2" width="200" valign="middle">
				  <a href="javascript:void(0)" class="down" onclick="checkDownloadButton()"></a>
				 </td>
			  </tr>
			  <tr valign="top">
				<td>播放次数：</td>
				<td width="120">${video.playCount }次</td>
				<td width="180">上传时间：<fmt:formatDate value="${video.uploadTime }" pattern="yyyy-MM-dd"/></td>
				<td><span class="fl">视频热度：</span>
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
				</tr>
			  <tr valign="top">
				<td>视频简介：</td>
				<td colspan="4"><div style="width:890px;">${video.introduction }</div></td>
				</tr>
			</table>
		</div>
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
<!--<div class="bottom_png"></div>-->
</body>
</html>