<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>科协资源管理平台</title>
<%@include file="../common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<script src="${contextPath}/js/validator/formValidator-4.1.3.js" type="text/javascript" ></script>
<script src="${contextPath}/js/validator/formValidatorRegex.js" type="text/javascript"></script>
<script type="text/javascript" src="${contextPath}/js/xheditor/xheditor-1.1.14-zh-cn.min.js"></script>
<link rel="stylesheet" href="${contextPath }/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css" />
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.exedit-3.5.js"></script>
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.excheck-3.5.js"></script>
<script src="${contextPath}/js/jquery.divbox.js" type="text/javascript"></script>
<style type="text/css">
.ztree {
	overflow: auto; height: 183px;
	margin-bottom:10px;
}
#divSCA{
	width: 202px;
	height: 245px;
	font-size: 12px;
	background: #fff;
	border: 1px solid #B8CAE0;
	z-index: 10001;
	display: none;
	padding-top:10px;
  }
#divSCA a.channel_div_btn{ background:#379DD5; padding:0 6px;font-size: 14px;color: white;font-family: "微软雅黑"}
</style>
<script type="text/javascript">
/*<![CDATA[*/
$(document).ready(function(){
	$.formValidator.initConfig({formID:"videoForm",theme:"Default",submitOnce:true,
		onSuccess:function(){dispayDiv();return true;}});
	$("#video_channelId").formValidator({onShow:"请选择所属分类",onFocus:"所属分类必须选择",onCorrect:"选择正确"}).inputValidator({min:1,onError: "请选择所属分类"});
 	$("#videoTitle").formValidator({onShowText:"请输入视频标题",onShow:"请输入视频标题",onFocus:"视频标题至少1个字符,最多40个字符",onCorrect:"该视频标题可以使用"}).inputValidator({min:1,max:40,empty:{leftEmpty:false,rightEmpty:false,emptyError:"标题两边不能有空符号"},onError:"你输入的视频标题长度非法,请确认"});
 	$("#disciplineCateId").formValidator({onShow:"请选择学科分类",onFocus:"学科分类必须选择",onCorrect:"选择正确"}).inputValidator({min:0,onError: "请选择学科分类"});
	$("#author").formValidator({empty:true,onShow:"请输入作者",onFocus:"请输入20个字符作者",onCorrect:"输入正确"}).inputValidator({min:1,max:20,onError:"输入的作者长度不正确，请确认"});
	$("#bigFile").formValidator({empty:true,triggerEvent:"change",onShow:"请选择要上传 330px*300px 的图片文件 ", onFocus:"请选择 330px*300px 的图片文件", onCorrect:"此文件可用" }).inputValidator({min:1, empty:{leftEmpty:false,emptyError:"不允许有空格 "}, onError:"必须选择要上传的图片文件" }).regexValidator({regExp:"picture",dataType:"enum",onError:"图片格式不正确 " });
	$("#smallFile").formValidator({empty:true,triggerEvent:"change",onShow:"请选择要上传 180px*100px 的图片文件 ", onFocus:"请选择 180px*100px 的图片文件", onCorrect:"此文件可用" }).inputValidator({min:1, empty:{leftEmpty:false,emptyError:"不允许有空格 "}, onError:"必须选择要上传的图片文件" }).regexValidator({regExp:"picture",dataType:"enum",onError:"图片格式不正确 " });
	$("#sourceId").formValidator({onShow:"请选择视频来源",onFocus:"视频来源必须选择",onCorrect:"选择正确"}).inputValidator({min:0,onError: "请选择视频来源"});
	$("#introduction").formValidator({onShow:"请输入视频简介",onFocus:"请输入视频简介",onCorrect:"输入正确"}).inputValidator({min:1,onError:"输入的描述长度不正确，请确认"});
	loadTree();
}); 

function dispayDiv(){
	$("#tishi").show();
	var html ='<img src="${contextPath}/images/auth.gif"/>';
	$("#loading").html(html);
}
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
			fnPoint(this.index);
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
			fnPoint();
			//关闭浮动层
			oP.style.display = "none"
		};
		//点击后进行评分处理
		aLi[i - 1].onclick = function ()
		{
			iStar = this.index;
			oP.style.display = "none";
			//oSpan.innerHTML = "<strong>" + (this.index) + " 分</strong> (" + aMsg[this.index - 1].match(/\|(.+)/)[1] + ")"
			$("#heat").val(this.index);
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

	//树
	var channelTree;
	function loadTree() {
		var setting = {
			async : {
				enable : false
			},
			data : {
				key : {
					name : "name"
				},
				simpleData : {
					enable : true,
					idKey : "id",
					pIdKey : "parentId",
					rootPId : 0
				}
			},
			view : {
				selectedMulti : true
			},
			check: {
				enable: true,
				chkStyle: "radio",
				radioType : "all"
			}
		};
		var url = "${contextPath}/manage/video/getTreeData.rt";
		$.post(url, function(result) {
			initTree(result)
			for(var i = 0; i < result.length; i++) {
				result[i].icon = "${contextPath}/images/7.png";
			}
			channelTree = $.fn.zTree.init($("#channelTree"), setting, result);
			channelTree.expandAll(true);
		});
	};
	
	function initTree(nodes){
		for (var i = 0; i < nodes.length ; i++) {
			var parentId =  nodes[i].parentId;
			if(parentId == 27){
				nodes[i].nocheck = true;
			}else{
				nodes[i].nocheck = false;
			}
		}
	}
	//展开收起
	function treeExpandAll(type) {
		channelTree = $.fn.zTree.getZTreeObj("channelTree");
		channelTree.expandAll(type);
	};
	//刷新
	function reFresh() {
			loadTree();
	};
	//选择分类
	function selectchannel(){
		cateTree = $.fn.zTree.getZTreeObj("channelTree");
		var nodes  = cateTree.getCheckedNodes(true);
		var id="";
		var name = "";
	 for (var i = 0; i < nodes.length; i++) {
	 	id += nodes[i].id + ",";
	     name +=  nodes[i].name + ",";
		}
		id = id.substring(0, id.length -1);
		name = name.substring(0, name.length -1);
		$("#video_channelId").val(id);
		$("#videoName").val(name);
		$("#divSCA").CloseDiv();
	}
	
	function openDiv() {
		$("#divSCA").OpenDiv();
	}
	function closeDiv() {
		$("#divSCA").CloseDiv();
	}

/*]]>*/
</script>
</head>
<style> 
#star{position:relative;}
#star ul,#star span{float:left;display:inline;height:19px;line-height:19px;}
#star li{float:left;width:24px;cursor:pointer;text-indent:-9999px;background:url(${contextPath}/images/star/star.png) no-repeat;}
#star strong{color:#f60;padding-left:10px;}
#star li.on{background-position:0 -28px;}
#star p{position:absolute;top:20px;width:159px;height:60px;display:none;background:url(${contextPath}/images/star/icon.gif) no-repeat;padding:7px 10px 0;}
#star p em{color:#f60;display:block;font-style:normal;}
</style>
<body>
<div class="wrapper">
<div id="tishi" style="position: absolute; top: 0px; background: none repeat scroll 0% 0% rgb(119, 119, 119); opacity: 0.6; left: 0px; width: 100%; height: 100%; z-index: 100;display: none;">
	<div id="loading" style="background: none repeat scroll 0% 0% white; position: absolute; border:3px solid #333; left: 45%; top: 45%; width: 100px; height: 40px; padding-top:7px; text-align: center; z-index: 101;">
		<img src="${contextPath}/images/auth.gif"/>
	</div>
</div>
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp" />
		<div class="right">
			<!--[if lt IE 8]><div class="both"></div><![endif]-->
			<div class="main">
				<div class="tit">添加视频</div>
				<div class="line">视频详情：</div>
				<form id="videoForm" name="videoForm" action="${contextPath}/manage/video/save.rt" method="post" enctype="multipart/form-data">
				<input type="hidden" name="viewId" value="${viewId }" />
				<input type="hidden" name="leftId" value="${leftId }" />
				<table width="96%" border="0" class="data">
				  <tr>
					<th scope="row" width="110"><span style="color:red;">*</span> 所属分类：</th>
					<td width="330">
					  <input type="hidden" class="text" id="video_channelId" name="video.columnId" style="width: 190px"/>
					  <input type="text" class="text" id="videoName" name="videoName" style="width: 190px" onfocus="this.blur()"/>
					  <input type="button" value="选择" onclick="openDiv()"/>
					  <div id="divSCA">
						<div>
							<span style="padding-left: 35px;">
								<a class="channel_div_btn" id="treeFresh" href="javascript:reFresh();">刷新</a>
								<a class="channel_div_btn" id="treeExpandAll" href="javascript:treeExpandAll(true)">展开</a>
								<a class="channel_div_btn" id="treeCollapseAll" href="javascript:treeExpandAll(false)">收起</a>
							</span>
						</div>
					    <ul id="channelTree" class="ztree"></ul>
					    <span style="padding-left: 55px;">
					      <a class="channel_div_btn" id="treeCollapseAll" href="javascript:selectchannel();">选择</a>
					      <a class="channel_div_btn" id="treeCollapseAll" href="javascript:closeDiv();">取消</a>
					    </span>
				   	  </div>
					</td>
					<td colspan="2"><span class="fl" id="video_channelIdTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" width="110"><span style="color:red;">*</span> 视频标题：</th>
					<td><input name="video.videoTitle" type="text" class="text" id="videoTitle" /></td>
					<td colspan="2"><span class="fl" id="videoTitleTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" width="110"><span style="color:red;">*</span> 学科分类：</th>
					<td>
						<select name="video.disciplineCateId" id="disciplineCateId">
							<c:forEach items="${subes }" var="s">
								<option value="${s.id }">${s.name }</option>
							</c:forEach>
						</select>
					</td>
					<td colspan="2"><span class="fl" id="disciplineCateIdTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" width="110" rowspan="2">缩略图：</th>
					<td>
						大图：<input type="file" name="bigFile" id="bigFile"/>
					</td>
					<td colspan="2"><span class="fl" id="bigFileTip"></span></td>
				  </tr>
				  <tr>
					<td>
						小图：<input type="file" name="smallFile" id="smallFile"/>
					</td>
					<td colspan="2"><span class="fl" id="smallFileTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" width="110">作者：</th>
					<td><input name="video.author" type="text" class="text" id="author" /></td>
					<td colspan="2"><span class="fl" id="authorTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" width="110"><span style="color:red;">*</span> 视频来源：</th>
					<td>
						<select name="video.sourceId" id="sourceId">
							<option value="1">原创</option>
							<option value="2">转载</option>
							<option value="3">购买版权</option>
						</select>
					</td>
					<td colspan="2"><span class="fl" id="sourceIdTip"></span></td>
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
					<td colspan="2"><span class="fl" id="sourceIdTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" align="right"><span style="color:red;">*</span> 简介：</th>
					<td colspan="2" width="500"><textarea name="video.introduction" id="introduction" class="xheditor {tools:'mfull',width:500}" cols="60" rows="9"></textarea></td>
					<td><span class="fl" id="introductionTip"></span></td>
				  </tr>
				  <tr class="buttom">
					<th scope="row" align="right"></th>
					<td colspan="3">
						<input name="" type="submit" value="提 交" class="add_but fl" />
						<input name="" type="reset" value="重 置" class="add_but fl" />
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
