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
<script type="text/javascript">
/*<![CDATA[*/
$(document).ready(function(){
	$.formValidator.initConfig({formID:"channelForm",theme:"Default",submitOnce:true});
 $("#txtname").formValidator({onShowText:"请输入频道名称",onShow:"请输入频道名称",onFocus:"名称至少1个最多20个字符",onCorrect:"该频道名称可以使用"}).inputValidator({min:1,max:20,onErrorMax:"频道名称长度不能超过20个字符",onError:"频道名称名称不能为空,请确认"}).regexValidator({regExp:"chineseenglishnumber",dataType:"enum",onError:"频道名称只能为中英文或数字"})
	    .ajaxValidator({
		dataType : "json",
		async : true,
		type : "post",
		url : "${contextPath}/manage/channel/validateName.rt?pid="+"${channel.parent.id}",
		data:{"editChannel":"${channel.name}","add_channel":false},
		success : function(result){
            if(result) return true;
			return "该频道名称已存在，请更换频道名称";
		},
		buttons: $("#button"),
		error: function(jqXHR, textStatus, errorThrown){alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);},
		onError : "该频道名称已存在，请更换频道名称"
	});
 $("#siteUrl").formValidator({empty:true,onShow:"请输入栏目地址",onFocus:"栏目地址长度不能超过100个字符",onCorrect:"输入正确",onEmpty:"栏目地址可为空"}).inputValidator({max:100,onErrorMax:"栏目地址长度不能超过100个字符，请确认"}); 
 $("#englishName").formValidator({empty:true,onShow:"请输入栏目英文名称",onFocus:"栏目英文名称长度不能超过50字符",onCorrect:"输入正确",onEmpty:"栏目英文名称可为空"}).inputValidator({max:50,onErrorMax:"栏目英文名称长度不能超过50字符，请确认"}).regexValidator({regExp:"english",dataType:"enum",onError:"名称格式不正确"});
 $("#channel_image_path").formValidator({empty:true, onShow:"请选择 115px*95px 图片", onFocus:"请选择 115px*95px 图片", onCorrect:"选择正确",onEmpty:"栏目图片可为空" }) .inputValidator({max:100,onErrorMax:"图片名称长度不能超过100个字符",}).regexValidator({regExp:"picture",dataType:"enum",onError:"图片格式不正确"});
 $("#txtdescription").formValidator({empty:true,onShow:"请输入描述",onFocus:"请输入100个字符或者50个汉字",onCorrect:"输入正确",onEmpty:"栏目描述可为空"}).inputValidator({max:100,onError:"输入的描述长度不正确，请确认"}); 
}); 
/*]]>*/
</script>
<style>
table.data td input.text{ width:200px;}
</style>
</head>

<body>
<div class="wrapper" style="min-width:100%;">
	<div class="content" style="min-width:100%;">
			<!--[if lt IE 8]><div class="both"></div><![endif]-->
			<div class="main" style="min-height:100%;">
				<div class="tit">编辑栏目</div>
				<div class="line">栏目详情：</div>
				<form id="channelForm" action="${contextPath}/manage/channel/save.rt" enctype="multipart/form-data" method="post">
				<input type="hidden" name="channel.parent.id" id="pid" value="${pid }" />
				<input type="hidden" name="channel.id" id="channel_id" value="${channel.id}" />
				<table width="96%" border="0" class="data">
				  <tr>
					<th scope="row" width="110"><span style="color:red;">*</span> 栏目名称：</th>
					<td width="210"><input name="channel.name" type="text" class="text" id="txtname" value="${fn:escapeXml(channel.name)}" /></td>
					<td><span class="fl" id="txtnameTip"></span></td>
				  </tr>
				   <tr>
					<th scope="row" width="110">栏目URL：</th>
					<td><input name="channel.siteUrl" type="text" class="text" id="siteUrl" value="${fn:escapeXml(channel.siteUrl)}" /></td>
					<td><span class="fl" id="siteUrlTip"></span></td>
				  </tr>
				   <tr>
					<th scope="row" width="110">英文名：</th>
					<td><input name="channel.englishName" type="text" class="text" id="englishName" value="${channel.englishName }" /></td>
					<td><span class="fl" id="englishNameTip"></span></td>
				  </tr>
				  <tr>
				    <th scope="row" width="110">上传图片：</th>
				    <td><input type="file" class="text" id="channel_image_path" name="channelImagePath"/></td>
				   <td><span class="fl" id="channel_image_pathTip"></span></td>
			       </tr>
				  <tr>
				    <th scope="row" width="110">图片预览：</th>
				    <td>
				        <c:choose>
					      <c:when test="${channel.imgPath != null}">
					         <img src="${contextPath}${channel.imgPath}" alt="${channel.imgName}" width="115" height="95" />
					      </c:when>
					      <c:otherwise>
					          <img src="${contextPath}/images/load.jpg" alt="默认图" width="115" height="95" />
					      </c:otherwise>
					    </c:choose>
				    </td>
				   <td></td>
			       </tr>
				   <tr>
					<th scope="row" align="right">描述：</th>
					<td>
                      <textarea rows="4" cols="23" id="txtdescription" name="channel.description" style="overflow-y:auto" >${channel.description}</textarea>
                    </td>
					<td><span class="fl" id="txtdescriptionTip"></span></td>
				  </tr>
				  <tr class="buttom">
					<th scope="row" align="right"></th>
					<td colspan="2">
						<input name="" type="submit" value="提 交" class="add_but fl" />
						<a href="${contextPath}${returnUrl}" class="but_fanhui fl" style="height:24px;border:0px;font-size:14px;color:white;font-weight:bold;" target="_top">返 回</a>
					</td>
				  </tr>
				</table>
				</form>
			</div>
		<div class="cb"></div>
	</div>
</div>
</body>
</html>
