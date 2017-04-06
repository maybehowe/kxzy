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
 $("#txtRoleName").formValidator({onShowText:"请输入角色名",onShow:"请输入角色名",onFocus:"名称至少1个最多20个中文或英文字符",onCorrect:"该角色可以注册"}).inputValidator({min:1,max:20,onError:"你输入的角色名非法,请确认"}).regexValidator({regExp:"chineseenglish",dataType:"enum",onError:"角色名格式不正确"})
	    .ajaxValidator({
		dataType : "json",
		async : true,
		type : "post",
		url : "${contextPath}/manage/role/validateName.rt",
		data:{"add_role":true},
		success : function(result){
            if(result) return true;
			return "该角色名已存在，请更换角色名";
		},
		buttons: $("#button"),
		error: function(jqXHR, textStatus, errorThrown){alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);},
		onError : "该角色名已存在，请更换角色名"
	});
	$("#txtremark").formValidator({empty:true,onShow:"请输入备注",onFocus:"请输入100个字符或者50个汉字",onCorrect:"输入正确"}).inputValidator({max:100,onError:"输入的备注长度不正确，请确认"}); 
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
				<div class="tit">添加角色</div>
				<div class="line">角色详情：</div>
				<form id="roleForm" action="${contextPath}/manage/role/save.rt" method="post">
				<input type="hidden" name="viewId" value="${viewId }" />
				<input type="hidden" name="leftId" value="${leftId }" />
				<table width="96%" border="0" class="data">
				  <tr>
					<th scope="row" width="110"><span style="color:red;">*</span> 角色名称：</th>
					<td width="330"><input name="role.roleName" type="text" class="text" id="txtRoleName" /></td>
					<td><span class="fl" id="txtRoleNameTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" align="right">备注：</th>
					<td><input name="role.roleDes" type="text" class="text" id="txtremark" /></td>
					<td><span class="fl" id="txtremarkTip"></span></td>
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
