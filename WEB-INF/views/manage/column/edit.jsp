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
	$.formValidator.initConfig({formID:"roleForm",theme:"Default",submitOnce:true});
 $("#txtname").formValidator({onShow:"请输入频道名称",onShow:"请输入频道名称,只能输入中文",onFocus:"频道名称至少1个字符,最多12个字符",onCorrect:"该频道名称可以使用"}).inputValidator({min:1,max:12,onError:"你输入的频道名称非法,请确认"}).regexValidator({regExp:"chinese",dataType:"enum",onError:"频道名称格式不正确"})
	    .ajaxValidator({
		dataType : "json",
		async : true,
		type : "post",
		url : "${contextPath}/manage/channel/validateName.rt",
		success : function(json){
            if(json.flag) return true;
			return "该频道名称已存在，请更换频道名称";
		},
		buttons: $("#button"),
		error: function(jqXHR, textStatus, errorThrown){alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);},
		onError : "该频道名称已存在，请更换频道名称"
	}).defaultPassed();
	$("#txtchannelCode").formValidator({onShow:"请输入频道代码",onFocus:"请输入20个字符内的频道代码，例如：kx001",onCorrect:"输入正确"}).inputValidator({min:1,max:20,onError:"输入的频道代码长度不正确，请确认"}); 
	$("#txtsortId").formValidator({onShow:"请输入排序号！",onFocus:"只能输入数字，并且不重复。",onCorrect:"输入正确"}).inputValidator({max:2,onError:"输入的排序号长度不正确，请确认"}).regexValidator({regExp:"num1",dataType:"enum",onError:"排序号格式不正确"}); 
	$("#txtdescription").formValidator({empty:true,onShow:"请输入描述",onFocus:"请输入100个字符或者50个汉字",onCorrect:"输入正确"}).inputValidator({max:100,onError:"输入的描述长度不正确，请确认"}); 
}); 
/*]]>*/
</script>
</head>

<body>
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp" />
		<div class="right">
			<!--[if lt IE 8]><div class="both"></div><![endif]-->
			<div class="main">
				<div class="tit">添加频道</div>
				<div class="line">频道详情：</div>
				<form id="roleForm" action="${contextPath}/manage/column/save.rt" method="post">
				<input type="hidden" name="col.id" value="${col.id }" />
				<input type="hidden" name="viewId" value="${viewId }" />
				<input type="hidden" name="leftId" value="${leftId }" />
				<input type="hidden" name="col.channelId" value="${col.channelId }" />
				<table width="96%" border="0" class="data">
				  <tr>
					<th scope="row" width="110"><span style="color:red;">*</span> 频道名称：</th>
					<td><input name="col.name" type="text" class="text" id="txtname" value="${col.name }" /></td>
					<td><span class="fl" id="txtnameTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" align="right"><span style="color:red;">*</span> 频道代码：</th>
					<td><input name="col.columnCode" type="text" class="text" id="txtcolumnCode" value="${col.columnCode }" /></td>
					<td><span class="fl" id="txtcolumnCodeTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" align="right"><span style="color:red;">*</span> 排序号：</th>
					<td><input name="col.sortId" type="text" class="text" id="txtsortId" value="${col.sortId }" /></td>
					<td><span class="fl" id="txtsortIdTip"></span></td>
				  </tr>
				   <tr>
					<th scope="row" align="right">描述：</th>
					<td><input name="col.description" type="text" class="text" id="txtdescription" value="${col.description }" /></td>
					<td><span class="fl" id="txtdescriptionTip"></span></td>
				  </tr>
				  <tr class="buttom">
					<th scope="row" align="right"></th>
					<td>
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
