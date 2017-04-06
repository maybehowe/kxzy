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
	$.formValidator.initConfig({formID:"resCategoryForm",theme:"Default",submitOnce:true});
 $("#name").formValidator({onShowText:"请输入资源名称",onShow:"请输入资源名称",onFocus:"资源名称至少1个字符,最多20个字符",onCorrect:"该资源名称可以使用"}).inputValidator({min:1,max:20,onError:"你输入的资源名称长度名非法,请确认"}).regexValidator({regExp:"chineseenglish",dataType:"enum",onError:"资源名称格式不正确"})
	    .ajaxValidator({
		dataType : "json",
		async : true,
		type : "post",
		url : "${contextPath}/manage/resCategory/validateName.rt",
		success : function(json){
            if(json.flag) return true;
			return "该资源名称已存在，请更换资源名称";
		},
		buttons: $("#button"),
		error: function(jqXHR, textStatus, errorThrown){alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);},
		onError : "该资源名称已存在，请更换资源名称"
	}).defaultPassed();
	$("#resTable").formValidator({onShow:"请输入关联表",onFocus:"请输入关联表名,格式如：t_tableName",onCorrect:"输入正确"}).inputValidator({min:1,max:100,onError:"输入的关联表名长度不正确，请确认"}).regexValidator({regExp:"letterUnderline",dataType:"enum",onError:"关联表名格式不正确"}); 
	$("#remark").formValidator({empty:true,onShow:"请输入备注",onFocus:"请输入100个字符或者50个汉字",onCorrect:"输入正确"}).inputValidator({max:100,onError:"输入的描述长度不正确，请确认"}); 
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
				<div class="tit">添加资源类别</div>
				<div class="line">资源类别详情：</div>
				<form id="resCategoryForm" action="${contextPath}/manage/resCategory/save.rt" method="post">
				<input type="hidden" name="viewId" value="${viewId }" />
				<input type="hidden" name="leftId" value="${leftId }" />
				<table width="96%" border="0" class="data">
				  <tr>
					<th scope="row" width="110"><span style="color:red;">*</span> 资源类别名称：</th>
					<td width="330"><input name="resCate.name" type="text" class="text" id="name" /></td>
					<td><span class="fl" id="nameTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" align="right"><span style="color:red;">*</span> 关联资源表</th>
					<td><input name="resCate.resTable" type="text" class="text" id="resTable" /></td>
					<td><span class="fl" id="resTableTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" align="right">备注：</th>
					<td><input name="resCate.remark" type="text" class="text" id="remark" /></td>
					<td><span class="fl" id="remarkTip"></span></td>
				  </tr>
				  <tr class="buttom">
					<th scope="row" align="right"></th>
					<td colspan="2">
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
